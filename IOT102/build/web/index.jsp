<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>UrbanSafe - Speed Monitoring</title>

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
    <body>

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white/80 backdrop-blur sticky-top soft-shadow">
            <div class="container">
                <a class="navbar-brand d-flex align-items-center" href="#">
                    <i class="fa-solid fa-gauge-high text-primary fs-3 me-2" data-aos="zoom-in"></i>
                    <div>
                        <h5 class="mb-0 fw-bold text-dark">UrbanSafe</h5>
                        <small class="text-muted d-block" style="font-size: 0.75rem;">Speed Monitoring</small>
                    </div>
                </a>

                <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
                    <ul class="navbar-nav gap-3 gap-lg-4">
                        <li class="nav-item"><a class="nav-link fw-semibold" href="#home">Home</a></li>
                        <li class="nav-item"><a class="nav-link fw-semibold" href="#features">Features</a></li>
                        <li class="nav-item"><a class="nav-link fw-semibold" href="#how-it-works">How it Works</a></li>
                        <li class="nav-item"><a class="nav-link fw-semibold" href="#about-us">About Us</a></li>
                        <li class="nav-item"><a class="nav-link fw-semibold" href="#contact">Contact</a></li>
                    </ul>
                </div>

                <div class="d-none d-lg-block">
                    <a href="#" class="btn btn-soft-primary px-4 py-2 rounded-pill fw-semibold shadow-sm hover-lift btn-pulse" data-bs-toggle="modal" data-bs-target="#loginModal">
                        <i class="fa-regular fa-user me-2"></i> Login
                    </a>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <header id="home" class="hero-section text-white d-flex align-items-center">
            <div class="container position-relative z-1">
                <div class="row">
                    <div class="col-lg-7 col-md-9" data-aos="fade-up" data-aos-duration="1000">
                        <h1 class="display-4 fw-bold mb-3 hero-title">
                            Speed Control<br>
                            For the <span class="text-gradient">safety</span> of our community
                        </h1>
                        <p class="lead mb-4 opacity-75 fw-normal">
                            The speed monitoring system at Sunshine Residence<br>
                            ensures a safe and civilized living environment for all residents.
                        </p>
                        <div class="d-flex flex-wrap gap-3">
                            <a href="#features" class="btn btn-primary px-4 py-3 rounded-4 d-flex align-items-center shadow-lg hover-lift fw-semibold">
                                <i class="fa-solid fa-rocket me-2"></i> Explore System
                            </a>
                            <a href="#contact" class="btn btn-outline-light px-4 py-3 rounded-4 d-flex align-items-center hover-lift fw-semibold">
                                <i class="fa-solid fa-headset me-2"></i> Get in Touch
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <!-- Highlight Features -->
        <section id="features" class="container features-overlap position-relative z-2">
            <div class="bg-white soft-card p-4 p-md-5" data-aos="fade-up" data-aos-delay="200">
                <div class="row text-center g-4">
                    <div class="col-md-6 col-lg-3" data-aos="zoom-in" data-aos-delay="300">
                        <div class="icon-box bg-light-blue text-primary mb-3 mx-auto shadow-sm">
                            <i class="fa-solid fa-camera"></i>
                        </div>
                        <h6 class="fw-bold">Real-time Monitoring</h6>
                        <p class="text-muted small mb-0">Track vehicle speeds live 24/7</p>
                    </div>
                    <div class="col-md-6 col-lg-3" data-aos="zoom-in" data-aos-delay="400">
                        <div class="icon-box bg-light-green text-success mb-3 mx-auto shadow-sm">
                            <i class="fa-solid fa-gauge-simple-high"></i>
                        </div>
                        <h6 class="fw-bold">Speed Control</h6>
                        <p class="text-muted small mb-0">Alert and record over-speeding instances</p>
                    </div>
                    <div class="col-md-6 col-lg-3" data-aos="zoom-in" data-aos-delay="500">
                        <div class="icon-box bg-light-orange text-warning mb-3 mx-auto shadow-sm">
                            <i class="fa-solid fa-shield-halved"></i>
                        </div>
                        <h6 class="fw-bold">Community Safety</h6>
                        <p class="text-muted small mb-0">Contribute to a safe and civilized living environment</p>
                    </div>
                    <div class="col-md-6 col-lg-3" data-aos="zoom-in" data-aos-delay="600">
                        <div class="icon-box bg-light-purple text-purple mb-3 mx-auto shadow-sm">
                            <i class="fa-solid fa-chart-column"></i>
                        </div>
                        <h6 class="fw-bold">Transparency</h6>
                        <p class="text-muted small mb-0">Data is stored and managed transparently and accurately</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- How It Works Section -->
        <section id="how-it-works" class="container my-5 pt-4 pt-md-5">
            <div class="text-center mb-5" data-aos="fade-up">
                <span class="badge bg-primary-soft text-primary px-3 py-2 rounded-pill mb-2 fw-semibold">Process</span>
                <h3 class="fw-bold section-title">How the system works</h3>
                <p class="text-muted">3 simple steps to monitor and manage internal speeding violations</p>
            </div>

            <div class="row g-4 position-relative">
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="step-card h-100 p-4 bg-white soft-card text-center hover-lift">
                        <div class="step-number text-primary mb-3">01</div>
                        <h5 class="fw-bold">Account Login</h5>
                        <p class="text-muted mb-0">Use resident or management accounts to securely access the system dashboard.</p>
                    </div>
                </div>
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="step-card h-100 p-4 bg-white soft-card text-center hover-lift">
                        <div class="step-number text-success mb-3">02</div>
                        <h5 class="fw-bold">Live Tracking</h5>
                        <p class="text-muted mb-0">Access the dashboard to view live camera streams and real-time vehicle speeds.</p>
                    </div>
                </div>
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="step-card h-100 p-4 bg-white soft-card text-center hover-lift">
                        <div class="step-number text-warning mb-3">03</div>
                        <h5 class="fw-bold">Search & Reports</h5>
                        <p class="text-muted mb-0">Receive automatic alerts and export detailed speeding violation reports when needed.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- About Us Section -->
        <section id="about-us" class="container my-5 pt-4 pt-md-5">
            <div class="row align-items-center g-5">
                <div class="col-lg-6" data-aos="fade-right">
                    <span class="badge bg-primary-soft text-primary px-3 py-2 rounded-pill mb-2 fw-semibold">About Us</span>
                    <h3 class="fw-bold section-title mb-4">Creating a <span class="text-gradient">smart & safe</span> living space</h3>
                    <p class="text-muted mb-4">UrbanSafe was developed with the mission of providing modern traffic security solutions for urban areas. We combine IoT technology and software management to optimize monitoring, making it easy for management to operate and residents to enjoy life with peace of mind.</p>
                    <ul class="list-unstyled mb-0">
                        <li class="mb-3 d-flex align-items-center"><i class="fa-solid fa-circle-check text-success me-3 fs-5"></i> <span class="fw-semibold text-dark">Modern core technology, high accuracy</span></li>
                        <li class="mb-3 d-flex align-items-center"><i class="fa-solid fa-circle-check text-success me-3 fs-5"></i> <span class="fw-semibold text-dark">Absolute data privacy for all residents</span></li>
                        <li class="d-flex align-items-center"><i class="fa-solid fa-circle-check text-success me-3 fs-5"></i> <span class="fw-semibold text-dark">Dedicated engineering team, 24/7 support</span></li>
                    </ul>
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <div class="position-relative p-3">
                        <img src="https://images.unsplash.com/photo-1573164713988-8665fc963095?q=80&w=2069&auto=format&fit=crop" alt="About UrbanSafe" class="img-fluid rounded-4 soft-card">
                        <div class="position-absolute bottom-0 start-0 bg-white soft-card p-3 p-md-4 text-center d-none d-sm-block shadow-lg" style="transform: translate(-10%, 20%); border: 2px solid #eff6ff;">
                            <h2 class="fw-bold text-primary mb-0">Commitment</h2>
                            <p class="text-muted small fw-semibold mb-0">To your safety</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Contact Section -->
        <section id="contact" class="bg-light-gray py-5 mt-5">
            <div class="container my-4">
                <div class="row align-items-center g-5">
                    <div class="col-lg-5" data-aos="fade-right">
                        <span class="badge bg-primary-soft text-primary px-3 py-2 rounded-pill mb-2 fw-semibold">Support</span>
                        <h3 class="fw-bold section-title mb-3">Need Help?</h3>
                        <p class="text-muted mb-4">The UrbanSafe technical team is always ready to answer questions and support management as well as residents 24/7.</p>

                        <div class="d-flex align-items-center mb-4 p-3 bg-white soft-card hover-lift">
                            <div class="icon-box-small bg-light-blue text-primary me-3">
                                <i class="fa-solid fa-phone"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-0">Consulting Hotline</h6>
                                <p class="text-muted mb-0">1900 8888</p>
                            </div>
                        </div>

                        <div class="d-flex align-items-center mb-4 p-3 bg-white soft-card hover-lift">
                            <div class="icon-box-small bg-light-green text-success me-3">
                                <i class="fa-solid fa-envelope"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-0">Support Email</h6>
                                <p class="text-muted mb-0">support@urbansafe.vn</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-7" data-aos="fade-left" data-aos-delay="200">
                        <div class="bg-white soft-card p-4 p-md-5">
                            <form>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label fw-semibold text-muted small">Full Name</label>
                                        <input type="text" class="form-control form-control-lg soft-input" placeholder="Enter your name">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-semibold text-muted small">Phone Number</label>
                                        <input type="tel" class="form-control form-control-lg soft-input" placeholder="Enter your phone number">
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label fw-semibold text-muted small">Request Details</label>
                                        <textarea class="form-control form-control-lg soft-input" rows="4" placeholder="Enter your problem or inquiry..."></textarea>
                                    </div>
                                    <div class="col-12 mt-4">
                                        <button type="submit" class="btn btn-primary w-100 py-3 rounded-4 fw-bold shadow-sm hover-lift">
                                            Send Request <i class="fa-solid fa-paper-plane ms-2"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="bg-white py-4 border-top">
            <div class="container d-flex flex-column flex-md-row justify-content-between align-items-center gap-3">
                <div class="text-muted fw-semibold">
                    <i class="fa-solid fa-location-dot me-2 text-primary"></i>
                    Sunshine Residence, District 9, Ho Chi Minh City
                </div>
                <div class="text-muted small fw-semibold">
                    © 2026 UrbanSafe. All rights reserved.
                </div>
            </div>
        </footer>

        <!-- Login Modal -->
        <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content soft-card border-0">
                    <div class="modal-header border-0 pb-0 mt-2 mx-2">
                        <h5 class="modal-title fw-bold" style="font-family: 'Poppins', sans-serif;" id="loginModalLabel">Welcome Back</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-4 p-md-5">
                        <% 
                            String loginError = (String) request.getAttribute("ERROR");
                            if (loginError != null) { 
                        %>
                            <div class="alert alert-danger bg-danger-soft border-0 text-danger rounded-3 small fw-bold mb-4">
                                <i class="fa-solid fa-triangle-exclamation me-2"></i> <%= loginError %>
                            </div>
                        <% } %>
                        <p class="text-muted small mb-4">Please enter your credentials to access the system.</p>
                        <form action="LoginController" method="POST">
                            <!-- Email Input -->
                            <div class="mb-3">
                                <label for="loginEmail" class="form-label fw-semibold text-muted small">Email Address</label>
                                <input type="email" name="email" class="form-control form-control-lg soft-input" id="loginEmail" placeholder="name@example.com" required>
                            </div>

                            <!-- Password Input with Eye Icon -->
                            <div class="mb-4">
                                <label for="loginPassword" class="form-label fw-semibold text-muted small">Password</label>
                                <div class="position-relative">
                                    <input type="password" name="password" class="form-control form-control-lg soft-input pe-5" id="loginPassword" placeholder="Enter your password" required>
                                    <button class="btn border-0 position-absolute end-0 top-50 translate-middle-y text-muted" type="button" id="togglePassword" style="box-shadow: none;">
                                        <i class="fa-solid fa-eye" id="eyeIcon"></i>
                                    </button>
                                </div>
                            </div>

                            <!-- Login Button -->
                            <button type="submit" class="btn btn-primary w-100 py-3 rounded-4 fw-bold shadow-sm hover-lift mb-3">
                                Login <i class="fa-solid fa-arrow-right-to-bracket ms-2"></i>
                            </button>

                            <!-- Register Note -->
                            <div class="text-center mt-3 pt-3 border-top">
                                <p class="text-muted small mb-0">Don't have an account? <a href="register.jsp" class="text-primary fw-bold text-decoration-none">Register here</a></p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- AOS Animation JS -->
        <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

        <script>
            // Initialize AOS (Animation)
            AOS.init({
                duration: 800,
                easing: 'ease-in-out',
                once: true,
                offset: 50
            });

            // Navbar Logic (Shrink & ScrollSpy Active Menu)
            document.addEventListener("DOMContentLoaded", function () {
                // Tự động mở Modal Login nếu có thông báo lỗi từ Controller
                <% 
                    String loginErrorJs = (String) request.getAttribute("ERROR");
                    if (loginErrorJs != null) { 
                %>
                    const loginModal = new bootstrap.Modal(document.getElementById('loginModal'));
                    loginModal.show();
                <% } %>

                const navbar = document.querySelector('.navbar');
                const sections = document.querySelectorAll("header[id], section[id]");
                const navLinks = document.querySelectorAll(".navbar-nav .nav-link");

                window.addEventListener('scroll', function () {
                    // 1. Shrink Navbar on scroll
                    if (window.scrollY > 50) {
                        navbar.classList.add('navbar-scrolled');
                    } else {
                        navbar.classList.remove('navbar-scrolled');
                    }

                    // 2. Auto Active Menu (ScrollSpy)
                    let current = "";
                    sections.forEach((section) => {
                        const sectionTop = section.offsetTop;
                        // Offset navbar height for better active state detection
                        if (pageYOffset >= sectionTop - 150) {
                            current = section.getAttribute("id");
                        }
                    });

                    navLinks.forEach((link) => {
                        link.classList.remove("active");
                        if (link.getAttribute("href") === "#" + current) {
                            link.classList.add("active");
                        }
                    });
                });

                // Password Toggle Logic
                const togglePassword = document.querySelector('#togglePassword');
                const passwordInput = document.querySelector('#loginPassword');
                const eyeIcon = document.querySelector('#eyeIcon');

                if (togglePassword) {
                    togglePassword.addEventListener('click', function () {
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
                }
            });
        </script>
    </body>
</html>