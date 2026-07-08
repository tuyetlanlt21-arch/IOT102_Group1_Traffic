package dao;

import dto.PenaltyTicket;
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
}
