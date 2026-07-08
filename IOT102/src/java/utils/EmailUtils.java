package utils;

import java.io.UnsupportedEncodingException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtils {

    //================ GMAIL SMTP ==================
    private static final String HOST = "smtp.gmail.com";
    private static final String PORT = "587";

    // Gmail hệ thống
    private static final String USERNAME = "tuyetlanlt05@gmail.com";

    // Gmail App Password (16 ký tự)
    private static final String PASSWORD = "ajkz vnks dfyc hsdx";

    //================ CREATE SESSION ==============
    private static Session getSession() {

        Properties props = new Properties();

        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", PORT);

        return Session.getInstance(props, new Authenticator() {

            @Override
            protected PasswordAuthentication getPasswordAuthentication() {

                return new PasswordAuthentication(
                        USERNAME,
                        PASSWORD);

            }

        });

    }

    //================ SEND EMAIL ==================
    public static boolean sendEmail(
            String receiver,
            String subject,
            String htmlContent) {

        try {

            Session session = getSession();

            MimeMessage message = new MimeMessage(session);

            message.setFrom(
                    new InternetAddress(
                            USERNAME,
                            "Traffic Monitoring System"));

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(receiver));

            message.setSubject(subject, "UTF-8");

            message.setContent(
                    htmlContent,
                    "text/html;charset=UTF-8");

            Transport.send(message);

            return true;

        } catch (UnsupportedEncodingException e) {

            e.printStackTrace();

        } catch (MessagingException e) {

            e.printStackTrace();

        }

        return false;

    }

    //================ EMAIL TEMPLATE ==============
    private static String getTemplate(
            String title,
            String body) {

        return "<!DOCTYPE html>"
                + "<html>"
                + "<body style='margin:0;"
                + "padding:40px;"
                + "background:#f4f6f9;"
                + "font-family:Arial,sans-serif;'>"
                + "<table align='center' width='650' "
                + "style='background:white;"
                + "border-radius:10px;"
                + "overflow:hidden;"
                + "box-shadow:0 3px 15px rgba(0,0,0,.08)'>"
                // Header
                + "<tr>"
                + "<td style='background:#0d6efd;"
                + "padding:25px;"
                + "text-align:center;'>"
                + "<h2 style='color:white;"
                + "margin:0;'>"
                + "Traffic Monitoring System"
                + "</h2>"
                + "</td>"
                + "</tr>"
                // Body

                + "<tr>"
                + "<td style='padding:35px;'>"
                + "<h2 style='margin-top:0;'>"
                + title
                + "</h2>"
                + body
                + "</td>"
                + "</tr>"
                // Footer

                + "<tr>"
                + "<td style='background:#f8f9fa;"
                + "padding:25px;"
                + "font-size:13px;"
                + "color:#777;'>"
                + "<p><b>Traffic Monitoring System</b></p>"
                + "<p>"
                + "This email was sent automatically. "
                + "Please do not reply to this email."
                + "</p>"
                + "<hr>"
                + "<p>"
                + "© 2026 Traffic Monitoring System. "
                + "All rights reserved."
                + "</p>"
                + "</td>"
                + "</tr>"
                + "</table>"
                + "</body>"
                + "</html>";

    }

    //================ OTP EMAIL ===================
    public static boolean sendOTPEmail(
            String email,
            String fullName,
            String otp) {

        String subject = "Traffic Monitoring System - Verify Your Email";

        String body
                = "<p>Hello <b>" + fullName + "</b>,</p>"
                + "<p>"
                + "Thank you for creating an account with "
                + "<b>Traffic Monitoring System</b>."
                + "</p>"
                + "<p>"
                + "To complete your registration, please use the "
                + "One-Time Password (OTP) below."
                + "</p>"
                + "<div style='text-align:center;"
                + "margin:40px 0;'>"
                + "<div style='display:inline-block;"
                + "padding:18px 45px;"
                + "background:#0d6efd;"
                + "color:white;"
                + "font-size:34px;"
                + "font-weight:bold;"
                + "letter-spacing:10px;"
                + "border-radius:10px;'>"
                + otp
                + "</div>"
                + "</div>"
                + "<p>"
                + "<b>This verification code will expire in 5 minutes.</b>"
                + "</p>"
                + "<p>"
                + "For your security, never share this code with anyone."
                + "</p>"
                + "<p>"
                + "If you did not request this email, "
                + "please ignore it. No account will be created "
                + "without OTP verification."
                + "</p>"
                + "<br>"
                + "<p>"
                + "Best Regards,<br>"
                + "<b>Traffic Monitoring System Team</b>"
                + "</p>";

        return sendEmail(
                email,
                subject,
                getTemplate(
                        "Email Verification",
                        body));

    }

    //================ SPEED WARNING EMAIL ===================
    public static boolean sendWarningEmail(
            String email,
            String ownerName,
            String licensePlate,
            double speed,
            double limit,
            java.util.Date time,
            String imageUrl) {

        java.text.SimpleDateFormat sdf
                = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

        String subject = "Traffic Monitoring System - Speed Warning";

        String body
                = "<p>Dear <b>" + ownerName + "</b>,</p>"
                + "<p>Our traffic monitoring system has detected that your vehicle exceeded the speed limit.</p>"
                + "<table style='border-collapse:collapse;width:100%;margin-top:20px;'>"
                + "<tr>"
                + "<td style='padding:8px;border:1px solid #ddd;'><b>License Plate</b></td>"
                + "<td style='padding:8px;border:1px solid #ddd;'>"
                + licensePlate
                + "</td>"
                + "</tr>"
                + "<tr>"
                + "<td style='padding:8px;border:1px solid #ddd;'><b>Recorded Speed</b></td>"
                + "<td style='padding:8px;border:1px solid #ddd;color:red;'>"
                + speed + " km/h"
                + "</td>"
                + "</tr>"
                + "<tr>"
                + "<td style='padding:8px;border:1px solid #ddd;'><b>Speed Limit</b></td>"
                + "<td style='padding:8px;border:1px solid #ddd;'>"
                + limit + " km/h"
                + "</td>"
                + "</tr>"
                + "<tr>"
                + "<td style='padding:8px;border:1px solid #ddd;'><b>Violation Time</b></td>"
                + "<td style='padding:8px;border:1px solid #ddd;'>"
                + sdf.format(time)
                + "</td>"
                + "</tr>"
                + "</table>";

        if (imageUrl != null && !imageUrl.trim().isEmpty()) {

            body
                    += "<br><h3>Captured Image</h3>"
                    + "<img src='" + imageUrl + "' "
                    + "style='width:100%;max-width:550px;"
                    + "border-radius:10px;"
                    + "border:1px solid #ddd;'>";

        }

        body
                += "<br><br>"
                + "<div style='background:#fff8db;"
                + "padding:15px;"
                + "border-left:5px solid #ffc107;"
                + "border-radius:5px;'>"
                + "<b>Warning</b><br>"
                + "This is only a warning email."
                + "<br><br>"
                + "If your vehicle continues violating traffic regulations multiple times, "
                + "our system may automatically issue an official penalty notice in accordance "
                + "with the community traffic management policy."
                + "</div>"
                + "<br>"
                + "<p>Please obey the speed limit to ensure safety for yourself and others.</p>"
                + "<br>"
                + "<p>Regards,<br>"
                + "<b>Traffic Monitoring System</b></p>";

        return sendEmail(
                email,
                subject,
                getTemplate("Speed Warning Notification", body));

    }

    public static boolean sendPenaltyEmail(
            String email,
            String ownerName,
            String plate,
            int violationCount,
            double fineAmount) {

        String subject = "Traffic Monitoring System - Penalty Notice";

        String body
                = "<p>Dear <b>" + ownerName + "</b>,</p>"
                + "<p>Our system has detected that your vehicle has repeatedly exceeded the speed limit.</p>"
                + "<table style='border-collapse:collapse;width:100%;'>"
                + "<tr>"
                + "<td><b>Vehicle Plate</b></td>"
                + "<td>" + plate + "</td>"
                + "</tr>"
                + "<tr>"
                + "<td><b>Total Violations</b></td>"
                + "<td>" + violationCount + "</td>"
                + "</tr>"
                + "<tr>"
                + "<td><b>Penalty Amount</b></td>"
                + "<td style='color:red;font-weight:bold;'>"
                + String.format("%,.0f VND", fineAmount)
                + "</td>"
                + "</tr>"
                + "<tr>"
                + "<td><b>Status</b></td>"
                + "<td>UNPAID</td>"
                + "</tr>"
                + "</table>"
                + "<br>"
                + "<div style='background:#ffecec;padding:18px;border-left:5px solid red;'>"
                + "<b>Please log in to the Traffic Monitoring System to view your penalty ticket and complete the payment.</b>"
                + "</div>"
                + "<br><br>"
                + "Regards,<br>"
                + "<b>Traffic Monitoring System</b>";

        return sendEmail(
                email,
                subject,
                getTemplate("Penalty Notice", body));

    }
}
