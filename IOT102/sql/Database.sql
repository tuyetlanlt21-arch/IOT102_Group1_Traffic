-- ==========================================
-- KHỞI TẠO DATABASE
-- ==========================================
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'TrafficMonitoringDB')
BEGIN
    CREATE DATABASE TrafficMonitoringDB;
END
GO

USE TrafficMonitoringDB;
GO

-- ==========================================
-- DỌN DẸP BẢNG CŨ (XÓA THEO THỨ TỰ TỪ CON LÊN CHA)
-- ==========================================
IF OBJECT_ID('Violation_Event', 'U') IS NOT NULL DROP TABLE Violation_Event;
IF OBJECT_ID('Penalty_Ticket', 'U') IS NOT NULL DROP TABLE Penalty_Ticket;
IF OBJECT_ID('Vehicle', 'U') IS NOT NULL DROP TABLE Vehicle;
IF OBJECT_ID('OTP_Verification', 'U') IS NOT NULL DROP TABLE OTP_Verification;
IF OBJECT_ID('Account', 'U') IS NOT NULL DROP TABLE Account;
IF OBJECT_ID('Role', 'U') IS NOT NULL DROP TABLE Role;
GO

-- ==========================================
-- 1. BẢNG ROLE (Phân quyền)
-- ==========================================
CREATE TABLE Role (
    role_id INT IDENTITY(1,1) PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL,
    description VARCHAR(255)
);
GO

-- ==========================================
-- 2. BẢNG ACCOUNT (Tài khoản)
-- ==========================================
CREATE TABLE Account (
    account_id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    role_id INT,
    is_verified BIT DEFAULT 0, -- 0: Chưa xác thực, 1: Đã xác thực
    created_at DATETIME DEFAULT GETDATE(), 
    FOREIGN KEY (role_id) REFERENCES Role(role_id) ON DELETE SET NULL
);
GO

-- ==========================================
-- 3. BẢNG OTP_VERIFICATION (Xác thực Email)
-- ==========================================
CREATE TABLE OTP_Verification (
    otp_id INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(100) NOT NULL,
    otp_code VARCHAR(6) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    expires_at DATETIME NOT NULL,
    is_used BIT DEFAULT 0, -- 0: Chưa sử dụng, 1: Đã sử dụng
    type VARCHAR(20) DEFAULT 'REGISTER',
    
    -- Ràng buộc: Chỉ cho phép loại OTP hợp lệ
    CONSTRAINT CHK_OTP_Type CHECK (type IN ('REGISTER', 'FORGOT_PASS'))
);
GO

-- ==========================================
-- 4. BẢNG VEHICLE (Phương tiện đăng ký)
-- ==========================================
CREATE TABLE Vehicle (
    vehicle_id INT IDENTITY(1,1) PRIMARY KEY,
    license_plate VARCHAR(20) UNIQUE NOT NULL,
    account_id INT,
    brand VARCHAR(50), -- Hãng xe (Honda, Yamaha, Toyota...)
    vehicle_type VARCHAR(50) DEFAULT 'Motorbike',
    status VARCHAR(20) DEFAULT 'Active',
    
    -- Ràng buộc: Giới hạn trạng thái xe
    CONSTRAINT CHK_Vehicle_Status CHECK (status IN (
        'Active',   -- Đang sử dụng
        'Inactive', -- Đã bán/Không còn dùng
        'Banned'    -- Bị cấm ra vào
    )),
    
    FOREIGN KEY (account_id) REFERENCES Account(account_id) ON DELETE CASCADE
);
GO

-- ==========================================
-- 5. BẢNG PENALTY_TICKET (Biên bản phạt)
-- ==========================================
CREATE TABLE Penalty_Ticket (
    ticket_id INT IDENTITY(1,1) PRIMARY KEY,
    account_id INT NOT NULL,
    fine_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Unpaid',
    created_at DATETIME DEFAULT GETDATE(),
    
    -- Các cột phục vụ luồng nộp phạt Offline tại văn phòng
    payment_date DATETIME NULL,
    resolved_by INT NULL, 
    
    -- Ràng buộc: Giới hạn trạng thái vé phạt
    CONSTRAINT CHK_Ticket_Status CHECK (status IN (
        'Unpaid',    -- Chưa nộp phạt
        'Paid',      -- Đã nộp phạt
        'Cancelled'  -- Đã hủy
    )),
    
    FOREIGN KEY (account_id) REFERENCES Account(account_id) ON DELETE CASCADE,
    FOREIGN KEY (resolved_by) REFERENCES Account(account_id) ON DELETE NO ACTION
);
GO

-- ==========================================
-- 6. BẢNG VIOLATION_EVENT (Lịch sử vi phạm)
-- ==========================================
CREATE TABLE Violation_Event (
    event_id INT IDENTITY(1,1) PRIMARY KEY,
    vehicle_id INT NULL, 
    guest_license_plate VARCHAR(20) NULL, -- Dành cho xe khách, vãng lai
    recorded_speed FLOAT NOT NULL,
    speed_limit FLOAT NOT NULL,
    image_url VARCHAR(255),
    timestamp DATETIME DEFAULT GETDATE(),
    admin_status VARCHAR(50) DEFAULT 'Pending', 
    ticket_id INT NULL, 
    
    -- Ràng buộc: Giới hạn trạng thái duyệt lỗi
    CONSTRAINT CHK_Event_Status CHECK (admin_status IN (
        'Pending',       -- Chờ Admin duyệt
        'Notified',      -- Đã duyệt và gửi email
        'Guest_Vehicle', -- Đã duyệt, là xe vãng lai
        'Ignored'        -- Bỏ qua (ảnh lỗi, xe ưu tiên...)
    )),
    
    -- Dùng ON DELETE NO ACTION để tránh lỗi Multiple Cascade Paths
    FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id) ON DELETE NO ACTION,
    FOREIGN KEY (ticket_id) REFERENCES Penalty_Ticket(ticket_id) ON DELETE NO ACTION
);
GO