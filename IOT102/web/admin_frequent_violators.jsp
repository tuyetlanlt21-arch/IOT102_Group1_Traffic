<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <div class="admin-wrapper">
        <jsp:include page="admin_sidebar.jsp">
            <jsp:param name="activePage" value="frequent" />
        </jsp:include>

        <div id="content">
            <header class="admin-header sticky-top p-4 d-flex justify-content-between align-items-center">
                <div>
                    <h3 class="font-heading mb-1 text-dark">Penalty Issuance</h3>
                    <span class="text-muted fw-semibold small">Auto-filtered residents with 3 or more violations this month.</span>
                </div>
            </header>

            <div class="container-fluid p-4">
                <div class="table-responsive mt-2">
                    <table class="table table-soft w-100">
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
                                                <div class="font-heading text-dark fs-6">${f.account.fullName}</div>
                                                <small class="text-muted fw-bold">${f.account.email}</small>
                                            </td>
                                            <td><span class="badge-soft bg-soft-info border-0">${f.vehicle.licensePlate}</span></td>
                                            <td class="text-center">
                                                <span class="badge-soft bg-soft-danger fs-6 px-3 shadow-sm">${f.violationCount} Times</span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${f.hasUnpaidTicket}">
                                                        <span class="badge-soft bg-soft-warning">Unpaid Ticket</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge-soft bg-light text-muted">No Ticket</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-end">
                                                <form action="IssuePenaltyController" method="POST">
                                                    <input type="hidden" name="accountId" value="${f.account.accountId}">
                                                    <button type="submit" class="btn btn-primary-gradient rounded-4 fw-bold px-4 py-2" ${f.hasUnpaidTicket ? 'disabled' : ''}>
                                                        <i class="fa-solid fa-file-invoice-dollar me-2"></i> Issue Fine
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="text-center py-5">
                                            <div class="text-muted fw-bold">
                                                <i class="fa-solid fa-check-circle text-success opacity-75 fs-1 mb-3"></i><br>
                                                All clear! No frequent violators this month.
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
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>