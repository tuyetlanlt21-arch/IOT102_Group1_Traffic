USE TrafficMonitoringDB;
GO

-- ==========================================
-- 1. THÊM DỮ LIỆU BẢNG ROLE
-- ==========================================
INSERT INTO Role (role_name, description) VALUES 
('Admin', 'Ban quản lý, bảo vệ có quyền duyệt ảnh và thu phạt'),
('Customer', 'Sinh viên, giảng viên hoặc cư dân trong khu vực');
GO

-- ==========================================
-- 2. THÊM DỮ LIỆU BẢNG ACCOUNT
-- ==========================================
INSERT INTO Account (username, password_hash, full_name, email, role_id, is_verified) VALUES 
('admin_main', 'hash_123', 'Nguyễn Quản Lý', 'admin@campus.edu.vn', 1, 1),
('guard_night', 'hash_456', 'Lê Trực Đêm', 'baove@campus.edu.vn', 1, 1),
('student01', 'hash_789', 'Trần Văn A', 'tranvana@gmail.com', 2, 1),
('student02', 'hash_abc', 'Phạm Thị B', 'phamb@gmail.com', 2, 1),
('student03', 'hash_xyz', 'Hoàng Văn C', 'hoangc2005@gmail.com', 2, 0); -- Chưa xác thực email
GO

-- ==========================================
-- 3. THÊM DỮ LIỆU BẢNG OTP_VERIFICATION
-- ==========================================
INSERT INTO OTP_Verification (email, otp_code, expires_at, is_used, type) VALUES 
('hoangc2005@gmail.com', '123456', DATEADD(MINUTE, 5, GETDATE()), 0, 'REGISTER'),
('tranvana@gmail.com', '654321', DATEADD(MINUTE, -10, GETDATE()), 1, 'FORGOT_PASS');
GO

-- ==========================================
-- 4. THÊM DỮ LIỆU BẢNG VEHICLE
-- ==========================================
INSERT INTO Vehicle (license_plate, account_id, brand, vehicle_type, status) VALUES 
('59A1-111.11', 3, 'Honda', 'Motorbike', 'Active'),    -- Xe của student01
('60B2-222.22', 4, 'Yamaha', 'Motorbike', 'Active'),   -- Xe của student02
('51F-333.33', 4, 'Toyota', 'Car', 'Active'),          -- Ô tô của student02
('61C3-444.44', 3, 'Suzuki', 'Motorbike', 'Inactive'), -- Xe cũ của student01 đã bán
('62D4-555.55', 5, 'Honda', 'Motorbike', 'Banned');    -- Xe của student03 bị cấm
GO

-- ==========================================
-- 5. THÊM DỮ LIỆU BẢNG PENALTY_TICKET
-- ==========================================
-- Lưu ý: Identity tự động tăng bắt đầu từ 1
INSERT INTO Penalty_Ticket (account_id, fine_amount, status, payment_date, resolved_by) VALUES 
(3, 100000.00, 'Paid', DATEADD(DAY, -2, GETDATE()), 1),  -- student01 đã nộp phạt, người thu là admin_main (ID 1)
(4, 250000.00, 'Unpaid', NULL, NULL),                    -- student02 bị phạt nặng do đi ô tô, chưa nộp
(5, 50000.00, 'Cancelled', NULL, 2);                     -- Vé phạt bị hủy do nhầm lẫn, người xử lý hủy là guard_night (ID 2)
GO

-- ==========================================
-- 6. THÊM DỮ LIỆU BẢNG VIOLATION_EVENT
-- ==========================================
INSERT INTO Violation_Event (vehicle_id, guest_license_plate, recorded_speed, speed_limit, image_url, timestamp, admin_status, ticket_id) VALUES 
-- Lỗi cũ của student01 đã bị gom vào ticket ID 1 và đã giải quyết
(1, NULL, 25.5, 15.0, 'http://cloud.com/img/v1.jpg', DATEADD(DAY, -10, GETDATE()), 'Notified', 1),
(1, NULL, 22.0, 15.0, 'http://cloud.com/img/v2.jpg', DATEADD(DAY, -8, GETDATE()), 'Notified', 1),

-- Lỗi của ô tô student02, đã gom vào ticket ID 2 (đang nợ)
(3, NULL, 35.0, 20.0, 'http://cloud.com/img/v3.jpg', DATEADD(DAY, -3, GETDATE()), 'Notified', 2),

-- Lỗi mới của student01, đã gửi email cảnh báo nhưng chưa tạo biên bản phạt
(1, NULL, 18.5, 15.0, 'http://cloud.com/img/v4.jpg', DATEADD(HOUR, -5, GETDATE()), 'Notified', NULL),

-- Camera chụp nhầm con chó/xe cứu thương chạy ngang (Admin duyệt và cho vào Ignored)
(NULL, NULL, 40.0, 15.0, 'http://cloud.com/img/v5_error.jpg', DATEADD(HOUR, -2, GETDATE()), 'Ignored', NULL),

-- Xe shipper/Grab chạy quá tốc độ (Admin phát hiện xe lạ nên lưu biển số vào cột guest)
(NULL, '59-Grab.888', 29.0, 15.0, 'http://cloud.com/img/v6_guest.jpg', DATEADD(HOUR, -1, GETDATE()), 'Guest_Vehicle', NULL),

-- 2 sự kiện vừa chụp tức thì từ phần cứng, đang chờ Admin duyệt
(NULL, NULL, 26.2, 15.0, 'http://cloud.com/img/v7_new.jpg', GETDATE(), 'Pending', NULL),
(NULL, NULL, 30.1, 15.0, 'http://cloud.com/img/v8_new.jpg', GETDATE(), 'Pending', NULL);
GO