package controller;

import java.io.IOException;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import dao.StockDAO;
import dao.ProductDAO;
import model.Stock;

public class StockServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String contextPath = request.getContextPath();

        if ("add".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("product_id"));
            String type = request.getParameter("type");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Validation for OUT
            if ("OUT".equals(type)) {
                int currentQty = ProductDAO.getProductQuantity(productId);
                if (quantity > currentQty) {
                    // Cannot go below 0
                    response.sendRedirect(contextPath + "/jsp/stock/stock.jsp?error=1");
                    return;
                }
            }

            Stock s = new Stock();
            s.setProductId(productId);
            s.setType(type);
            s.setQuantity(quantity);
            StockDAO.addStock(s);
        }

        response.sendRedirect(contextPath + "/jsp/stock/stock.jsp");
    }
}
