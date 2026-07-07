package dao;

import dto.Account;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import utils.DBUtils;

public class AccountDAO {

    public int createAccount(Account account) {
        int result = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            String sql = "INSERT INTO Account("
                    + "username,"
                    + "password,"
                    + "full_name,"
                    + "email,"
                    + "role_id,"
                    + "is_verified"
                    + ") VALUES(?,?,?,?,?,?)";

            PreparedStatement st = cn.prepareStatement(sql);

            st.setString(1, account.getUsername());
            st.setString(2, account.getPassword());
            st.setString(3, account.getFullName());
            st.setString(4, account.getEmail());
            st.setInt(5, account.getRoleID());
            st.setBoolean(6, account.isIsVerified());

            result = st.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            try {

                if (cn != null) {
                    cn.close();
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

        }

        return result;
    }

    private Account getAccountField(String sql, String value) {

        Connection cn = null;
        Account result = null;

        try {

            cn = DBUtils.getConnection();

            if (cn != null) {

                PreparedStatement st = cn.prepareStatement(sql);

                st.setString(1, value);

                ResultSet rs = st.executeQuery();

                if (rs.next()) {

                    result = new Account(
                            rs.getString("username"),
                            rs.getString("full_name"),
                            rs.getString("password"),
                            rs.getString("email"),
                            rs.getInt("role_id"),
                            rs.getBoolean("is_verified"),
                            rs.getDate("created_at")
                    );

                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            try {

                if (cn != null) {
                    cn.close();
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

        }

        return result;

    }

    public Account getAccountByUsername(String username) {

        String sql = "SELECT * FROM Account WHERE username = ?";

        return getAccountField(sql, username);

    }

    public Account getAccountByEmail(String email) {

        String sql = "SELECT * FROM Account WHERE email = ?";

        return getAccountField(sql, email);

    }

}