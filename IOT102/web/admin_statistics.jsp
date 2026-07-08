<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data & Analytics | UrbanSafe Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/admin_style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    
    <jsp:include page="admin_sidebar.jsp">
        <jsp:param name="activePage" value="statistics" />
    </jsp:include>

    <main class="main-content">
        <div class="container-fluid p-4 p-md-5">
            <div class="d-flex justify-content-between align-items-start mb-5">
                <div>
                    <h3 class="font-poppins fw-bold text-dark mb-1">Data & Analytics</h3>
                    <span class="text-muted fw-semibold small">Comprehensive overview of traffic safety metrics.</span>
                </div>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="bg-white soft-card p-4 h-100 border-0">
                        <div class="d-flex align-items-center mb-3">
                            <div class="text-primary bg-primary bg-opacity-10 rounded-3 d-flex align-items-center justify-content-center me-3" style="width: 45px; height: 45px;">
                                <i class="fa-solid fa-calendar-day fs-5"></i>
                            </div>
                            <h6 class="text-muted fw-bold mb-0">Today's Violations</h6>
                        </div>
                        <h2 class="font-poppins fw-bold text-dark mb-0">${empty stats.todayViolations ? 0 : stats.todayViolations}</h2>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="bg-white soft-card p-4 h-100 border-0">
                        <div class="d-flex align-items-center mb-3">
                            <div class="text-warning bg-warning bg-opacity-10 rounded-3 d-flex align-items-center justify-content-center me-3" style="width: 45px; height: 45px;">
                                <i class="fa-solid fa-calendar-week fs-5"></i>
                            </div>
                            <h6 class="text-muted fw-bold mb-0">Monthly Violations</h6>
                        </div>
                        <h2 class="font-poppins fw-bold text-dark mb-0">${empty stats.monthViolations ? 0 : stats.monthViolations}</h2>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="bg-white soft-card p-4 h-100 border-0">
                        <div class="d-flex align-items-center mb-3">
                            <div class="text-danger bg-danger bg-opacity-10 rounded-3 d-flex align-items-center justify-content-center me-3" style="width: 45px; height: 45px;">
                                <i class="fa-solid fa-file-invoice fs-5"></i>
                            </div>
                            <h6 class="text-muted fw-bold mb-0">Unpaid Tickets</h6>
                        </div>
                        <h2 class="font-poppins fw-bold text-dark mb-0">${empty stats.unpaidTickets ? 0 : stats.unpaidTickets}</h2>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="bg-white soft-card p-4 h-100 border-0 position-relative overflow-hidden" style="background-color: #5a4bfa;">
                        <i class="fa-solid fa-sack-dollar position-absolute text-white opacity-25" style="font-size: 6rem; right: -10px; bottom: -10px;"></i>
                        <h6 class="text-white-50 fw-bold mb-3 mt-2">Total Fine Revenue</h6>
                        <h2 class="font-poppins fw-bold text-white mb-0">
                            <fmt:formatNumber value="${empty stats.totalRevenue ? 0 : stats.totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                        </h2>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="bg-white soft-card p-4 h-100 border-0">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="font-poppins fw-bold text-dark mb-0">Monthly Trend (Last 6 Months)</h5>
                        </div>
                        <canvas id="barChart" height="100"></canvas>
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <div class="bg-white soft-card p-4 h-100 border-0 d-flex flex-column">
                        <h5 class="font-poppins fw-bold text-dark mb-4">Violation Severity</h5>
                        <div style="height: 220px; display: flex; justify-content: center; flex-grow: 1;">
                            <canvas id="severityChart"></canvas>
                        </div>
                        <div class="mt-4">
                            <div class="d-flex justify-content-between mb-2 small fw-bold">
                                <span class="text-muted"><i class="fa-solid fa-circle text-info me-2"></i>Minor (&lt;10 over)</span>
                                <span class="text-dark">${empty stats.minorCount ? 0 : stats.minorCount}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2 small fw-bold">
                                <span class="text-muted"><i class="fa-solid fa-circle text-warning me-2"></i>Major (10-20 over)</span>
                                <span class="text-dark">${empty stats.majorCount ? 0 : stats.majorCount}</span>
                            </div>
                            <div class="d-flex justify-content-between small fw-bold">
                                <span class="text-muted"><i class="fa-solid fa-circle text-danger me-2"></i>Severe (&gt;20 over)</span>
                                <span class="text-dark">${empty stats.severeCount ? 0 : stats.severeCount}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script>
        const labelsData = ${empty requestScope.chartLabels ? "['No Data']" : requestScope.chartLabels};
        const violationsData = ${empty requestScope.chartData ? "[0]" : requestScope.chartData};
        
        const severityData = [
            ${empty stats.minorCount ? 0 : stats.minorCount}, 
            ${empty stats.majorCount ? 0 : stats.majorCount}, 
            ${empty stats.severeCount ? 0 : stats.severeCount}
        ];

        new Chart(document.getElementById('barChart').getContext('2d'), {
            type: 'bar',
            data: {
                labels: labelsData,
                datasets: [{
                    label: 'Violations',
                    data: violationsData,
                    backgroundColor: '#5a4bfa', // ĐÃ FIX: Màu cột đồ thị khớp thiết kế (#5a4bfa)
                    borderRadius: 8,
                    barThickness: 32
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: {
                    y: { border: {display: false}, grid: { color: '#f1f5f9' }, beginAtZero: true },
                    x: { border: {display: false}, grid: { display: false } }
                }
            }
        });

        new Chart(document.getElementById('severityChart').getContext('2d'), {
            type: 'doughnut',
            data: {
                labels: ['Minor', 'Major', 'Severe'],
                datasets: [{
                    data: severityData,
                    backgroundColor: ['#0dcaf0', '#ffc107', '#dc3545'],
                    borderWidth: 0,
                    hoverOffset: 4
                }]
            },
            options: { 
                responsive: true, 
                maintainAspectRatio: false,
                cutout: '75%',
                plugins: { legend: { display: false } }
            }
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>