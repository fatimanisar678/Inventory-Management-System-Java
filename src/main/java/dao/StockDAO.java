package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Stock;
import util.DBConnection;

public class StockDAO {

    // Add stock IN or OUT
    public static boolean addStock(Stock s) {
        boolean status = false;
        String sql = "INSERT INTO stock_transactions(product_id, type, quantity) VALUES(?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, s.getProductId());
            ps.setString(2, s.getType());
            ps.setInt(3, s.getQuantity());
            status = ps.executeUpdate() > 0;

            // Update product quantity
            String updateSql = s.getType().equals("IN") 
                    ? "UPDATE products SET quantity = quantity + ? WHERE id = ?" 
                    : "UPDATE products SET quantity = quantity - ? WHERE id = ?";
            try (PreparedStatement ps2 = con.prepareStatement(updateSql)) {
                ps2.setInt(1, s.getQuantity());
                ps2.setInt(2, s.getProductId());
                ps2.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return status;
    }

    // Get all stock transactions
    public static List<Stock> getAllStock() {
        List<Stock> list = new ArrayList<>();
        String sql = "SELECT st.*, p.name AS product_name " +
                     "FROM stock_transactions st " +
                     "JOIN products p ON st.product_id = p.id " +
                     "ORDER BY st.date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Stock s = new Stock();
                s.setId(rs.getInt("id"));
                s.setProductId(rs.getInt("product_id"));
                s.setType(rs.getString("type"));
                s.setQuantity(rs.getInt("quantity"));
                s.setDate(rs.getTimestamp("date"));
                s.setProductName(rs.getString("product_name"));
                list.add(s);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
