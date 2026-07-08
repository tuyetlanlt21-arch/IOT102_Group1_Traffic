<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="activePage" value="${empty param.activePage ? 'violations' : param.activePage}" />

<nav id="sidebar">
    <div class="d-flex align-items-center mb-5 px-4 mt-4">
        <div class="bg-primary text-white d-flex align-items-center justify-content-center me-3 shadow-sm" style="width: 42px; height: 42px; border-radius: 12px; background-color: #3b82f6 !important;">
            <i class="fa-solid fa-gauge-high fs-5"></i>
        </div>
        <div>
            <h4 class="mb-0 fw-bold font-poppins text-dark" style="letter-spacing: -0.5px;">UrbanSafe</h4>
            <small class="text-muted fw-bold d-block" style="font-size: 0.65rem; letter-spacing: 1.5px;">WORKSPACE</small>
        </div>
    </div>

    <ul class="list-unstyled flex-grow-1">
        <li>
            <a href="AdminViolationsController" class="sidebar-link ${activePage == 'violations' ? 'active' : ''}">
                <i class="fa-solid fa-video"></i> Violations History
            </a>
        </li>
        <li>
            <a href="FrequentViolationController" class="sidebar-link ${activePage == 'frequent' ? 'active' : ''}">
                <i class="fa-solid fa-triangle-exclamation"></i> Penalty Issuance
            </a>
        </li>
        <li>
            <a href="StatisticsController" class="sidebar-link ${activePage == 'statistics' ? 'active' : ''}">
                <i class="fa-solid fa-chart-pie"></i> Data & Analytics
            </a>
        </li>
    </ul>

    <div class="mt-auto p-4 mb-2">
        <div class="d-flex align-items-center mb-4 bg-white soft-card p-3 border">
            <div class="text-white d-flex align-items-center justify-content-center me-3 fw-bold rounded-circle shadow-sm" style="width: 40px; height: 40px; background-color: #5a4bfa; font-size: 0.9rem;">
                AD
            </div>
            <div class="overflow-hidden">
                <h6 class="mb-0 fw-bold text-dark font-poppins fs-6 text-truncate">System Admin</h6>
                <small class="text-muted fw-semibold d-block" style="font-size: 0.75rem;">Administrator</small>
            </div>
        </div>
        <a href="LogoutController" class="text-dark fw-bold text-decoration-none d-flex align-items-center px-2 sidebar-btn-logout">
            <i class="fa-solid fa-power-off me-3 fs-5"></i> Sign Out
        </a>
    </div>
</nav>