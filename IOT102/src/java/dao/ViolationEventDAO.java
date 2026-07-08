package dao;

import dto.ViolationEvent;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

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
}