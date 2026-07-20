package controller;

import dao.AccountDAO;
import dto.Account;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import utils.EmailUtils;
import utils.OTPGenerator;
import javax.servlet.annotation.WebServlet;

@WebServlet(name = "RegisterController", urlPatterns = {"/RegisterController"})
public class RegisterController extends HttpServlet {

    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String url = "register.jsp";

        try {

            String username = request.getParameter("username");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            AccountDAO dao = new AccountDAO();

            // Password
            if (!password.equals(confirmPassword)) {

                request.setAttribute("ERROR",
                        "Password does not match!");

                request.getRequestDispatcher(url).forward(request, response);
                return;

            }

            // Username
            if (dao.getAccountByUsername(username) != null) {

                request.setAttribute("ERROR",
                        "Username already exists!");

                request.getRequestDispatcher(url).forward(request, response);
                return;

            }

            // Email
            if (dao.getAccountByEmail(email) != null) {

                request.setAttribute("ERROR",
                        "Email already exists!");

                request.getRequestDispatcher(url).forward(request, response);
                return;

            }

            // Generate OTP
            String otp = OTPGenerator.generateOTP();

            // Send Email
            boolean success = EmailUtils.sendOTPEmail(
                    email,
                    fullName,
                    otp);

            if (!success) {

                request.setAttribute("ERROR",
                        "Cannot send OTP!");

                request.getRequestDispatcher(url).forward(request, response);

                return;

            }

            Account account = new Account(
                    username,
                    fullName,
                    password,
                    email,
                    2,
                    true,
                    new Date(System.currentTimeMillis())
            );

            HttpSession session = request.getSession();

            session.setAttribute("OTP", otp);

            session.setAttribute("OTP_TIME",
                    System.currentTimeMillis());

            session.setAttribute("PENDING_ACCOUNT",
                    account);

            request.setAttribute("SEND_SUCCESS", true);

            request.getRequestDispatcher(url).forward(request, response);

        } catch (Exception e) {

            log(e.getMessage());

        }

    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);

    }

}