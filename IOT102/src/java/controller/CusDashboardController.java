/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.PenaltyTicketDAO;
import dao.VehicleDAO;
import dao.ViolationEventDAO;
import dto.Account;
import dto.PenaltyTicket;
import dto.Vehicle;
import dto.ViolationEvent;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
@WebServlet(name = "CusDashboardController", urlPatterns = {"/CusDashboardController"})
public class CusDashboardController extends HttpServlet {

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

            // 1. Kiểm tra tài khoản đang đăng nhập trong Session
            Account account = (Account) session.getAttribute("ACCOUNT");
          
            // Nếu chưa đăng nhập thì đá về trang Login
            if (account == null) {
                response.sendRedirect("index.jsp");
                return;
            }

            // Lấy ID tài khoản (Lưu ý: Dùng getAccountId() hoặc getAccountID() tùy theo class Account.java của bạn)
            int accountId = account.getAccountID();

            // 2. Khởi tạo các DAO của hệ thống giám sát tốc độ
            VehicleDAO vehicleDAO = new VehicleDAO();
            ViolationEventDAO violationDAO = new ViolationEventDAO();
            PenaltyTicketDAO ticketDAO = new PenaltyTicketDAO();

            // 3. Lấy toàn bộ danh sách phục vụ hiển thị lên Dashboard
            List<Vehicle> vehicleList = vehicleDAO.getVehiclesByAccountId(accountId);
            List<ViolationEvent> violationList = violationDAO.getViolationsByAccountId(accountId);
            List<PenaltyTicket> ticketList = ticketDAO.getTicketsByAccountId(accountId);

            // 4. Đẩy dữ liệu vào Request Attribute để trang JSP truy xuất (View)
            request.setAttribute("ACCOUNT", account);
            request.setAttribute("VEHICLE_LIST", vehicleList);
            request.setAttribute("VIOLATION_LIST", violationList);
            request.setAttribute("TICKET_LIST", ticketList);

            // 5. Forward sang trang giao diện Customer Dashboard
            request.getRequestDispatcher("cus-dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            try {
                request.setAttribute("ERROR", "Unable to load dashboard data: " + e.getMessage());
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
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
