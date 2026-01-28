package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;
import model.Product;

public class ProductDAO {

    // Get all products with category names
    public static List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.name AS category_name FROM products p " +
                     "JOIN categories c ON p.category_id = c.id ORDER BY p.id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name").trim());
                p.setCategoryId(rs.getInt("category_id"));
                p.setCategoryName(rs.getString("category_name"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                list.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Add product
    public static boolean addProduct(Product p) {
        String sql = "INSERT INTO products(name, category_id, quantity, price) VALUES(?,?,?,?)";
        boolean status = false;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getName().trim());
            ps.setInt(2, p.getCategoryId());
            ps.setInt(3, p.getQuantity());
            ps.setDouble(4, p.getPrice());
            status = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return status;
    }

    // Update product
    public static boolean updateProduct(Product p) {
        String sql = "UPDATE products SET name=?, category_id=?, quantity=?, price=? WHERE id=?";
        boolean status = false;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getName().trim());
            ps.setInt(2, p.getCategoryId());
            ps.setInt(3, p.getQuantity());
            ps.setDouble(4, p.getPrice());
            ps.setInt(5, p.getId());
            status = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return status;
    }

    // Delete product
    public static boolean deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE id=?";
        boolean status = false;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            status = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return status;
    }

    // Get product by id
    public static Product getProductById(int id) {
        Product p = null;
        String sql = "SELECT p.*, c.name AS category_name FROM products p " +
                     "JOIN categories c ON p.category_id = c.id WHERE p.id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new Product();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name").trim());
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setCategoryName(rs.getString("category_name"));
                    p.setQuantity(rs.getInt("quantity"));
                    p.setPrice(rs.getDouble("price"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return p;
    }

    // Get product quantity by id (for stock validation)
    public static int getProductQuantity(int productId) {
        int qty = 0;
        String sql = "SELECT quantity FROM products WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    qty = rs.getInt("quantity");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return qty;
    }
}
