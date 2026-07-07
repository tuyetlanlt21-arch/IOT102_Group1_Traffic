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

        return

                "<!DOCTYPE html>"

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

        String body =

                "<p>Hello <b>" + fullName + "</b>,</p>"

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

}