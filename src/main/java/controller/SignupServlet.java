package controller;

import java.io.IOException;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import dao.AdminDAO;
import model.Admin;

public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();

        System.out.println("Signup attempt: " + username);

        Admin admin = new Admin();
        admin.setUsername(username);
        admin.setPassword(password);

        boolean success = AdminDAO.signup(admin);

        String contextPath = request.getContextPath();
        if (success) {
            System.out.println("Signup successful for: " + username);
            response.sendRedirect(contextPath + "/jsp/login.jsp?signup=success");
        } else {
            System.out.println("Signup failed for: " + username);
            response.sendRedirect(contextPath + "/jsp/signup.jsp?error=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/jsp/signup.jsp");
    }
}
