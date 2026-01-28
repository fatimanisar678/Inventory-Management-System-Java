package controller;

import java.io.IOException;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import dao.AdminDAO;

public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

       
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null) username = username.trim();
        if (password != null) password = password.trim();

        

        
        boolean valid = AdminDAO.validate(username, password);
       

        
        String contextPath = request.getContextPath();

        
        if (valid) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", username);

            System.out.println("Login successful! Redirecting to dashboard...");
            response.sendRedirect(contextPath + "/jsp/dashboard.jsp");
        } else {
            System.out.println("Login failed! Redirecting to login page...");
            response.sendRedirect(contextPath + "/jsp/login.jsp?error=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to login page
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
    }
}
