package controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import dao.ReportDAO;
import model.Report;

public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get report data
        List<Report> reports = ReportDAO.getInventoryReport();

        // Set as request attribute
        request.setAttribute("reports", reports);

        // Forward to JSP
        request.getRequestDispatcher("/jsp/report/report.jsp").forward(request, response);
    }
}
