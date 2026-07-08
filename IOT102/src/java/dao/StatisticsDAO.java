package dao;

import dto.Statistics;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class StatisticsDAO {

    //==========================
    // Dashboard Statistics
    //==========================

    public Statistics getDashboardStatistics() {

        Statistics stats = new Statistics();

        try (Connection con = DBUtils.getConnection()) {

            //---------------------------
            // Today's violations
            //---------------------------

            String sql =
                    "SELECT COUNT(*) "
                    + "FROM Violation_Event "
                    + "WHERE CAST(timestamp AS DATE)=CAST(GETDATE() AS DATE)";

            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                stats.setTodayViolations(rs.getInt(1));
            }

            //---------------------------
            // This month violations
            //---------------------------

            sql =
                    "SELECT COUNT(*) "
                    + "FROM Violation_Event "
                    + "WHERE MONTH(timestamp)=MONTH(GETDATE()) "
                    + "AND YEAR(timestamp)=YEAR(GETDATE())";

            st = con.prepareStatement(sql);
            rs = st.executeQuery();

            if (rs.next()) {
                stats.setMonthViolations(rs.getInt(1));
            }

            //---------------------------
            // Unpaid Tickets
            //---------------------------

            sql =
                    "SELECT COUNT(*) "
                    + "FROM Penalty_Ticket "
                    + "WHERE status='Unpaid'";

            st = con.prepareStatement(sql);
            rs = st.executeQuery();

            if (rs.next()) {
                stats.setUnpaidTickets(rs.getInt(1));
            }

            //---------------------------
            // Revenue
            //---------------------------

            sql =
                    "SELECT ISNULL(SUM(fine_amount),0) "
                    + "FROM Penalty_Ticket "
                    + "WHERE status='Paid'";

            st = con.prepareStatement(sql);
            rs = st.executeQuery();

            if (rs.next()) {
                stats.setTotalRevenue(rs.getDouble(1));
            }

            //---------------------------
            // Minor
            //---------------------------

            sql =
                    "SELECT COUNT(*) "
                    + "FROM Violation_Event "
                    + "WHERE (recorded_speed-speed_limit)<10";

            st = con.prepareStatement(sql);
            rs = st.executeQuery();

            if (rs.next()) {
                stats.setMinorCount(rs.getInt(1));
            }

            //---------------------------
            // Major
            //---------------------------

            sql =
                    "SELECT COUNT(*) "
                    + "FROM Violation_Event "
                    + "WHERE (recorded_speed-speed_limit)>=10 "
                    + "AND (recorded_speed-speed_limit)<=20";

            st = con.prepareStatement(sql);
            rs = st.executeQuery();

            if (rs.next()) {
                stats.setMajorCount(rs.getInt(1));
            }

            //---------------------------
            // Severe
            //---------------------------

            sql =
                    "SELECT COUNT(*) "
                    + "FROM Violation_Event "
                    + "WHERE (recorded_speed-speed_limit)>20";

            st = con.prepareStatement(sql);
            rs = st.executeQuery();

            if (rs.next()) {
                stats.setSevereCount(rs.getInt(1));
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return stats;

    }

    //==========================
    // Chart Labels
    //==========================

    public String getChartLabels() {

        List<String> labels = new ArrayList<>();

        String sql =
                "SELECT TOP 6 "
                + "DATENAME(MONTH,timestamp) AS monthName "
                + "FROM Violation_Event "
                + "GROUP BY "
                + "YEAR(timestamp),"
                + "MONTH(timestamp),"
                + "DATENAME(MONTH,timestamp) "
                + "ORDER BY "
                + "YEAR(timestamp),"
                + "MONTH(timestamp)";

        try (Connection con = DBUtils.getConnection();
                PreparedStatement st = con.prepareStatement(sql);
                ResultSet rs = st.executeQuery()) {

            while (rs.next()) {

                labels.add("'" + rs.getString("monthName") + "'");

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "[" + String.join(",", labels) + "]";

    }

    //==========================
    // Chart Data
    //==========================

    public String getChartData() {

        List<String> values = new ArrayList<>();

        String sql =
                "SELECT TOP 6 "
                + "COUNT(*) total "
                + "FROM Violation_Event "
                + "GROUP BY "
                + "YEAR(timestamp),"
                + "MONTH(timestamp) "
                + "ORDER BY "
                + "YEAR(timestamp),"
                + "MONTH(timestamp)";

        try (Connection con = DBUtils.getConnection();
                PreparedStatement st = con.prepareStatement(sql);
                ResultSet rs = st.executeQuery()) {

            while (rs.next()) {

                values.add(rs.getString("total"));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "[" + String.join(",", values) + "]";

    }

}