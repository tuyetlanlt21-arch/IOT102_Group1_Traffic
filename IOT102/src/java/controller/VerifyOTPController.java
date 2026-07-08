package controller;

import dao.AccountDAO;
import dto.Account;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet(name = "VerifyOTPController", urlPatterns = {"/VerifyOTPController"})
public class VerifyOTPController extends HttpServlet {

    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String url = "register.jsp";

        try {

            HttpSession session = request.getSession();

            String inputOTP = request.getParameter("otp");

            String sessionOTP =
                    (String) session.getAttribute("OTP");

            Long otpTime =
                    (Long) session.getAttribute("OTP_TIME");

            Account account =
                    (Account) session.getAttribute("PENDING_ACCOUNT");

            if (sessionOTP == null
                    || otpTime == null
                    || account == null) {

                request.setAttribute("ERROR",
                        "OTP has expired!");

                request.getRequestDispatcher(url)
                        .forward(request, response);

                return;

            }

            long current = System.currentTimeMillis();

            if (current - otpTime > 5 * 60 * 1000) {

                session.removeAttribute("OTP");
                session.removeAttribute("OTP_TIME");
                session.removeAttribute("PENDING_ACCOUNT");

                request.setAttribute("ERROR",
                        "OTP has expired!");

                request.getRequestDispatcher(url)
                        .forward(request, response);

                return;

            }

            if (!sessionOTP.equals(inputOTP)) {

                request.setAttribute("SEND_SUCCESS", true);

                request.setAttribute("ERROR",
                        "Incorrect OTP!");

                request.getRequestDispatcher(url)
                        .forward(request, response);

                return;

            }

            AccountDAO dao = new AccountDAO();

            int check = dao.createAccount(account);

            if (check > 0) {

                session.removeAttribute("OTP");
                session.removeAttribute("OTP_TIME");
                session.removeAttribute("PENDING_ACCOUNT");

                response.sendRedirect("index.jsp");

            } else {

                request.setAttribute("ERROR",
                        "Register failed!");

                request.getRequestDispatcher(url)
                        .forward(request, response);

            }
            

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