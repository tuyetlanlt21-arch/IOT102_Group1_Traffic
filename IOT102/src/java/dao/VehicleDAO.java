package dao;

import dto.Vehicle;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class VehicleDAO {

    public boolean isLicensePlateExists(String plate) {

        String sql = "SELECT vehicle_id FROM Vehicle WHERE license_plate = ?";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, plate);
            ResultSet rs = st.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int createVehicle(Vehicle v) {
        String sql = "INSERT INTO Vehicle("
                + "license_plate,"
                + "account_id,"
                + "brand,"
                + "vehicle_type,"
                + "status"
                + ") "
                + "VALUES(?,?,?,?,?)";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, v.getLicensePlate());
            st.setInt(2, v.getAccountId());
            st.setString(3, v.getBrand());
            st.setString(4, v.getVehicleType());
            st.setString(5, v.getStatus());
            return st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Vehicle getVeByPlate(String plate) {
        String sql = "SELECT * "
                + "FROM Vehicle "
                + "WHERE license_plate = ?";
        try ( Connection con = DBUtils.getConnection();  PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, plate);
            try ( ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Vehicle v = new Vehicle();
                    v.setVehicleId(rs.getInt("vehicle_id"));
                    v.setLicensePlate(rs.getString("license_plate"));
                    v.setAccountId(rs.getInt("account_id"));
                    v.setBrand(rs.getString("brand"));
                    v.setVehicleType(rs.getString("vehicle_type"));
                    v.setStatus(rs.getString("status"));
                    return v;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int reactivateVehicle(Vehicle v) {
        String sql = "UPDATE Vehicle SET "
                + "brand = ?, "
                + "vehicle_type = ?, "
                + "status = 'Active' "
                + "WHERE license_plate = ? AND account_id = ?";
        try ( Connection con = DBUtils.getConnection();  PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, v.getBrand());
            st.setString(2, v.getVehicleType());
            st.setString(3, v.getLicensePlate());
            st.setInt(4, v.getAccountId());
            return st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean isLicensePlateExistsForOther(String plate, int vehicleId) {
        String sql = "SELECT vehicle_id "
                + "FROM Vehicle "
                + "WHERE license_plate = ? "
                + "AND vehicle_id <> ?";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, plate);
            st.setInt(2, vehicleId);
            ResultSet rs = st.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Vehicle getVehicleByID(int vehicleId) {
        String sql = "SELECT * FROM Vehicle WHERE vehicle_id = ?";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, vehicleId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Vehicle v = new Vehicle();
                v.setVehicleId(rs.getInt("vehicle_id"));
                v.setLicensePlate(rs.getString("license_plate"));
                v.setAccountId(rs.getInt("account_id"));
                v.setBrand(rs.getString("brand"));
                v.setVehicleType(rs.getString("vehicle_type"));
                v.setStatus(rs.getString("status"));
                return v;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int updateVehicle(Vehicle v) {
        int result = 0;
        String sql = "UPDATE Vehicle "
                + "SET license_plate = ?, "
                + "brand = ?, "
                + "vehicle_type = ?, "
                + "status = ? "
                + "WHERE vehicle_id = ?";
        try {
            Connection cn = DBUtils.getConnection();
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, v.getLicensePlate());
            st.setString(2, v.getBrand());
            st.setString(3, v.getVehicleType());
            st.setString(4, v.getStatus());
            st.setInt(5, v.getVehicleId());
            result = st.executeUpdate();
            cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int deleteVehicle(int vehicleId) {
        String sql
                = "UPDATE Vehicle "
                + "SET status = 'Inactive' "
                + "WHERE vehicle_id = ? "
                + "AND status = 'Active'";
        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, vehicleId);
            return st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    // Thêm vào trong class VehicleDAO.java (nếu chưa có)

    public List<Vehicle> getVehiclesByAccountId(int accountId) {
        List<Vehicle> list = new ArrayList<>();
        String sql = "SELECT * FROM Vehicle WHERE account_id = ? AND status <> 'Inactive'";
        try ( Connection con = DBUtils.getConnection();  PreparedStatement st = con.prepareStatement(sql)) {
            st.setInt(1, accountId);
            try ( ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Vehicle v = new Vehicle();
                    v.setVehicleId(rs.getInt("vehicle_id"));
                    v.setLicensePlate(rs.getString("license_plate"));
                    v.setAccountId(rs.getInt("account_id"));
                    v.setBrand(rs.getString("brand"));
                    v.setVehicleType(rs.getString("vehicle_type"));
                    v.setStatus(rs.getString("status"));
                    list.add(v);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
