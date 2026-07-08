<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Violations History | UrbanSafe Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/admin_style.css">
</head>
<body>
    
    <jsp:include page="admin_sidebar.jsp">
        <jsp:param name="activePage" value="violations" />
    </jsp:include>

    <main class="main-content" id="content">
        <div class="container-fluid p-4 p-md-5">
            
            <div class="d-flex justify-content-between align-items-start mb-5">
                <div>
                    <h3 class="font-poppins fw-bold text-dark mb-1">Violations History</h3>
                    <span class="text-muted small fw-semibold">Review, verify and issue warnings for overspeeding events.</span>
                </div>
                <div class="text-end d-none d-md-block">
                    <small class="text-muted fw-bold d-block mb-1">Today's Date</small>
                    <strong class="text-primary font-poppins fs-5" style="color: #3b82f6 !important;">
                        <jsp:useBean id="now" class="java.util.Date" />
                        <fmt:formatDate value="${now}" pattern="dd MMM, yyyy" />
                    </strong>
                </div>
            </div>

            <form action="AdminViolationsController" method="GET" class="bg-white soft-card p-4 mb-4 d-flex gap-4 align-items-end flex-wrap">
                <div class="flex-grow-1" style="max-width: 200px;">
                    <label class="form-label small fw-bold text-muted mb-2">From Date</label>
                    <input type="date" class="form-control soft-input w-100" name="startDate" value="${param.startDate}">
                </div>
                <div class="flex-grow-1" style="max-width: 200px;">
                    <label class="form-label small fw-bold text-muted mb-2">To Date</label>
                    <input type="date" class="form-control soft-input w-100" name="endDate" value="${param.endDate}">
                </div>
                <div class="flex-grow-1" style="max-width: 200px;">
                    <label class="form-label small fw-bold text-muted mb-2">Status</label>
                    <select class="form-select soft-input w-100" name="status">
                        <option value="All" ${param.status == 'All' ? 'selected' : ''}>All Events</option>
                        <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Pending Review</option>
                        <option value="Notified" ${param.status == 'Notified' ? 'selected' : ''}>Warning Sent</option>
                        <option value="Guest" ${param.status == 'Guest' ? 'selected' : ''}>Guest Vehicle</option>
                    </select>
                </div>
                <div class="ms-auto">
                    <button type="submit" class="btn btn-primary-pill">
                        <i class="fa-solid fa-filter me-2"></i> Apply Filter
                    </button>
                </div>
            </form>

            <div class="bg-white soft-card py-2 px-3">
                <div class="table-responsive">
                    <table class="table table-spaced mb-0">
                        <thead>
                            <tr>
                                <th>Event ID</th>
                                <th>License Plate</th>
                                <th>Timestamp</th>
                                <th>Speed (km/h)</th>
                                <th>Status</th>
                                <th class="text-end">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty requestScope.violationList}">
                                    <c:forEach items="${requestScope.violationList}" var="v">
                                        <tr>
                                            <td class="text-muted fw-bold small">#EVT-${v.eventId}</td>
                                            
                                            <td>
                                                <span class="badge bg-light text-dark border rounded-pill px-3 py-2">
                                                    ${not empty v.licensePlate ? v.licensePlate : v.guestLicensePlate}
                                                </span>
                                            </td>
                                            
                                            <td class="small fw-semibold text-muted">
                                                <fmt:formatDate value="${v.timestamp}" pattern="dd/MM/yyyy hh:mm a" />
                                            </td>
                                            <td>
                                                <strong class="text-danger">${v.recordedSpeed}</strong> 
                                                <span class="small text-muted">/ ${v.speedLimit}</span>
                                            </td>
                                            <td>
                                                <c:if test="${v.adminStatus == 'Pending'}"><span class="badge bg-warning text-dark rounded-pill px-3">Pending</span></c:if>
                                                <c:if test="${v.adminStatus == 'Notified'}"><span class="badge bg-success rounded-pill px-3">Notified</span></c:if>
                                                <c:if test="${v.adminStatus == 'Ignored'}"><span class="badge bg-secondary rounded-pill px-3">Ignored</span></c:if>
                                                <c:if test="${v.adminStatus == 'Guest_Vehicle'}"><span class="badge bg-info text-dark rounded-pill px-3">Guest</span></c:if>
                                            </td>
                                            <td class="text-end">
                                                <button type="button" class="btn btn-sm btn-light fw-bold text-primary rounded-pill px-3 btn-view-detail"
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
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="text-center py-5 border-0">
                                            <div class="py-4">
                                                <i class="fa-solid fa-folder text-secondary opacity-50 mb-3" style="font-size: 3.5rem;"></i>
                                                <h6 class="text-dark fw-bold font-poppins">No violation records found.</h6>
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

    <div class="modal fade" id="detailModal" tabindex="-1">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content soft-card p-2 border-0">
                <div class="modal-header border-0 pb-0 mt-3 mx-3">
                    <h4 class="font-poppins text-dark fw-bold mb-0">Violation Details <span id="m_id" class="text-muted fs-5"></span></h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="fw-bold text-muted small mb-2 text-uppercase" style="letter-spacing: 1px;">Evidence Snapshot</label>
                            <img id="m_img" src="" class="img-fluid rounded-4 shadow-sm w-100 object-fit-cover" style="height: 250px;" alt="Snapshot">
                        </div>
                        <div class="col-md-6">
                            <div class="p-4 rounded-4 mb-3" style="background-color: #eff6ff;">
                                <h6 class="font-poppins text-primary mb-3 fw-bold"><i class="fa-solid fa-car me-2"></i>Vehicle Info</h6>
                                <p class="mb-2"><span class="text-muted fw-bold">Plate:</span> <strong class="fs-5 ms-2 text-dark" id="m_plate"></strong></p>
                                <p class="mb-2"><span class="text-muted fw-bold">Speed:</span> <strong class="ms-2 fs-5 text-danger" id="m_speed"></strong> <span class="small text-muted">(Limit: <span id="m_limit"></span>)</span></p>
                                <p class="mb-0"><span class="text-muted fw-bold">Time:</span> <span class="ms-2 fw-bold text-dark" id="m_time"></span></p>
                            </div>
                            
                            <div class="border border-2 p-4 rounded-4" style="border-color: #f1f5f9 !important;">
                                <h6 class="font-poppins text-dark mb-3 fw-bold"><i class="fa-solid fa-user me-2"></i>Owner Profile</h6>
                                <p class="mb-2"><span class="text-muted fw-bold">Name:</span> <strong class="ms-2 text-dark" id="m_owner"></strong></p>
                                <p class="mb-0"><span class="text-muted fw-bold">Email:</span> <span class="ms-2 fw-bold" style="color: #3b82f6;" id="m_email"></span></p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <form action="ProcessViolationController" method="POST" class="modal-footer border-0 p-4 pt-0">
                    <input type="hidden" name="eventId" id="f_eventId">
                    
                    <button type="submit" name="action" value="ignore" class="btn fw-bold px-4 me-auto" style="background-color: #fee2e2; color: #dc2626; border-radius: 50px;">
                        <i class="fa-solid fa-xmark me-2"></i> Dismiss (Error)
                    </button>
                    <button type="button" class="btn btn-light fw-bold px-4" style="border-radius: 50px; background-color: #f1f5f9;" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" name="action" value="notify" class="btn btn-primary-pill px-4 py-2">
                        <i class="fa-solid fa-envelope me-2"></i> Send Warning Email
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Javascript to inject Data into Modal dynamically
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
    </script>
</body>
</html>