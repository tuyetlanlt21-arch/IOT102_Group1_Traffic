package controller;

import dao.ViolationEventDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ApiAddViolationController", urlPatterns = {"/ApiAddViolationController"})
public class ApiAddViolationController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String licensePlate = request.getParameter("licensePlate");
        String speedStr = request.getParameter("recordedSpeed");
        String limitStr = request.getParameter("speedLimit");
        String imageUrl = request.getParameter("imageUrl");

        if (licensePlate == null || speedStr == null || limitStr == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"status\":\"error\",\"message\":\"Missing parameters!\"}");
            return;
        }

        try {
            double recordedSpeed = Double.parseDouble(speedStr);
            double speedLimit = Double.parseDouble(limitStr);
            
            ViolationEventDAO dao = new ViolationEventDAO();
            boolean success = dao.insertViolationByPlate(licensePlate, recordedSpeed, speedLimit, imageUrl);
            
            if (success) {
                out.print("{\"status\":\"success\",\"message\":\"Violation recorded successfully!\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"status\":\"error\",\"message\":\"Database insert failed!\"}");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"status\":\"error\",\"message\":\"Invalid speed or speedLimit number format!\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
        } finally {
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
