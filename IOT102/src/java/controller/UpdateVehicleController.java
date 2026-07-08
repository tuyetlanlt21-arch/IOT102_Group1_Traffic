/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.VehicleDAO;
import dto.Vehicle;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Minh Khanh
 */
@WebServlet(name = "UpdateVehicleController", urlPatterns = {"/UpdateVehicleController"})
public class UpdateVehicleController extends HttpServlet {

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
            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
            String licensePlate = request.getParameter("licensePlate").toUpperCase();
            String brand = request.getParameter("brand");
            String vehicleType = request.getParameter("vehicleType");

            VehicleDAO dao = new VehicleDAO();

            // Kiểm tra trùng biển số với xe khác (loại trừ chính xe đang sửa)
            if (dao.isLicensePlateExistsForOther(licensePlate, vehicleId)) {
                request.setAttribute("ERROR", "Biển số này đã thuộc về xe khác!");
                request.getRequestDispatcher("CusDashboardController").forward(request, response);
                return;
            }

            Vehicle v = dao.getVehicleByID(vehicleId);
            if (v != null) {
                v.setLicensePlate(licensePlate);
                v.setBrand(brand);
                v.setVehicleType(vehicleType);
                // Giữ nguyên status hiện tại (nếu muốn, hoặc set cứng nếu cần)
                dao.updateVehicle(v);
            }
            response.sendRedirect("CusDashboardController");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("CusDashboardController");
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
