<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Account" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - UrbanSafe</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&family=Poppins:wght@500;600;700;800&display=swap" rel="stylesheet">
    
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    
    <style>
        .terms-body::-webkit-scrollbar { width: 8px; }
        .terms-body::-webkit-scrollbar-track { background: #f1f5f9; border-radius: 10px; }
        .terms-body::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }
        .terms-body::-webkit-scrollbar-thumb:hover { background: #94a3b8; }
    </style>
</head>
<body class="bg-light-gray d-flex flex-column min-vh-100">

    <nav class="navbar navbar-expand-lg navbar-light bg-white/80 backdrop-blur sticky-top soft-shadow py-3">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                <i class="fa-solid fa-gauge-high text-primary fs-3 me-2"></i>
                <div>
                    <h5 class="mb-0 fw-bold text-dark">UrbanSafe</h5>
                    <small class="text-muted d-block" style="font-size: 0.75rem;">Speed Monitoring</small>
                </div>
            </a>
            <div class="d-none d-md-block">
                <a href="index.jsp" class="btn btn-outline-secondary px-4 py-2 rounded-pill fw-semibold hover-lift small">
                    <i class="fa-solid fa-arrow-left me-2"></i> Back to Home
                </a>
            </div>
        </div>
    </nav>

    <section class="flex-grow-1 d-flex align-items-center justify-content-center py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-md-8 col-lg-5" data-aos="fade-up">
                    <div class="bg-white soft-card p-4 p-md-5">
                        <div class="text-center mb-4">
                            <div class="icon-box-small bg-primary-soft text-primary mx-auto mb-3">
                                <i class="fa-solid fa-user-plus"></i>
                            </div>
                            <h3 class="fw-bold section-title">Create an Account</h3>
                            <p class="text-muted small">Join UrbanSafe to monitor and manage your community.</p>
                        </div>
                        
                        <% 
                            String errorMsg = (String) request.getAttribute("ERROR");
                            if (errorMsg != null) { 
                        %>
                            <div class="alert alert-danger bg-danger-soft border-0 text-danger rounded-3 small fw-bold mb-4">
                                <i class="fa-solid fa-triangle-exclamation me-2"></i> <%= errorMsg %>
                            </div>
                        <% } %>
                        
                        <form id="registerForm" action="RegisterController" method="POST">
                            
                            <div class="mb-3">
                                <label class="form-label fw-semibold text-muted small">Username</label>
                                <input type="text" class="form-control form-control-lg soft-input" name="username" placeholder="Enter username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold text-muted small">Full Name</label>
                                <input type="text" class="form-control form-control-lg soft-input" name="fullName" placeholder="Enter your full name" value="<%= request.getParameter("fullName") != null ? request.getParameter("fullName") : "" %>" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold text-muted small">Email Address</label>
                                <input type="email" class="form-control form-control-lg soft-input" name="email" placeholder="name@example.com" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label fw-semibold text-muted small">Password</label>
                                <div class="position-relative">
                                    <input type="password" class="form-control form-control-lg soft-input pe-5" id="regPassword" name="password" placeholder="Create a password" required>
                                    <button class="btn border-0 position-absolute end-0 top-50 translate-middle-y text-muted toggle-password" type="button" data-target="#regPassword" style="box-shadow: none;">
                                        <i class="fa-solid fa-eye"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-semibold text-muted small">Confirm Password</label>
                                <div class="position-relative">
                                    <input type="password" class="form-control form-control-lg soft-input pe-5" id="regConfirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
                                    <button class="btn border-0 position-absolute end-0 top-50 translate-middle-y text-muted toggle-password" type="button" data-target="#regConfirmPassword" style="box-shadow: none;">
                                        <i class="fa-solid fa-eye"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="form-check mb-4">
                                <input class="form-check-input" type="checkbox" id="termsCheck" disabled required>
                                <label class="form-check-label text-muted small" for="termsCheck">
                                    I have read and agree to the 
                                    <a href="#" class="text-primary text-decoration-none fw-bold" data-bs-toggle="modal" data-bs-target="#termsModal">Terms of Service & Privacy Policy</a>.
                                </label>
                            </div>

                            <button type="submit" id="btnRegister" class="btn btn-primary w-100 py-3 rounded-4 fw-bold shadow-sm hover-lift mb-4" disabled>
                                Register <i class="fa-solid fa-arrow-right ms-2"></i>
                            </button>

                            <div class="text-center pt-3 border-top">
                                <p class="text-muted small mb-0">Already have an account? <a href="login.jsp" class="text-primary fw-bold text-decoration-none">Login here</a></p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer class="bg-white py-4 border-top mt-auto">
        <div class="container text-center text-muted small fw-semibold">
            © 2026 UrbanSafe. All rights reserved.
        </div>
    </footer>

    <div class="modal fade" id="termsModal" tabindex="-1" aria-labelledby="termsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
            <div class="modal-content soft-card border-0">
                <div class="modal-header border-0 pb-0 mt-2 mx-2">
                    <h5 class="modal-title fw-bold font-poppins" id="termsModalLabel">Terms of Service & Privacy Policy</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4 terms-body" id="termsBody">
                    <div class="alert alert-primary bg-primary-soft border-0 small fw-semibold mb-4">
                        <i class="fa-solid fa-circle-info me-2"></i> Please read to the bottom to automatically accept the terms and activate the registration button.
                    </div>
                    
                    <h6 class="fw-bold">1. Introduction</h6>
                    <p class="text-muted small mb-4">Welcome to UrbanSafe. By accessing or using our speed monitoring and community safety system, you agree to be bound by these Terms of Service and our Privacy Policy. Our system is designed strictly for internal management at Sunshine Residence to ensure traffic safety.</p>
                    
                    <h6 class="fw-bold">2. Data Collection & Privacy</h6>
                    <p class="text-muted small mb-4">We respect your privacy. UrbanSafe uses AI cameras to capture license plates and measure vehicle speeds exclusively within the residential area. We collect:<br>
                    - License plate images for vehicles exceeding speed limits.<br>
                    - Timestamps and speed data.<br>
                    - User account information (Name, Email) for system access.<br>
                    This data is securely stored and only accessible to authorized management personnel and the respective vehicle owners. It is never sold to third parties.</p>

                    <h6 class="fw-bold">3. User Responsibilities</h6>
                    <p class="text-muted small mb-4">As a registered user, you agree to:<br>
                    - Maintain the confidentiality of your login credentials.<br>
                    - Use the system for personal verification and community safety purposes only.<br>
                    - Not misuse, attempt to hack, or distribute system data without authorization.</p>

                    <h6 class="fw-bold">4. System Limitations</h6>
                    <p class="text-muted small mb-4">While UrbanSafe strives for 99.9% accuracy, environmental factors (heavy rain, glare) may occasionally affect readings. The system's records serve as a reference for community guidelines and are subject to review by the management board.</p>

                    <h6 class="fw-bold">5. Account Termination</h6>
                    <p class="text-muted small mb-4">The management reserves the right to suspend or terminate accounts that violate community rules, attempt unauthorized access, or misuse the application in any form.</p>
                    
                    <br><br><br>
                    <p class="text-center text-primary fw-bold small mb-0"><i class="fa-solid fa-check-circle me-1"></i> End of Document</p>
                </div>
                <div class="modal-footer border-0 pt-0 mx-2 mb-2">
                    <button type="button" class="btn btn-outline-secondary rounded-pill px-4" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="otpModal" tabindex="-1" aria-labelledby="otpModalLabel" aria-hidden="true" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered modal-sm">
            <div class="modal-content soft-card border-0">
                <div class="modal-header border-0 pb-0 mt-2 mx-2">
                    <h5 class="modal-title fw-bold font-poppins" id="otpModalLabel">Email Verification</h5>
                    </div>
                
                <form action="VerifyOTPController" method="POST">
                    <div class="modal-body p-4 text-center">
                        <div class="icon-box-small bg-light-orange text-warning mx-auto mb-3">
                            <i class="fa-solid fa-envelope-open-text"></i>
                        </div>
                        
                        <% 
                            String successMsg = (String) request.getAttribute("SUCCESS");
                            if (successMsg != null) { 
                        %>
                            <div class="alert alert-success bg-success-soft border-0 text-success rounded-3 small fw-bold mb-3 p-2">
                                <i class="fa-solid fa-circle-check me-1"></i> <%= successMsg %>
                            </div>
                        <% } %>

                        <p class="text-muted small mb-4">We've sent a 6-digit code to <br>
                            <strong class="text-dark">
                                <% 
                                    Account pendingAcc = (Account) session.getAttribute("PENDING_ACCOUNT");
                                    if (pendingAcc != null) {
                                        out.print(pendingAcc.getEmail());
                                    } else {
                                        out.print(request.getParameter("email") != null ? request.getParameter("email") : "your email");
                                    }
                                %>
                            </strong>
                        </p>
                        
                        <div class="mb-4">
                            <input type="text" class="form-control form-control-lg soft-input text-center fw-bold fs-4 letter-spacing-2" name="otp" id="otpInput" maxlength="6" placeholder="------" autocomplete="off" required>
                        </div>
                        
                        <button type="submit" class="btn btn-primary w-100 py-3 rounded-4 fw-bold shadow-sm hover-lift mb-3">
                            Verify Account
                        </button>
                        
                        <p class="text-muted small mb-0">Didn't receive the code? <br>
                            <a href="ResendOTPController" class="text-primary fw-bold text-decoration-none">Resend OTP</a>
                        </p>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    
    <script>
        AOS.init({ duration: 800, once: true });

        document.addEventListener("DOMContentLoaded", function() {
            // 1. Kích hoạt tự động mở Modal OTP nếu cờ SEND_SUCCESS từ Controller là true
            <% 
                Boolean sendSuccess = (Boolean) request.getAttribute("SEND_SUCCESS");
                if (sendSuccess != null && sendSuccess) { 
            %>
                const otpModal = new bootstrap.Modal(document.getElementById('otpModal'));
                otpModal.show();
            <% } %>

            // 2. Logic ẩn/hiện mật khẩu
            const togglePasswordBtns = document.querySelectorAll('.toggle-password');
            togglePasswordBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    const targetInputId = this.getAttribute('data-target');
                    const passwordInput = document.querySelector(targetInputId);
                    const eyeIcon = this.querySelector('i');

                    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordInput.setAttribute('type', type);
                    
                    if (type === 'text') {
                        eyeIcon.classList.replace('fa-eye', 'fa-eye-slash');
                        eyeIcon.classList.add('text-primary');
                    } else {
                        eyeIcon.classList.replace('fa-eye-slash', 'fa-eye');
                        eyeIcon.classList.remove('text-primary');
                    }
                });
            });

            // 3. Logic tự động Tích khi đọc xong Điều khoản
            const termsBody = document.getElementById('termsBody');
            const termsCheck = document.getElementById('termsCheck');
            const btnRegister = document.getElementById('btnRegister');

            if(termsBody && termsCheck && btnRegister) {
                termsBody.addEventListener('scroll', function() {
                    if (termsBody.scrollTop + termsBody.clientHeight >= termsBody.scrollHeight - 5) {
                        termsCheck.checked = true;       
                        termsCheck.disabled = false;     
                        btnRegister.disabled = false;    
                    }
                });
                
                termsCheck.addEventListener('change', function() {
                    btnRegister.disabled = !this.checked;
                });
            }
        });
    </script>
</body>
</html>