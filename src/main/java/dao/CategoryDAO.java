package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;
import model.Category;

public class CategoryDAO {

    
    public static List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories ORDER BY id DESC"; 

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category c = new Category();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                list.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    
    public static boolean addCategory(Category c) {
        boolean status = false;
        String sql = "INSERT INTO categories(name) VALUES(?)"; // updated table name

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, c.getName().trim());
            status = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return status;
    }

    
    public static boolean updateCategory(Category c) {
        boolean status = false;
        String sql = "UPDATE categories SET name=? WHERE id=?"; // updated table name

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, c.getName().trim());
            ps.setInt(2, c.getId());
            status = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return status;
    }

    // Delete category
    public static boolean deleteCategory(int id) {
        boolean status = false;
        String sql = "DELETE FROM categories WHERE id=?"; // updated table name

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            status = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return status;
    }

    // Get category by id
    public static Category getCategoryById(int id) {
        Category c = null;
        String sql = "SELECT * FROM categories WHERE id=?"; // updated table name

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    c = new Category();
                    c.setId(rs.getInt("id"));
                    c.setName(rs.getString("name"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return c;
    }
}
