package controller;

import dao.ViolationEventDAO;
import dto.ViolationEvent;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "AdminViolationsController", urlPatterns = {"/AdminViolationsController"})
public class AdminViolationsController extends HttpServlet {

    private static final String SUCCESS = "admin_violations.jsp";
    private static final String ERROR = "error.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        dto.Account acc = (dto.Account) session.getAttribute("ACCOUNT");
        if (acc == null || acc.getRoleID() != 1) {
            response.sendRedirect("index.jsp");
            return;
        }

        String url = SUCCESS;

        try {

            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String status = request.getParameter("status");

            ViolationEventDAO dao = new ViolationEventDAO();

            List<ViolationEvent> violationList;

            if ((startDate == null || startDate.isEmpty())
                    && (endDate == null || endDate.isEmpty())
                    && (status == null || status.isEmpty() || status.equals("All"))) {

                violationList = dao.getAllViolations();

            } else {

                violationList = dao.filterViolations(startDate, endDate, status);

            }

            int total = violationList.size();
            int pending = 0;
            int notified = 0;
            for (ViolationEvent v : violationList) {
                if ("Pending".equalsIgnoreCase(v.getAdminStatus())) {
                    pending++;
                } else if ("Notified".equalsIgnoreCase(v.getAdminStatus())) {
                    notified++;
                }
            }
            
            request.setAttribute("totalViolations", total);
            request.setAttribute("pendingViolations", pending);
            request.setAttribute("notifiedViolations", notified);
            request.setAttribute("violationList", violationList);

        } catch (Exception e) {

            e.printStackTrace();
            request.setAttribute("ERROR", e.getMessage());
            url = ERROR;

        }

        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);

    }
}