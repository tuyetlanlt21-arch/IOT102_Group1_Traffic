package controller;

import dao.PenaltyTicketDAO;
import dto.FrequentViolation;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import utils.EmailUtils;

@WebServlet("/IssuePenaltyController")
public class IssuePenaltyController extends HttpServlet {

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

        try {

            int accountId =
                    Integer.parseInt(request.getParameter("accountId"));

            PenaltyTicketDAO dao =
                    new PenaltyTicketDAO();

            FrequentViolation info =
                    dao.getPenaltyInfo(accountId);

            if (info == null) {

                response.sendRedirect("FrequentViolationController");
                return;

            }

            int ticketId =
                    dao.createPenaltyTicket(accountId);

            if (ticketId > 0) {

                dao.attachTicketToViolations(accountId, ticketId);

                double fine;

                if (info.getVehicle().getVehicleType()
                        .equalsIgnoreCase("Motorbike")) {

                    fine = 250000;

                } else {

                    fine = 1000000;

                }

                EmailUtils.sendPenaltyEmail(

                        info.getAccount().getEmail(),

                        info.getAccount().getFullName(),

                        info.getVehicle().getLicensePlate(),

                        info.getViolationCount(),

                        fine

                );

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        response.sendRedirect("FrequentViolationController");

    }

}