package controller;

import dto.Account;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.EmailUtils;
import utils.OTPGenerator;
import javax.servlet.annotation.WebServlet;

@WebServlet(name = "ResendOTPController", urlPatterns = {"/ResendOTPController"})
public class ResendOTPController extends HttpServlet {

    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String url = "register.jsp";

        try {

            HttpSession session = request.getSession();

            Account account =
                    (Account) session.getAttribute("PENDING_ACCOUNT");

            if (account == null) {

                request.setAttribute("ERROR",
                        "Registration session has expired!");

                request.getRequestDispatcher(url)
                        .forward(request, response);

                return;

            }

            // Sinh OTP mới
            String otp = OTPGenerator.generateOTP();

            // Gửi Email
            boolean success = EmailUtils.sendOTPEmail(
                    account.getEmail(),
                    account.getFullName(),
                    otp);

            if (!success) {

                request.setAttribute("ERROR",
                        "Cannot resend OTP!");

                request.setAttribute("SEND_SUCCESS", true);

                request.getRequestDispatcher(url)
                        .forward(request, response);

                return;

            }

            // Cập nhật Session
            session.setAttribute("OTP", otp);

            session.setAttribute("OTP_TIME",
                    System.currentTimeMillis());

            request.setAttribute("SEND_SUCCESS", true);

            request.setAttribute("SUCCESS",
                    "A new OTP has been sent to your email.");

            request.getRequestDispatcher(url)
                    .forward(request, response);

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