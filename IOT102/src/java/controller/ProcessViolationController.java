package controller;

import dao.ViolationEventDAO;
import dto.ViolationEvent;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import utils.EmailUtils;

@WebServlet(name = "ProcessViolationController", urlPatterns = {"/ProcessViolationController"})
public class ProcessViolationController extends HttpServlet {

    @Override
   protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        dto.Account acc = (dto.Account) session.getAttribute("ACCOUNT");
        if (acc == null || acc.getRoleID() != 1) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        ViolationEventDAO dao = new ViolationEventDAO();

        try {

            if ("ignore".equals(action)) {

                dao.updateViolationStatus(eventId, "Ignored");

            } else if ("notify".equals(action)) {

                ViolationEvent violation = dao.getViolationById(eventId);

                if (violation != null
                        && violation.getOwnerEmail() != null
                        && !violation.getOwnerEmail().trim().isEmpty()) {

                    boolean sent = EmailUtils.sendWarningEmail(
                            violation.getOwnerEmail(),
                            violation.getOwnerName(),
                            violation.getLicensePlate(),
                            violation.getRecordedSpeed(),
                            violation.getSpeedLimit(),
                            violation.getTimestamp(),
                            violation.getImageUrl());

                    if (sent) {

                        dao.updateViolationStatus(eventId, "Notified");

                        request.getSession().setAttribute(
                                "SUCCESS",
                                "Warning email sent successfully.");

                    } else {

                        request.getSession().setAttribute(
                                "ERROR",
                                "Cannot send warning email.");

                    }

                } else {

                    request.getSession().setAttribute(
                            "ERROR",
                            "Owner email not found.");

                }

            }

        } catch (Exception e) {

            e.printStackTrace();

            request.getSession().setAttribute(
                    "ERROR",
                    e.getMessage());

        }

        response.sendRedirect("AdminViolationsController");

    }

    @Override
   protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doPost(request, response);

    }

}