package dao;

import dto.Account;
import dto.FrequentViolation;
import dto.PenaltyTicket;
import dto.Vehicle;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class PenaltyTicketDAO {

    // Lấy danh sách phiếu phạt của tài khoản để View tình trạng đóng phạt offline
    public List<PenaltyTicket> getTicketsByAccountId(int accountId) {
        List<PenaltyTicket> list = new ArrayList<>();
        String sql = "SELECT * "
                + "FROM Penalty_Ticket "
                + "WHERE account_id = ? "
                + "ORDER BY created_at DESC";
        try ( Connection con = DBUtils.getConnection();  PreparedStatement st = con.prepareStatement(sql)) {
            st.setInt(1, accountId);
            try ( ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    PenaltyTicket ticket = new PenaltyTicket();
                    ticket.setTicketId(rs.getInt("ticket_id"));
                    ticket.setAccountId(rs.getInt("account_id"));
                    ticket.setFineAmount(rs.getDouble("fine_amount"));
                    ticket.setStatus(rs.getString("status"));
                    ticket.setCreatedAt(rs.getDate("created_at"));
                    ticket.setPaymentDate(rs.getDate("payment_date"));

                    int resolvedBy = rs.getInt("resolved_by");
                    if (!rs.wasNull()) {
                        ticket.setResolvedBy(resolvedBy);
                    }

                    list.add(ticket);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<FrequentViolation> getFrequentViolations() {

        List<FrequentViolation> list = new ArrayList<>();

        String sql
                = "SELECT "
                + "a.account_id, "
                + "a.full_name, "
                + "a.email, "
                + "v.vehicle_id, "
                + "v.license_plate, "
                + "v.brand, "
                + "COUNT(ve.event_id) AS violation_count, "
                + "CASE "
                + "WHEN EXISTS ( "
                + "SELECT 1 FROM Penalty_Ticket pt "
                + "WHERE pt.account_id = a.account_id "
                + "AND pt.status = 'Unpaid') "
                + "THEN 1 ELSE 0 END AS has_ticket "
                + "FROM Violation_Event ve "
                + "JOIN Vehicle v ON ve.vehicle_id = v.vehicle_id "
                + "JOIN Account a ON v.account_id = a.account_id "
                + "WHERE "
                + "ve.admin_status = 'Notified' "
                + "AND YEAR(ve.timestamp) = YEAR(GETDATE()) "
                + "AND MONTH(ve.timestamp) = MONTH(GETDATE()) "
                + "GROUP BY "
                + "a.account_id, "
                + "a.full_name, "
                + "a.email, "
                + "v.vehicle_id, "
                + "v.license_plate, "
                + "v.brand "
                + "HAVING COUNT(ve.event_id) >= 3 "
                + "ORDER BY violation_count DESC";

        try ( Connection con = DBUtils.getConnection();  PreparedStatement st = con.prepareStatement(sql);  ResultSet rs = st.executeQuery()) {

            while (rs.next()) {

                Account account = new Account();
                account.setAccountID(rs.getInt("account_id"));
                account.setFullName(rs.getString("full_name"));
                account.setEmail(rs.getString("email"));

                Vehicle vehicle = new Vehicle();
                vehicle.setVehicleId(rs.getInt("vehicle_id"));
                vehicle.setLicensePlate(rs.getString("license_plate"));
                vehicle.setBrand(rs.getString("brand"));

                FrequentViolation fv = new FrequentViolation();
                fv.setAccount(account);
                fv.setVehicle(vehicle);
                fv.setViolationCount(rs.getInt("violation_count"));
                fv.setHasUnpaidTicket(rs.getBoolean("has_ticket"));

                list.add(fv);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int createPenaltyTicket(int accountId) {

        String sql
                = "SELECT TOP 1 vehicle_type "
                + "FROM Vehicle "
                + "WHERE account_id=?";

        try ( Connection con = DBUtils.getConnection()) {

            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, accountId);

            ResultSet rs = st.executeQuery();

            double fine = 0;

            if (rs.next()) {

                String type = rs.getString("vehicle_type");

                if (type.equalsIgnoreCase("Motorbike")) {
                    fine = 250000;
                } else {
                    fine = 1000000;
                }

            }

            String insert
                    = "INSERT INTO Penalty_Ticket(account_id,fine_amount,status) "
                    + "VALUES(?,?,'Unpaid')";

            PreparedStatement ps
                    = con.prepareStatement(insert,
                            PreparedStatement.RETURN_GENERATED_KEYS);

            ps.setInt(1, accountId);
            ps.setDouble(2, fine);

            ps.executeUpdate();

            ResultSet key = ps.getGeneratedKeys();

            if (key.next()) {
                return key.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }

    public boolean attachTicketToViolations(int accountId, int ticketId) {

        String sql
                = "UPDATE Violation_Event "
                + "SET ticket_id=? "
                + "WHERE ticket_id IS NULL "
                + "AND vehicle_id IN "
                + "(SELECT vehicle_id FROM Vehicle WHERE account_id=?)";

        try ( Connection con = DBUtils.getConnection();  PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, ticketId);
            st.setInt(2, accountId);

            return st.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public FrequentViolation getPenaltyInfo(int accountId) {

        String sql
                = "SELECT TOP 1\n"
                + "a.account_id,\n"
                + "a.full_name,\n"
                + "a.email,\n"
                + "\n"
                + "v.vehicle_id,\n"
                + "v.license_plate,\n"
                + "v.brand,\n"
                + "v.vehicle_type,\n"
                + "\n"
                + "(\n"
                + "SELECT COUNT(*)\n"
                + "FROM Violation_Event ve\n"
                + "WHERE ve.vehicle_id=v.vehicle_id\n"
                + "AND MONTH(ve.timestamp)=MONTH(GETDATE())\n"
                + "AND YEAR(ve.timestamp)=YEAR(GETDATE())\n"
                + "AND ve.admin_status='Notified'\n"
                + ") AS totalViolation\n"
                + "\n"
                + "FROM Account a\n"
                + "JOIN Vehicle v\n"
                + "ON a.account_id=v.account_id\n"
                + "\n"
                + "WHERE a.account_id=?";

        try ( Connection con = DBUtils.getConnection();  PreparedStatement st = con.prepareStatement(sql)) {

            st.setInt(1, accountId);

            ResultSet rs = st.executeQuery();

            if (rs.next()) {

                Account a = new Account();
                a.setAccountID(rs.getInt("account_id"));
                a.setFullName(rs.getString("full_name"));
                a.setEmail(rs.getString("email"));

                Vehicle v = new Vehicle();
                v.setVehicleId(rs.getInt("vehicle_id"));
                v.setLicensePlate(rs.getString("license_plate"));
                v.setVehicleType(rs.getString("vehicle_type"));
                v.setBrand(rs.getString("brand"));

                FrequentViolation f = new FrequentViolation();

                f.setAccount(a);
                f.setVehicle(v);
                f.setViolationCount(rs.getInt("totalViolation"));

                return f;

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;

    }

}
