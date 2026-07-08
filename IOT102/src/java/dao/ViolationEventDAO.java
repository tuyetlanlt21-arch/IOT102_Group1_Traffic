package dao;

import dto.ViolationEvent;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;
import java.sql.Date;

public class ViolationEventDAO {

    // Lấy danh sách vi phạm tốc độ của tài khoản để View lên bảng "My Violations"
    public List<ViolationEvent> getViolationsByAccountId(int accountId) {
        List<ViolationEvent> list = new ArrayList<>();
        String sql = "SELECT ve.*, v.license_plate, v.brand "
                + "FROM Violation_Event ve "
                + "JOIN Vehicle v ON ve.vehicle_id = v.vehicle_id "
                + "WHERE v.account_id = ? "
                + "ORDER BY ve.timestamp DESC";
        try ( Connection con = DBUtils.getConnection();  PreparedStatement st = con.prepareStatement(sql)) {
            st.setInt(1, accountId);
            try ( ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    ViolationEvent ve = new ViolationEvent();
                    ve.setEventId(rs.getInt("event_id"));
                    ve.setVehicleId(rs.getInt("vehicle_id"));
                    ve.setGuestLicensePlate(rs.getString("guest_license_plate"));
                    ve.setRecordedSpeed(rs.getDouble("recorded_speed"));
                    ve.setSpeedLimit(rs.getDouble("speed_limit"));
                    ve.setImageUrl(rs.getString("image_url"));
                    ve.setTimestamp(rs.getDate("timestamp"));
                    ve.setAdminStatus(rs.getString("admin_status"));

                    int ticketId = rs.getInt("ticket_id");
                    if (!rs.wasNull()) {
                        ve.setTicketId(ticketId);
                    }

                    ve.setLicensePlate(rs.getString("license_plate"));
                    ve.setBrand(rs.getString("brand"));

                    list.add(ve);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private static final String BASE_SELECT
            = "SELECT "
            + "ve.event_id, "
            + "ve.vehicle_id, "
            + "ve.recorded_speed, "
            + "ve.speed_limit, "
            + "ve.image_url, "
            + "ve.timestamp, "
            + "ve.admin_status, "
            + "ve.ticket_id, "
            + "v.license_plate, "
            + "v.brand, "
            + "a.full_name, "
            + "a.email "
            + "FROM Violation_Event ve "
            + "INNER JOIN Vehicle v ON ve.vehicle_id = v.vehicle_id "
            + "INNER JOIN Account a ON v.account_id = a.account_id ";

    //==================================================
    // Mapping ResultSet -> DTO
    //==================================================
    private ViolationEvent extractViolation(ResultSet rs) throws Exception {

        ViolationEvent ve = new ViolationEvent();

        ve.setEventId(rs.getInt("event_id"));
        ve.setVehicleId(rs.getInt("vehicle_id"));
        ve.setRecordedSpeed(rs.getDouble("recorded_speed"));
        ve.setSpeedLimit(rs.getDouble("speed_limit"));
        ve.setImageUrl(rs.getString("image_url"));
        ve.setTimestamp(rs.getDate("timestamp"));
        ve.setAdminStatus(rs.getString("admin_status"));

        int ticketId = rs.getInt("ticket_id");
        if (!rs.wasNull()) {
            ve.setTicketId(ticketId);
        }

        ve.setLicensePlate(rs.getString("license_plate"));
        ve.setBrand(rs.getString("brand"));

        ve.setOwnerName(rs.getString("full_name"));
        ve.setOwnerEmail(rs.getString("email"));

        return ve;
    }

    //==================================================
    // Lấy toàn bộ vi phạm
    //==================================================
    public List<ViolationEvent> getAllViolations() {

        List<ViolationEvent> list = new ArrayList<>();

        String sql = BASE_SELECT
                + "ORDER BY ve.timestamp DESC";

        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(extractViolation(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    //==================================================
    // Lọc
    //==================================================
    public List<ViolationEvent> filterViolations(String startDate,
            String endDate,
            String status) {

        List<ViolationEvent> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(BASE_SELECT);

        sql.append(" WHERE 1=1 ");

        if (startDate != null && !startDate.trim().isEmpty()) {
            sql.append(" AND CAST(ve.timestamp AS DATE) >= ? ");
        }

        if (endDate != null && !endDate.trim().isEmpty()) {
            sql.append(" AND CAST(ve.timestamp AS DATE) <= ? ");
        }

        if (status != null
                && !status.trim().isEmpty()
                && !status.equals("All")) {

            sql.append(" AND ve.admin_status = ? ");
        }

        sql.append(" ORDER BY ve.timestamp DESC");

        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int index = 1;

            if (startDate != null && !startDate.trim().isEmpty()) {
                ps.setDate(index++, Date.valueOf(startDate));
            }

            if (endDate != null && !endDate.trim().isEmpty()) {
                ps.setDate(index++, Date.valueOf(endDate));
            }

            if (status != null
                    && !status.trim().isEmpty()
                    && !status.equals("All")) {

                ps.setString(index++, status);
            }

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    list.add(extractViolation(rs));
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    //==================================================
    // Lấy chi tiết
    //==================================================
    public ViolationEvent getViolationById(int eventId) {

        String sql = BASE_SELECT
                + "WHERE ve.event_id = ?";

        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, eventId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return extractViolation(rs);
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    //==================================================
    // Update trạng thái
    //==================================================
    public boolean updateViolationStatus(int eventId,
            String status) {

        String sql = "UPDATE Violation_Event "
                + "SET admin_status=? "
                + "WHERE event_id=?";

        try (Connection con = DBUtils.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, eventId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


}
