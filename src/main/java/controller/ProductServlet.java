package controller;

import java.io.IOException;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import dao.ProductDAO;
import model.Product;

public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String contextPath = request.getContextPath();

        if ("add".equals(action)) {
            Product p = new Product();
            p.setName(request.getParameter("name"));
            p.setCategoryId(Integer.parseInt(request.getParameter("category_id")));
            p.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            p.setPrice(Double.parseDouble(request.getParameter("price")));
            ProductDAO.addProduct(p);

        } else if ("edit".equals(action)) {
            Product p = new Product();
            p.setId(Integer.parseInt(request.getParameter("id")));
            p.setName(request.getParameter("name"));
            p.setCategoryId(Integer.parseInt(request.getParameter("category_id")));
            p.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            p.setPrice(Double.parseDouble(request.getParameter("price")));
            ProductDAO.updateProduct(p);

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductDAO.deleteProduct(id);
        }

        // Redirect to product list page after action
        response.sendRedirect(contextPath + "/jsp/product/list.jsp");
    }
}
