package util;

import java.sql.Connection;
import java.sql.SQLException;

public class TestDB {

    public static void main(String[] args) {
        try (Connection con = DBConnection.getConnection()) {
            if (con != null && !con.isClosed()) {
                System.out.println("✅ Database connection successful!");
            } else {
                System.out.println("❌ Failed to connect to database.");
            }
        } catch (SQLException e) {
            System.out.println("❌ Error connecting to database:");
            e.printStackTrace();
        }
    }
}
