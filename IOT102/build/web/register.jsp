<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - UrbanSafe</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts (Soft UI: Poppins & Nunito) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&family=Poppins:wght@500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- AOS Animation CSS -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="bg-light-gray d-flex flex-column min-vh-100">

    <!-- Simple Navbar for Auth Pages -->
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

    <!-- Registration Form Section -->
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
                        
                        <form action="XuLyDangKy" method="POST">
                            <div class="mb-3">
                                <label class="form-label fw-semibold text-muted small">Full Name</label>
                                <input type="text" class="form-control form-control-lg soft-input" name="fullName" placeholder="Enter your full name" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold text-muted small">Email Address</label>
                                <input type="email" class="form-control form-control-lg soft-input" name="email" placeholder="name@example.com" required>
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
                                    <input type="password" class="form-control form-control-lg soft-input pe-5" id="regConfirmPassword" placeholder="Confirm your password" required>
                                    <button class="btn border-0 position-absolute end-0 top-50 translate-middle-y text-muted toggle-password" type="button" data-target="#regConfirmPassword" style="box-shadow: none;">
                                        <i class="fa-solid fa-eye"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="form-check mb-4">
                                <input class="form-check-input" type="checkbox" id="termsCheck" required>
                                <label class="form-check-label text-muted small" for="termsCheck">
                                    I agree to the <a href="#" class="text-primary text-decoration-none fw-bold">Terms of Service</a> and <a href="#" class="text-primary text-decoration-none fw-bold">Privacy Policy</a>.
                                </label>
                            </div>

                            <button type="submit" class="btn btn-primary w-100 py-3 rounded-4 fw-bold shadow-sm hover-lift mb-4">
                                Create Account <i class="fa-solid fa-arrow-right ms-2"></i>
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

    <!-- Footer -->
    <footer class="bg-white py-4 border-top mt-auto">
        <div class="container text-center text-muted small fw-semibold">
            © 2026 UrbanSafe. All rights reserved.
        </div>
    </footer>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- AOS Animation JS -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    
    <script>
        AOS.init({
            duration: 800,
            once: true
        });

        // Logic ẩn/hiện mật khẩu (Con mắt)
        document.addEventListener("DOMContentLoaded", function() {
            const togglePasswordBtns = document.querySelectorAll('.toggle-password');
            togglePasswordBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    const targetInputId = this.getAttribute('data-target');
                    const passwordInput = document.querySelector(targetInputId);
                    const eyeIcon = this.querySelector('i');

                    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordInput.setAttribute('type', type);
                    
                    if (type === 'text') {
                        eyeIcon.classList.remove('fa-eye');
                        eyeIcon.classList.add('fa-eye-slash');
                        eyeIcon.classList.add('text-primary');
                    } else {
                        eyeIcon.classList.remove('fa-eye-slash');
                        eyeIcon.classList.add('fa-eye');
                        eyeIcon.classList.remove('text-primary');
                    }
                });
            });
        });
    </script>
</body>
</html>