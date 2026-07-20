<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dto.Account" %>
<%@ page import="dto.Vehicle" %>
<%@ page import="dto.ViolationEvent" %>
<%@ page import="dto.PenaltyTicket" %>
<%
    Account account = (Account) request.getAttribute("ACCOUNT");
    List<Vehicle> vehicleList = (List<Vehicle>) request.getAttribute("VEHICLE_LIST");
    List<ViolationEvent> violationList = (List<ViolationEvent>) request.getAttribute("VIOLATION_LIST");
    List<PenaltyTicket> ticketList = (List<PenaltyTicket>) request.getAttribute("TICKET_LIST");

    if (account == null) {
        response.sendRedirect("CusDashboardController");
        return;
    }

    // Chỉ đếm size của list, loại bỏ hoàn toàn vòng lặp for tính unpaid
    int totalVehicles = (vehicleList != null) ? vehicleList.size() : 0;
    int totalViolations = (violationList != null) ? violationList.size() : 0;
    int totalTickets = (ticketList != null) ? ticketList.size() : 0;
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Resident Dashboard - UrbanSafe</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&family=Poppins:wght@500;600;700;800&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-light bg-white/80 backdrop-blur sticky-top soft-shadow py-3">
            <div class="container d-flex justify-content-between align-items-center">
                <a class="navbar-brand d-flex align-items-center m-0" href="index.jsp">
                    <i class="fa-solid fa-gauge-high text-primary fs-3 me-2"></i>
                    <div>
                        <h5 class="mb-0 fw-bold text-dark section-title">UrbanSafe</h5>
                        <small class="text-muted d-block" style="font-size: 0.75rem;">Resident Portal</small>
                    </div>
                </a>
                <div class="d-flex align-items-center gap-3">
                    <span class="text-muted small d-none d-md-inline">Logged in as <strong class="text-dark"><%= account.getFullName()%></strong></span>
                    <a href="LogoutController" class="btn btn-outline-secondary rounded-pill px-4 py-2 small fw-semibold hover-lift">
                        <i class="fa-solid fa-arrow-right-from-bracket me-1"></i> Logout
                    </a>
                </div>
            </div>
        </nav>

        <main class="container my-5 flex-grow-1">

            <div class="mb-5">
                <h3 class="fw-bold mb-1 section-title">Welcome back, <%= account.getFullName()%> </h3>
                <p class="text-muted mb-0">Here's your vehicle monitoring and traffic safety overview today.</p>
            </div>

            <% if (request.getAttribute("ERROR") != null) {%>
            <div class="alert alert-danger bg-danger bg-opacity-10 border-0 text-danger rounded-4 fw-bold mb-4 p-3">
                <i class="fa-solid fa-triangle-exclamation me-2"></i> <%= request.getAttribute("ERROR")%>
            </div>
            <% }%>

            <div class="row g-4 mb-5">
                <div class="col-md-4">
                    <div class="bg-white soft-card p-4 hover-lift d-flex justify-content-between align-items-center">
                        <div>
                            <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.75rem;">REGISTERED VEHICLES</small>
                            <h2 class="fw-bold mb-0 text-dark"><%= totalVehicles%></h2>
                        </div>
                        <div class="icon-box-small bg-light-blue text-primary"><i class="fa-solid fa-car"></i></div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="bg-white soft-card p-4 hover-lift d-flex justify-content-between align-items-center">
                        <div>
                            <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.75rem;">RECORDED VIOLATIONS</small>
                            <h2 class="fw-bold mb-0 text-warning"><%= totalViolations%></h2>
                        </div>
                        <div class="icon-box-small bg-light-orange text-warning"><i class="fa-solid fa-triangle-exclamation"></i></div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="bg-white soft-card p-4 hover-lift d-flex justify-content-between align-items-center">
                        <div>
                            <small class="text-muted fw-bold d-block mb-1" style="font-size: 0.75rem;">TOTAL TICKETS</small>
                            <h2 class="fw-bold mb-0 text-danger"><%= totalTickets%></h2>
                        </div>
                        <div class="icon-box-small bg-danger bg-opacity-10 text-danger"><i class="fa-solid fa-receipt"></i></div>
                    </div>
                </div>
            </div>

            <div class="row g-4">

                <div class="col-lg-3">
                    <div class="bg-white soft-card p-4 text-center h-100">
                        <div class="rounded-circle bg-dark text-white d-flex align-items-center justify-content-center mx-auto mb-3 shadow" style="width: 80px; height: 80px; font-size: 2rem; font-weight: bold;">
                            <%= account.getFullName().substring(0, 1).toUpperCase()%>
                        </div>
                        <h5 class="fw-bold mb-1 section-title"><%= account.getFullName()%></h5>
                        <span class="badge bg-light-blue text-primary fw-semibold mb-4 px-3 py-2 rounded-pill">Resident Account</span>

                        <div class="text-start border-top pt-3 small">
                            <div class="mb-3">
                                <small class="text-muted d-block fw-bold mb-1" style="font-size: 0.7rem;">USERNAME</small>
                                <span class="fw-semibold text-dark"><%= account.getUsername()%></span>
                            </div>
                            <div class="mb-3">
                                <small class="text-muted d-block fw-bold mb-1" style="font-size: 0.7rem;">EMAIL ADDRESS</small>
                                <span class="fw-semibold text-dark"><%= account.getEmail()%></span>
                            </div>
                            <div>
                                <small class="text-muted d-block fw-bold mb-1" style="font-size: 0.7rem;">ACCOUNT STATUS</small>
                                <% if (account.isIsVerified()) { %>
                                <span class="badge bg-light-green text-success px-2 py-1"><i class="fa-solid fa-check-circle me-1"></i> Verified</span>
                                <% } else { %>
                                <span class="badge bg-light-orange text-warning px-2 py-1"><i class="fa-solid fa-clock me-1"></i> Pending</span>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-5">
                    <div class="bg-white soft-card p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-4">
                            <h5 class="fw-bold mb-0 d-flex align-items-center section-title">
                                <i class="fa-solid fa-car-side text-primary me-2"></i> My Vehicles
                            </h5>
                            <button class="btn btn-dark rounded-pill px-3 fw-semibold shadow-sm hover-lift" data-bs-toggle="modal" data-bs-target="#addVehicleModal">
                                <i class="fa-solid fa-plus me-1"></i> Add Vehicle
                            </button>
                        </div>

                        <div style="max-height: 400px; overflow-y: auto;" class="pe-2">
                            <% if (vehicleList != null && !vehicleList.isEmpty()) {
                                    for (Vehicle v : vehicleList) {%>

                            <div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
                                <div>
                                    <h6 class="fw-bold mb-1 section-title"><%= v.getBrand()%></h6>
                                    <span class="badge border text-dark me-1"><i class="fa-solid fa-car-side text-muted"></i> Vehicle</span>
                                    <span class="badge <%= "Active".equalsIgnoreCase(v.getStatus()) ? "bg-light-green text-success" : "bg-light-orange text-warning"%>"><%= v.getStatus()%></span>
                                </div>
                                <div>
                                    <span class="badge bg-dark px-3 py-2 fs-6 shadow-sm"><%= v.getLicensePlate()%></span>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-outline-secondary btn-sm rounded-3" data-bs-toggle="modal" data-bs-target="#editModal_<%= v.getVehicleId()%>"><i class="fa-solid fa-pen"></i></button>
                                    <button class="btn btn-outline-danger btn-sm rounded-3" data-bs-toggle="modal" data-bs-target="#deleteModal_<%= v.getVehicleId()%>"><i class="fa-solid fa-trash"></i></button>
                                </div>
                            </div>

                            <%  }
                            } else { %>
                            <div class="text-center py-5 text-muted">
                                <i class="fa-solid fa-car-on fs-1 mb-3 text-secondary opacity-50"></i>
                                <p>No vehicles registered yet.</p>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="bg-white soft-card p-4 h-100">
                        <div class="border-bottom pb-3 mb-4">
                            <h5 class="fw-bold mb-0 d-flex align-items-center section-title">
                                <i class="fa-solid fa-triangle-exclamation text-warning me-2"></i> Violations & Tickets
                            </h5>
                        </div>

                        <div style="max-height: 400px; overflow-y: auto;" class="pe-2">

                            <% if (ticketList != null && !ticketList.isEmpty()) {
                                    for (PenaltyTicket ticket : ticketList) {
                                        boolean isUnpaid = "Unpaid".equalsIgnoreCase(ticket.getStatus());
                            %>
                            <div class="bg-light-gray rounded-4 p-3 mb-3 border <%= isUnpaid ? "border-danger border-opacity-25" : "border-success border-opacity-25"%>">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="fw-bold text-dark"><i class="fa-solid fa-receipt me-1 <%= isUnpaid ? "text-danger" : "text-success"%>"></i> Ticket #<%= ticket.getTicketId()%></span>
                                    <span class="badge <%= isUnpaid ? "bg-danger" : "bg-success"%>"><%= ticket.getStatus()%></span>
                                </div>
                                <div class="d-flex justify-content-between bg-white p-2 rounded-3 border mb-2">
                                    <span class="text-muted small">Fine Amount:</span>
                                    <strong class="text-danger"><%= String.format("%,.0f", ticket.getFineAmount())%> VNĐ</strong>
                                </div>
                                <% if (isUnpaid) { %>
                                <small class="text-danger d-block"><i class="fa-solid fa-circle-info me-1"></i> Visit office to pay offline.</small>
                                <% } else {%>
                                <small class="text-success d-block"><i class="fa-solid fa-check-circle me-1"></i> Paid: <%= ticket.getPaymentDate()%></small>
                                <% } %>
                            </div>
                            <%  }
                                } %>

                            <% if (violationList != null && !violationList.isEmpty()) {
                                    for (ViolationEvent ve : violationList) {%>

                            <div class="bg-light-gray rounded-4 p-3 mb-3 border">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="fw-bold text-dark">Speeding Error</span>
                                    <span class="badge bg-warning text-dark"><%= ve.getAdminStatus()%></span>
                                </div>
                                <p class="text-muted small mb-2">Vehicle <strong class="text-dark"><%= ve.getLicensePlate()%></strong> exceeded limit.</p>
                                <div class="d-flex justify-content-between bg-white p-2 rounded-3 border small">
                                    <span><i class="fa-solid fa-gauge text-danger me-1"></i> <strong class="text-danger"><%= ve.getRecordedSpeed()%> km/h</strong></span>
                                    <span class="text-muted"><%= ve.getTimestamp()%></span>
                                </div>
                            </div>

                            <%  }
                                } %>

                            <% if ((ticketList == null || ticketList.isEmpty()) && (violationList == null || violationList.isEmpty())) { %>
                            <div class="text-center py-5 text-muted">
                                <i class="fa-solid fa-shield-halved fs-1 mb-3 text-success opacity-50"></i>
                                <p>No speeding violations recorded.</p>
                            </div>
                            <% } %>

                        </div>
                    </div>
                </div>

            </div>
        </main>

        <footer class="bg-white py-4 border-top mt-auto">
            <div class="container text-center text-muted small fw-semibold">
                © 2026 UrbanSafe. All rights reserved.
            </div>
        </footer>

        <div class="modal fade" id="addVehicleModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content soft-card p-3">
                    <div class="modal-header border-0">
                        <h5 class="fw-bold section-title mb-0">Register New Vehicle</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="AddVehicleController" method="POST">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-muted">LICENSE PLATE</label>
                                <input type="text" class="form-control soft-input text-uppercase fw-bold" 
                                       name="licensePlate" 
                                       placeholder="e.g., 63A-12345, 63AF-12345, 63A1-12345" 
                                       pattern="[0-9]{2}[a-zA-Z0-9]{1,2}-[0-9]{4,5}"
                                       title="Định dạng hợp lệ: 63A-12345, 63AF-12345 hoặc 63A1-12345" 
                                       required>                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-muted">BRAND / MODEL</label>
                                <input type="text" class="form-control soft-input" name="brand" placeholder="e.g., Honda AirBlade" required>
                            </div>
                        </div>
                        <div class="modal-footer border-0">
                            <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary rounded-pill px-4 hover-lift">Add Vehicle</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <% if (vehicleList != null) {
                for (Vehicle v : vehicleList) {%>

        <div class="modal fade" id="editModal_<%= v.getVehicleId()%>" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content soft-card p-3">
                    <div class="modal-header border-0">
                        <h5 class="fw-bold section-title mb-0">Edit Vehicle Info</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="UpdateVehicleController" method="POST">
                        <input type="hidden" name="vehicleId" value="<%= v.getVehicleId()%>">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-muted">LICENSE PLATE</label>
                                <input type="text" class="form-control soft-input text-uppercase fw-bold" 
                                       name="licensePlate" 
                                       value="<%= v.getLicensePlate()%>" 
                                       pattern="[0-9]{2}[a-zA-Z0-9]{1,3}-[0-9]{4,5}"
                                       title="Định dạng hợp lệ: 63A-12345, 63AF-12345 hoặc 63A1-12345" 
                                       required>                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-muted">BRAND / MODEL</label>
                                <input type="text" class="form-control soft-input" name="brand" value="<%= v.getBrand()%>" required>
                            </div>
                        </div>
                        <div class="modal-footer border-0">
                            <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary rounded-pill px-4 hover-lift">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="deleteModal_<%= v.getVehicleId()%>" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered modal-sm">
                <div class="modal-content soft-card text-center p-4">
                    <div class="icon-box-small bg-danger bg-opacity-10 text-danger mx-auto mb-3">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                    </div>
                    <h5 class="fw-bold section-title mb-2">Delete Vehicle?</h5>
                    <p class="text-muted small mb-4">Are you sure you want to remove <strong class="text-dark"><%= v.getLicensePlate()%></strong>?</p>
                    <div class="d-flex justify-content-center gap-2">
                        <button type="button" class="btn btn-light rounded-pill px-4 w-50" data-bs-dismiss="modal">Cancel</button>
                        <a href="DeleteVehicleController?id=<%= v.getVehicleId()%>" class="btn btn-danger rounded-pill px-4 w-50 fw-bold">Delete</a>
                    </div>
                </div>
            </div>
        </div>

        <%  }
            }%>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>