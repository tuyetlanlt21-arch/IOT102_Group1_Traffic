<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Penalty Issuance | UrbanSafe Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/admin_style.css">
</head>
<body>
    <jsp:include page="admin_sidebar.jsp">
        <jsp:param name="activePage" value="frequent" />
    </jsp:include>

    <main class="main-content" id="content">
        <div class="container-fluid p-4 p-md-5">
            <div class="d-flex justify-content-between align-items-start mb-5">
                <div>
                    <h3 class="font-poppins fw-bold text-dark mb-1">Penalty Issuance</h3>
                    <span class="text-muted small fw-semibold">Auto-filtered residents with 3 or more violations this month.</span>
                </div>
                <div class="text-end d-none d-md-block">
                    <small class="text-muted fw-bold d-block mb-1">Today's Date</small>
                    <strong class="text-primary font-poppins fs-5" style="color: #3b82f6 !important;">
                        <jsp:useBean id="now" class="java.util.Date" />
                        <fmt:formatDate value="${now}" pattern="dd MMM, yyyy" />
                    </strong>
                </div>
            </div>

            <div class="bg-white soft-card py-2 px-3">
                <div class="table-responsive">
                    <table class="table table-spaced mb-0">
                        <thead>
                            <tr>
                                <th>Resident Account</th>
                                <th>Primary Plate</th>
                                <th class="text-center">Violations (This Month)</th>
                                <th>Penalty Status</th>
                                <th class="text-end">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty requestScope.frequentList}">
                                    <c:forEach items="${requestScope.frequentList}" var="f">
                                        <tr>
                                            <td>
                                                <div class="font-poppins text-dark fs-6 fw-bold">${f.account.fullName}</div>
                                                <small class="text-muted fw-semibold">${f.account.email}</small>
                                            </td>
                                            <td>
                                                <span class="badge bg-light text-dark border rounded-pill px-3 py-2">
                                                    ${f.vehicle.licensePlate}
                                                </span>
                                            </td>
                                            <td class="text-center">
                                                <span class="badge bg-danger rounded-pill px-3 py-2 text-white fw-bold">
                                                    ${f.violationCount} Times
                                                </span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${f.hasUnpaidTicket}">
                                                        <span class="badge bg-warning text-dark rounded-pill px-3">Unpaid Ticket</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-light text-muted border rounded-pill px-3">No Ticket</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-end">
                                                <form action="IssuePenaltyController" method="POST">
                                                    <input type="hidden" name="accountId" value="${f.account.accountID}">
                                                    <button type="submit" class="btn btn-primary-pill" ${f.hasUnpaidTicket ? 'disabled' : ''}>
                                                        <i class="fa-solid fa-file-invoice-dollar me-2"></i> Issue Fine
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="text-center py-5 border-0">
                                            <div class="py-4">
                                                <i class="fa-solid fa-check-circle text-success opacity-75 fs-1 mb-3" style="font-size: 3.5rem;"></i>
                                                <h6 class="text-dark fw-bold font-poppins">All clear! No frequent violators this month.</h6>
                                            </div>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>