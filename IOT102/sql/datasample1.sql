USE TrafficMonitoringDB;
GO

-- ==========================================
-- 1. THEM DU LIEU BANG ROLE
-- role_id 1: Admin
-- role_id 2: Customer
-- ==========================================
INSERT INTO Role (role_name, description) VALUES 
('Admin', 'Ban quan ly, bao ve co quyen duyet anh va thu phat'),
('Customer', 'Sinh vien, giang vien hoac cu dan trong khu vuc');
GO

-- ==========================================
-- 2. THEM DU LIEU BANG ACCOUNT
-- ==========================================
INSERT INTO Account (username, password, full_name, email, role_id, is_verified) VALUES 
('admin_main', 'hash_123', 'Nguyen Quan Ly', 'admin@campus.edu.vn', 1, 1),
('guard_night', 'hash_456', 'Le Truc Dem', 'baove@campus.edu.vn', 1, 1),
('student01', 'hash_789', 'Tran Van A', 'tranvana@gmail.com', 2, 1),
('student02', 'hash_abc', 'Pham Thi B', 'phamb@gmail.com', 2, 1),
('student03', 'hash_xyz', 'Hoang Van C', 'hoangc2005@gmail.com', 2, 0); -- Chua xac thuc email
GO

-- ==========================================
-- 3. THEM DU LIEU BANG OTP_VERIFICATION
-- ==========================================
INSERT INTO OTP_Verification (email, otp_code, expires_at, is_used, type) VALUES 
('hoangc2005@gmail.com', '123456', DATEADD(MINUTE, 5, GETDATE()), 0, 'REGISTER'),
('tranvana@gmail.com', '654321', DATEADD(MINUTE, -10, GETDATE()), 1, 'FORGOT_PASS');
GO

-- ==========================================
-- 4. THEM DU LIEU BANG VEHICLE
-- Dinh dang Motorbike: 63A1-12345
-- Dinh dang Car: 63A-12345
-- ==========================================
INSERT INTO Vehicle (license_plate, account_id, brand, vehicle_type, status) VALUES 
('63A1-11111', 3, 'Honda', 'Motorbike', 'Active'),    -- Xe may cua student01
('63B1-22222', 4, 'Yamaha', 'Motorbike', 'Active'),   -- Xe may cua student02
('63A-33333', 4, 'Toyota', 'Car', 'Active'),          -- O to cua student02
('63C1-44444', 3, 'Suzuki', 'Motorbike', 'Inactive'), -- Xe cu cua student01 da ban
('63D1-55555', 5, 'Honda', 'Motorbike', 'Inactive');    -- Xe may cua student03 bi cam
GO

-- ==========================================
-- 5. THEM DU LIEU BANG PENALTY_TICKET
-- ==========================================
-- Luu y: Identity tu dong tang bat dau tu 1
INSERT INTO Penalty_Ticket (account_id, fine_amount, status, payment_date, resolved_by) VALUES 
(3, 100000.00, 'Paid', DATEADD(DAY, -2, GETDATE()), 1),  -- student01 da nop phat, nguoi thu la admin_main (ID 1)
(4, 250000.00, 'Unpaid', NULL, NULL),                    -- student02 bi phat nang do di o to, chua nop
(5, 50000.00, 'Cancelled', NULL, 2);                     -- Ve phat bi huy do nham lan, nguoi xu ly huy la guard_night (ID 2)
GO

-- ==========================================
-- 6. THEM DU LIEU BANG VIOLATION_EVENT
-- ==========================================
INSERT INTO Violation_Event (vehicle_id, guest_license_plate, recorded_speed, speed_limit, image_url, timestamp, admin_status, ticket_id) VALUES 
-- Loi cu cua student01 da bi gom vao ticket ID 1 va da giai quyet
(1, NULL, 25.5, 15.0, 'http://cloud.com/img/v1.jpg', DATEADD(DAY, -10, GETDATE()), 'Notified', 1),
(1, NULL, 22.0, 15.0, 'http://cloud.com/img/v2.jpg', DATEADD(DAY, -8, GETDATE()), 'Notified', 1),

-- Loi cua o to student02, da gom vao ticket ID 2 (dang no)
(3, NULL, 35.0, 20.0, 'http://cloud.com/img/v3.jpg', DATEADD(DAY, -3, GETDATE()), 'Notified', 2),

-- Loi moi cua student01, da gui email canh bao nhung chua tao bien ban phat
(1, NULL, 18.5, 15.0, 'http://cloud.com/img/v4.jpg', DATEADD(HOUR, -5, GETDATE()), 'Notified', NULL),

-- Camera chup nham con cho/xe cuu thuong chay ngang (Admin duyet va cho vao Ignored)
(NULL, NULL, 40.0, 15.0, 'http://cloud.com/img/v5_error.jpg', DATEADD(HOUR, -2, GETDATE()), 'Ignored', NULL),

-- Xe shipper/Grab chay qua toc do (Admin phat hien xe la nen luu bien so vao cot guest)
(NULL, '63G1-88888', 29.0, 15.0, 'http://cloud.com/img/v6_guest.jpg', DATEADD(HOUR, -1, GETDATE()), 'Guest_Vehicle', NULL),

-- 2 su kien vua chup tuc thi tu phan cung, dang cho Admin duyet
(NULL, NULL, 26.2, 15.0, 'http://cloud.com/img/v7_new.jpg', GETDATE(), 'Pending', NULL),
(NULL, NULL, 30.1, 15.0, 'http://cloud.com/img/v8_new.jpg', GETDATE(), 'Pending', NULL);
GO