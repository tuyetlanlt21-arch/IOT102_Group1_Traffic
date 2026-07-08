package controller;

import dao.StatisticsDAO;
import dto.Statistics;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/StatisticsController")
public class StatisticsController extends HttpServlet {

    private final String SUCCESS = "admin_statistics.jsp";
    private final String ERROR = "error.jsp";

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String url = SUCCESS;

        try {

            StatisticsDAO dao = new StatisticsDAO();

            Statistics stats = dao.getDashboardStatistics();

            request.setAttribute("stats", stats);

            request.setAttribute("chartLabels",
                    dao.getChartLabels());

            request.setAttribute("chartData",
                    dao.getChartData());

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute("ERROR", e.getMessage());

            url = ERROR;

        }

        request.getRequestDispatcher(url).forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);

    }

}