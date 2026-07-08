package controller;

import dao.PenaltyTicketDAO;
import dto.FrequentViolation;
import dto.PenaltyTicket;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "FrequentViolationController", urlPatterns = {"/FrequentViolationController"})
public class FrequentViolationController extends HttpServlet {

    private static final String SUCCESS = "admin_frequent_violators.jsp";
    private static final String ERROR = "error.jsp";

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String url = SUCCESS;

        try {

            PenaltyTicketDAO dao = new PenaltyTicketDAO();

            // Lấy danh sách xe vi phạm >= 3 lần trong tháng
            List<FrequentViolation> frequentList
                    = dao.getFrequentViolations();

            request.setAttribute("frequentList", frequentList);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute("ERROR",
                    "Cannot load frequent violations.");

            url = ERROR;

        }

        request.getRequestDispatcher(url)
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);

    }

}
