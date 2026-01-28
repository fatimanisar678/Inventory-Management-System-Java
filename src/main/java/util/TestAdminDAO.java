package util;

import dao.AdminDAO;

public class TestAdminDAO {
    public static void main(String[] args) {

        String testUsername = "admin"; // put your test username here
        String testPassword = "admin123"; // put your test password here

        boolean valid = AdminDAO.validate(testUsername, testPassword);

        if (valid) {
            System.out.println("✅ User found! Login should succeed.");
        } else {
            System.out.println("❌ User NOT found! Check username/password or table.");
        }
    }
}
