package controller;

import java.io.IOException;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import dao.CategoryDAO;
import model.Category;

public class CategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String contextPath = request.getContextPath();

        if ("add".equals(action)) {
            String name = request.getParameter("name").trim();
            Category c = new Category();
            c.setName(name);
            CategoryDAO.addCategory(c);
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name").trim();
            Category c = new Category();
            c.setId(id);
            c.setName(name);
            CategoryDAO.updateCategory(c);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            CategoryDAO.deleteCategory(id);
        }

        response.sendRedirect(contextPath + "/jsp/category/list.jsp");
    }
}
