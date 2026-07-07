-- 1. Thêm dữ liệu Phân quyền
INSERT INTO Role (role_name, description) VALUES 
('Admin', 'Ban quản lý hệ thống, có quyền duyệt lỗi và phạt'),
('Customer', 'Cư dân hoặc sinh viên sử dụng hệ thống');

-- 2. Thêm dữ liệu Tài khoản (Account)
-- Thêm một Admin/Bảo vệ ca đêm và 3 sinh viên mới
INSERT INTO Account (username, password_hash, full_name, email, role_id, is_verified) VALUES 
('guard_night', 'hashed_pw_111', 'Lê Bảo Vệ', 'baove_dem@campus.edu.vn', 1, TRUE),
('student03', 'hashed_pw_222', 'Phạm Thị C', 'phamthic@gmail.com', 2, TRUE),
('student04', 'hashed_pw_333', 'Hoàng Văn D', 'hoangvand@gmail.com', 2, TRUE),
('student05', 'hashed_pw_444', 'Vũ E', 'vue2005@gmail.com', 2, FALSE);

-- 3. Thêm dữ liệu OTP (OTP_Verification)
-- Kịch bản: Mã OTP đã dùng thành công, mã dùng để cấp lại mật khẩu, và mã vừa gửi chưa dùng
INSERT INTO OTP_Verification (email, otp_code, created_at, expires_at, is_used, type) VALUES 
('phamthic@gmail.com', '112233', '2026-07-06 10:00:00', '2026-07-06 10:05:00', TRUE, 'REGISTER'),
('hoangvand@gmail.com', '998877', '2026-07-07 08:00:00', '2026-07-07 08:05:00', TRUE, 'FORGOT_PASS'),
('vue2005@gmail.com', '445566', NOW(), DATE_ADD(NOW(), INTERVAL 5 MINUTE), FALSE, 'REGISTER');

-- 4. Thêm dữ liệu Phương tiện (Vehicle)
-- Kịch bản: Sinh viên đi ô tô, và có sinh viên sở hữu 2 chiếc xe máy
INSERT INTO Vehicle (license_plate, account_id, vehicle_type) VALUES 
('61C3-111.22', 5, 'Motorbike'), -- Xe của student03 (ID xe: 3)
('51F-888.99', 6, 'Car'),        -- Xe ô tô của student04 (ID xe: 4)
('62D4-333.44', 7, 'Motorbike'), -- Xe của student05 (ID xe: 5)
('59Z1-999.00', 5, 'Motorbike'); -- Xe thứ 2 của student03 (ID xe: 6)

-- 5. Thêm dữ liệu Biên bản phạt (Penalty_Ticket)
-- Kịch bản: Một vé phạt tháng trước đã nộp, một vé phạt ô tô mắc tiền hơn đang nợ
INSERT INTO Penalty_Ticket (account_id, fine_amount, status, created_at) VALUES 
(5, 50000.00, 'Paid', '2026-06-15 10:00:00'),   -- student03 đã nộp phạt (ID ticket: 2)
(6, 150000.00, 'Unpaid', '2026-07-06 14:30:00'); -- student04 bị phạt ô tô (ID ticket: 3)

-- 6. Thêm dữ liệu Lịch sử vi phạm (Violation_Event)
INSERT INTO Violation_Event (vehicle_id, recorded_speed, speed_limit, image_url, timestamp, admin_status, ticket_id) VALUES 
-- Các lỗi của student03 hồi tháng 6, đã bị gom vào biên bản và đã nộp phạt (ticket_id = 2)
(3, 22.0, 15.0, 'http://cloud.com/img/v_6.jpg', '2026-06-10 07:45:00', 'Notified', 2),
(3, 24.5, 15.0, 'http://cloud.com/img/v_7.jpg', '2026-06-12 11:20:00', 'Notified', 2),

-- Các lỗi của ô tô student04, chạy quá tốc độ nhiều, bị lập biên bản nợ phạt (ticket_id = 3)
(4, 35.0, 20.0, 'http://cloud.com/img/v_8.jpg', '2026-07-05 13:00:00', 'Notified', 3),
(4, 40.0, 20.0, 'http://cloud.com/img/v_9.jpg', '2026-07-06 09:15:00', 'Notified', 3),

-- Lỗi mới của xe thứ 2 của student03, đã gửi mail nhắc nhở nhưng chưa tới mức tạo vé phạt (ticket_id = NULL)
(6, 20.5, 15.0, 'http://cloud.com/img/v_10.jpg', '2026-07-07 07:30:00', 'Notified', NULL),

-- 2 Lỗi vừa chụp được tức thì từ ESP32-CAM (vehicle_id = NULL, admin đang chờ duyệt để điền biển số)
(NULL, 29.0, 15.0, 'http://cloud.com/img/v_11.jpg', '2026-07-07 18:10:00', 'Pending', NULL),
(NULL, 31.2, 15.0, 'http://cloud.com/img/v_12.jpg', '2026-07-07 18:12:00', 'Pending', NULL);