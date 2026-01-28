package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;
import model.Report;

public class ReportDAO {

    public static List<Report> getInventoryReport() {
        List<Report> list = new ArrayList<>();
        String sql = "SELECT p.id AS product_id, p.name AS product_name, c.name AS category_name, " +
                     "IFNULL(SUM(CASE WHEN st.type='IN' THEN st.quantity ELSE 0 END),0) AS total_in, " +
                     "IFNULL(SUM(CASE WHEN st.type='OUT' THEN st.quantity ELSE 0 END),0) AS total_out, " +
                     "p.quantity AS current_quantity " +
                     "FROM products p " +
                     "JOIN categories c ON p.category_id = c.id " +
                     "LEFT JOIN stock_transactions st ON p.id = st.product_id " +
                     "GROUP BY p.id, p.name, c.name, p.quantity " +
                     "ORDER BY p.id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Report r = new Report();
                r.setProductId(rs.getInt("product_id"));
                r.setProductName(rs.getString("product_name"));
                r.setCategoryName(rs.getString("category_name"));
                r.setTotalIn(rs.getInt("total_in"));
                r.setTotalOut(rs.getInt("total_out"));
                r.setCurrentQuantity(rs.getInt("current_quantity"));
                list.add(r);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
