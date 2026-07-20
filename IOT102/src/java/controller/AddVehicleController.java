/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.VehicleDAO;
import dto.Account;
import dto.Vehicle;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Minh Khanh
 */
@WebServlet(name = "AddVehicleController", urlPatterns = {"/AddVehicleController"})
public class AddVehicleController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            Account account = (Account) session.getAttribute("ACCOUNT");
            if (account == null) {
                response.sendRedirect("index.jsp");
                return;
            }

            String plateParam = request.getParameter("licensePlate");
            if (plateParam == null || plateParam.trim().isEmpty()) {
                response.sendRedirect("CusDashboardController");
                return;
            }

            String licensePlate = plateParam.trim().toUpperCase();
            String brand = request.getParameter("brand");
            String vehicleType = "Personal"; // Remove distinction


            VehicleDAO dao = new VehicleDAO();
            Vehicle existing = dao.getVeByPlate(licensePlate);

            if (existing != null) {
                if ("Inactive".equalsIgnoreCase(existing.getStatus())) {
                    // Tồn tại và Inactive -> Reactive
                    existing.setBrand(brand);
                    existing.setVehicleType(vehicleType);
                    existing.setAccountId(account.getAccountID());
                    dao.reactivateVehicle(existing);
                } else {
                    // Tồn tại và Active -> Lỗi
                    request.setAttribute("ERROR", "Biển số đã tồn tại và đang hoạt động!");
                    request.getRequestDispatcher("CusDashboardController").forward(request, response);
                    return;
                }
            } else {
                // Xe mới hoàn toàn
                Vehicle v = new Vehicle(licensePlate, account.getAccountID(), brand, vehicleType, "Active");
                dao.createVehicle(v);
            }
            response.sendRedirect("CusDashboardController");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
