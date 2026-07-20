<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UrbanSafe | Admin Dashboard</title>
    
    <!-- Bootstrap 5 & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Quicksand:wght@600;700&display=swap" rel="stylesheet">
    
    <style>
        /* ========================================================
           ULTRA GLASSMORPHISM & SOFT UI THEME
        ======================================================== */
        :root {
            --primary: #2563eb;
            --primary-light: #3b82f6;
            --bg-color: #f4f7fe;
            --card-bg: rgba(255, 255, 255, 0.95);
            --text-dark: #1e293b;
            --text-muted: #64748b;
            --shadow-soft: 0 15px 35px rgba(112, 144, 176, 0.08);
            --radius-xl: 28px;
            --radius-pill: 50px;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-dark);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }
        
        .font-heading { font-family: 'Quicksand', sans-serif; }

        /* Abstract Background Blobs */
        .bg-blobs::before, .bg-blobs::after {
            content: ''; position: fixed; border-radius: 50%; filter: blur(80px); z-index: -1; opacity: 0.6; pointer-events: none;
        }
        .bg-blobs::before { width: 500px; height: 500px; background: #bfdbfe; top: -100px; right: -100px; }
        .bg-blobs::after { width: 400px; height: 400px; background: #ddd6fe; bottom: 100px; left: -100px; }

        /* Navbar */
        .top-nav {
            padding: 24px 0;
            display: flex; justify-content: space-between; align-items: center;
        }
        .logo-text { font-size: 1.5rem; font-weight: 800; color: var(--primary); letter-spacing: -0.5px; }
        .logo-text i { color: #8b5cf6; }
        .nav-greeting { background: #fff; padding: 10px 24px; border-radius: var(--radius-pill); font-weight: 600; color: var(--text-muted); box-shadow: var(--shadow-soft); }
        .btn-logout {
            background: var(--primary); color: #fff; font-weight: 700; padding: 10px 28px; border-radius: var(--radius-pill); text-decoration: none; transition: all 0.3s;
            box-shadow: 0 8px 20px rgba(37, 99, 235, 0.3);
        }
        .btn-logout:hover { background: #1d4ed8; color: #fff; transform: translateY(-2px); }

        /* Hero & Search */
        .hero-section { padding: 60px 0 40px 0; }
        .hero-title { font-size: 3rem; font-weight: 800; line-height: 1.2; letter-spacing: -1px; margin-bottom: 16px; }
        
        .mega-search-bar {
            background: #ffffff; border-radius: var(--radius-pill); padding: 12px;
            box-shadow: 0 20px 40px rgba(112, 144, 176, 0.12);
            display: flex; align-items: center; gap: 10px; flex-wrap: wrap;
            margin-top: 40px; margin-bottom: 60px;
        }
        .search-input-group {
            flex: 1; display: flex; align-items: center; padding: 8px 24px; background: transparent;
            border-right: 1px solid #e2e8f0; min-width: 200px;
        }
        .search-input-group:last-of-type { border-right: none; }
        .search-input-group i { color: var(--text-muted); font-size: 1.2rem; margin-right: 12px; }
        .search-input-group input, .search-input-group select {
            border: none; background: transparent; width: 100%; font-weight: 600; color: var(--text-dark); outline: none;
        }
        .btn-search {
            background: var(--primary); color: #fff; border: none; padding: 14px 36px; border-radius: var(--radius-pill);
            font-weight: 700; font-size: 1rem; transition: all 0.3s; box-shadow: 0 8px 20px rgba(37, 99, 235, 0.3);
        }
        .btn-search:hover { transform: translateY(-2px); background: #1d4ed8; }

        /* Section Titles */
        .section-title { font-size: 1.5rem; font-weight: 800; text-align: center; margin-bottom: 40px; letter-spacing: -0.5px; }

        /* Card Unified Style (Dùng chung cho Stats và Violations để đồng bộ) */
        .unified-card {
            background: var(--card-bg); border-radius: var(--radius-xl); padding: 24px;
            box-shadow: var(--shadow-soft); transition: all 0.4s ease; border: 1px solid rgba(255,255,255,0.8);
            display: flex; flex-direction: column; height: 100%; backdrop-filter: blur(10px);
        }
        .unified-card:hover { transform: translateY(-8px); box-shadow: 0 20px 40px rgba(112, 144, 176, 0.15); }

        /* Stat Specifics */
        .stat-icon { width: 56px; height: 56px; border-radius: 18px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-bottom: 20px; }

        /* Violation Specifics */
        .unified-card.violation { padding: 16px; }
        .v-img-wrapper { position: relative; border-radius: 20px; overflow: hidden; margin-bottom: 20px; height: 180px; }
        .v-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s; }
        .unified-card.violation:hover .v-img { transform: scale(1.05); }
        
        .v-badge { position: absolute; top: 12px; left: 12px; background: rgba(255,255,255,0.9); backdrop-filter: blur(4px); padding: 6px 14px; border-radius: var(--radius-pill); font-weight: 700; font-size: 0.75rem; color: var(--text-dark); box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        .v-badge.pending { color: #d97706; }
        .v-badge.notified { color: #166534; }
        
        .v-plate { font-size: 1.25rem; font-weight: 800; color: var(--text-dark); margin-bottom: 4px; }
        .v-speed { font-size: 1.4rem; font-weight: 800; color: var(--primary); }
        
        .v-action { display: flex; justify-content: space-between; align-items: center; margin-top: auto; padding-top: 16px; border-top: 1px dashed #e2e8f0; }
        .v-btn { background: #eff6ff; color: var(--primary); border: none; padding: 8px 20px; border-radius: var(--radius-pill); font-weight: 700; transition: all 0.2s; font-size: 0.85rem; }
        .v-btn:hover { background: var(--primary); color: white; }

        /* Modal Soft UI */
        .modal-content { border-radius: var(--radius-xl); border: none; box-shadow: 0 25px 50px rgba(0,0,0,0.15); }
    </style>
</head>
<body>

    <div class="bg-blobs"></div>

    <div class="container">
        <!-- TOP NAV -->
        <nav class="top-nav">
            <div class="logo-text font-heading">
                <i class="fa-brands fa-cloudscale me-1"></i> UrbanSafe
            </div>
            <div class="d-none d-md-block">
                <div class="nav-greeting">
                    <i class="fa-solid fa-hand-wave text-warning me-2"></i> Hello, ${not empty sessionScope.ADMIN_USER.fullName ? sessionScope.ADMIN_USER.fullName : 'System Admin'}
                </div>
            </div>
            <a href="LogoutController" class="btn-logout">Logout</a>
        </nav>

        <!-- HERO -->
        <div class="hero-section row align-items-center">
            <div class="col-lg-8">
                <h1 class="hero-title font-heading">Traffic Monitoring<br>Classified Dashboard</h1>
                <p class="text-muted fw-semibold fs-5 mb-0"><i class="fa-regular fa-square-check text-success me-2"></i> Review, verify and issue warnings efficiently.</p>
            </div>
        </div>

        <!-- MEGA SEARCH BAR -->
        <form action="AdminViolationsController" method="GET" class="mega-search-bar">
            <div class="search-input-group">
                <i class="fa-regular fa-calendar"></i>
                <input type="date" name="startDate" value="${param.startDate}" title="From Date">
            </div>
            <div class="search-input-group">
                <i class="fa-regular fa-calendar-check"></i>
                <input type="date" name="endDate" value="${param.endDate}" title="To Date">
            </div>
            <div class="search-input-group">
                <i class="fa-solid fa-list-check"></i>
                <select name="status">
                    <option value="All" ${param.status == 'All' ? 'selected' : ''}>All Events</option>
                    <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Pending Review</option>
                    <option value="Notified" ${param.status == 'Notified' ? 'selected' : ''}>Warning Sent</option>
                </select>
            </div>
            <button type="submit" class="btn-search">
                <i class="fa-solid fa-magnifying-glass me-2"></i> Apply Filter
            </button>
        </form>

        <!-- FEATURED STATS -->
        <h3 class="section-title font-heading">Overview Statistics</h3>
        <div class="row g-4 mb-5">
            <!-- Stat 1: Total Violations -->
            <div class="col-md-4">
                <div class="unified-card text-center align-items-center">
                    <div class="stat-icon" style="background: #e0f2fe; color: #3b82f6;">
                        <i class="fa-solid fa-car-burst"></i>
                    </div>
                    <h2 class="font-heading fw-bold mb-1">${totalViolations != null ? totalViolations : 0}</h2>
                    <span class="text-muted fw-bold small text-uppercase">Total Violations</span>
                </div>
            </div>
            <!-- Stat 2: Pending Reviews -->
            <div class="col-md-4">
                <div class="unified-card text-center align-items-center">
                    <div class="stat-icon" style="background: #fef3c7; color: #d97706;">
                        <i class="fa-solid fa-file-signature"></i>
                    </div>
                    <h2 class="font-heading fw-bold mb-1">${pendingViolations != null ? pendingViolations : 0}</h2>
                    <span class="text-muted fw-bold small text-uppercase">Pending Review</span>
                </div>
            </div>
            <!-- Stat 3: Warnings Sent -->
            <div class="col-md-4">
                <div class="unified-card text-center align-items-center">
                    <div class="stat-icon" style="background: #e0e7ff; color: #4f46e5;">
                        <i class="fa-solid fa-paper-plane"></i>
                    </div>
                    <h2 class="font-heading fw-bold mb-1">${notifiedViolations != null ? notifiedViolations : 0}</h2>
                    <span class="text-muted fw-bold small text-uppercase">Warnings Sent</span>
                </div>
            </div>
        </div>

        <!-- RECENT VIOLATIONS -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="section-title font-heading mb-0">Recent Violations</h3>
            <div class="d-flex gap-3 align-items-center">
                <div class="d-flex align-items-center gap-2">
                    <label class="small fw-bold text-muted mb-0">Grid Size:</label>
                    <select id="gridSizeSelector" class="form-select form-select-sm" style="width: auto; border-radius: var(--radius-pill);">
                        <option value="col-lg-3" selected>Small (4/row)</option>
                        <option value="col-lg-4">Medium (3/row)</option>
                        <option value="col-lg-6">Large (2/row)</option>
                    </select>
                </div>
                <div class="d-flex align-items-center gap-2">
                    <label class="small fw-bold text-muted mb-0">Items/Page:</label>
                    <select id="pageSizeSelector" class="form-select form-select-sm" style="width: auto; border-radius: var(--radius-pill);">
                        <option value="4">4</option>
                        <option value="8" selected>8</option>
                        <option value="16">16</option>
                        <option value="99999">All</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row g-4 pb-4" id="violations-grid">
            <c:choose>
                <c:when test="${not empty requestScope.violationList}">
                    <c:forEach items="${requestScope.violationList}" var="v">
                        <div class="violation-item col-md-6 col-lg-3">
                            <div class="unified-card violation">
                                <div class="v-img-wrapper">
                                    <span class="v-badge ${v.adminStatus == 'Pending' ? 'pending' : 'notified'}">
                                        <i class="fa-solid ${v.adminStatus == 'Pending' ? 'fa-clock' : 'fa-check'} me-1"></i> ${v.adminStatus}
                                    </span>
                                    <img src="${not empty v.imageUrl ? v.imageUrl : 'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?auto=format&fit=crop&w=400&q=80'}" class="v-img" alt="Snapshot">
                                </div>
                                
                                <div class="v-plate font-heading">${not empty v.licensePlate ? v.licensePlate : v.guestLicensePlate}</div>
                                <div class="text-muted small fw-bold mb-2"><i class="fa-regular fa-calendar me-1"></i> <fmt:formatDate value="${v.timestamp}" pattern="dd MMM, HH:mm" /></div>
                                
                                <div class="d-flex align-items-baseline mb-3">
                                    <div class="v-speed">${v.recordedSpeed}</div>
                                    <div class="text-muted fw-semibold ms-2 small">/ ${v.speedLimit} km/h</div>
                                </div>
                                
                                <div class="v-action">
                                    <div class="small fw-bold" style="color: #cbd5e1;">#EVT-${v.eventId}</div>
                                    <button type="button" class="v-btn btn-view-detail"
                                            data-id="${v.eventId}" 
                                            data-plate="${not empty v.licensePlate ? v.licensePlate : v.guestLicensePlate}"
                                            data-speed="${v.recordedSpeed}" 
                                            data-limit="${v.speedLimit}"
                                            data-time="<fmt:formatDate value="${v.timestamp}" pattern="dd/MM/yyyy hh:mm a" />"
                                            data-owner="${not empty v.ownerName ? v.ownerName : 'Unknown (Guest)'}"
                                            data-email="${not empty v.ownerEmail ? v.ownerEmail : 'N/A'}"
                                            data-img="${v.imageUrl}"
                                            data-bs-toggle="modal" data-bs-target="#detailModal">
                                        Review
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <!-- Empty State -->
                    <div class="col-12 text-center py-5">
                        <i class="fa-solid fa-folder-open mb-3" style="font-size: 4rem; color: #cbd5e1;"></i>
                        <h4 class="font-heading text-muted fw-bold">No violation records found.</h4>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Pagination Controls -->
        <div class="d-flex justify-content-center pb-5" id="pagination-controls">
            <!-- Dynamically populated by JS -->
        </div>
    </div>

    <!-- MODAL REVIEW -->
    <div class="modal fade" id="detailModal" tabindex="-1">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content p-2">
                <div class="modal-header border-0 pb-0 mt-3 mx-3">
                    <h4 class="font-heading text-dark fw-bold mb-0">Event Details <span id="m_id" class="text-muted fs-5"></span></h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-4">
                        <div class="col-md-6">
                            <img id="m_img" src="" class="img-fluid w-100 object-fit-cover" style="height: 260px; border-radius: 20px; box-shadow: 0 10px 20px rgba(0,0,0,0.05);" alt="Snapshot">
                        </div>
                        <div class="col-md-6">
                            <div class="p-4 mb-3" style="background: #f8fafc; border-radius: 20px;">
                                <h6 class="font-heading text-primary mb-3 fw-bold"><i class="fa-solid fa-car me-2"></i>Vehicle Info</h6>
                                <p class="mb-2"><span class="text-muted fw-bold">Plate:</span> <strong class="fs-5 ms-2 text-dark" id="m_plate"></strong></p>
                                <p class="mb-2"><span class="text-muted fw-bold">Speed:</span> <strong class="ms-2 fs-5 text-danger" id="m_speed"></strong> <span class="small text-muted">(Limit: <span id="m_limit"></span>)</span></p>
                                <p class="mb-0"><span class="text-muted fw-bold">Time:</span> <span class="ms-2 fw-bold text-dark" id="m_time"></span></p>
                            </div>
                            <div class="p-4" style="border: 2px dashed #e2e8f0; border-radius: 20px;">
                                <h6 class="font-heading text-dark mb-3 fw-bold"><i class="fa-solid fa-user-circle me-2 text-muted"></i>Owner Profile</h6>
                                <p class="mb-2"><span class="text-muted fw-bold">Name:</span> <strong class="ms-2 text-dark" id="m_owner"></strong></p>
                                <p class="mb-0"><span class="text-muted fw-bold">Email:</span> <span class="ms-2 fw-bold text-primary" id="m_email"></span></p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <form action="ProcessViolationController" method="POST" class="modal-footer border-0 p-4 pt-0">
                    <input type="hidden" name="eventId" id="f_eventId">
                    <button type="submit" name="action" value="ignore" class="btn fw-bold px-4 me-auto" style="background: #fee2e2; color: #dc2626; border-radius: 50px;">
                        <i class="fa-solid fa-xmark me-2"></i> Dismiss Error
                    </button>
                    <button type="button" class="btn fw-bold px-4" style="background: #f1f5f9; color: #64748b; border-radius: 50px;" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" name="action" value="notify" class="btn btn-logout border-0" style="padding: 8px 24px;">
                        <i class="fa-solid fa-paper-plane me-2"></i> Send Warning
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap & Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.querySelectorAll('.btn-view-detail').forEach(button => {
            button.addEventListener('click', function() {
                document.getElementById('m_id').innerText = '#EVT-' + this.getAttribute('data-id');
                document.getElementById('m_plate').innerText = this.getAttribute('data-plate');
                document.getElementById('m_speed').innerText = this.getAttribute('data-speed') + ' km/h';
                document.getElementById('m_limit').innerText = this.getAttribute('data-limit') + ' km/h';
                document.getElementById('m_time').innerText = this.getAttribute('data-time');
                document.getElementById('m_owner').innerText = this.getAttribute('data-owner');
                document.getElementById('m_email').innerText = this.getAttribute('data-email');
                
                const imgSrc = this.getAttribute('data-img');
                document.getElementById('m_img').src = (imgSrc && imgSrc.trim() !== '') ? imgSrc : 'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?auto=format&fit=crop&w=800&q=80';
                document.getElementById('f_eventId').value = this.getAttribute('data-id');
            });
        });

        // Grid Size & Pagination Logic
        document.addEventListener("DOMContentLoaded", function() {
            const gridSelector = document.getElementById("gridSizeSelector");
            const pageSizeSelector = document.getElementById("pageSizeSelector");
            const items = Array.from(document.querySelectorAll(".violation-item"));
            const paginationContainer = document.getElementById("pagination-controls");
            
            let currentPage = 1;
            let itemsPerPage = parseInt(pageSizeSelector.value);

            // Change Grid Column Size
            gridSelector.addEventListener("change", function() {
                const newClass = this.value; // e.g. col-lg-4
                items.forEach(item => {
                    item.classList.remove("col-lg-3", "col-lg-4", "col-lg-6");
                    item.classList.add(newClass);
                });
            });

            // Change Items Per Page
            pageSizeSelector.addEventListener("change", function() {
                itemsPerPage = parseInt(this.value);
                currentPage = 1;
                renderPagination();
            });

            function renderPagination() {
                if (items.length === 0) return;
                
                const totalPages = Math.ceil(items.length / itemsPerPage);
                paginationContainer.innerHTML = "";

                if (totalPages > 1) {
                    const ul = document.createElement("ul");
                    ul.className = "pagination";
                    
                    for (let i = 1; i <= totalPages; i++) {
                        const li = document.createElement("li");
                        li.className = "page-item" + (i === currentPage ? " active" : "");
                        
                        const a = document.createElement("a");
                        a.className = "page-link";
                        a.href = "javascript:void(0)";
                        a.innerText = i;
                        a.style.borderRadius = "var(--radius-pill)";
                        a.style.margin = "0 4px";
                        
                        if(i === currentPage) {
                            a.style.background = "var(--primary)";
                            a.style.color = "white";
                            a.style.border = "none";
                        }
                        
                        a.addEventListener("click", () => {
                            currentPage = i;
                            renderPagination();
                        });
                        
                        li.appendChild(a);
                        ul.appendChild(li);
                    }
                    paginationContainer.appendChild(ul);
                }

                // Show/hide items based on page
                const startIndex = (currentPage - 1) * itemsPerPage;
                const endIndex = startIndex + itemsPerPage;

                items.forEach((item, index) => {
                    if (index >= startIndex && index < endIndex) {
                        item.style.display = "block";
                    } else {
                        item.style.display = "none";
                    }
                });
            }

            // Initial render
            renderPagination();
        });
    </script>
</body>
</html>