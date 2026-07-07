-- Khởi tạo Database (Cú pháp chuẩn của SQL Server)
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'TrafficMonitoringDB')
BEGIN
    CREATE DATABASE TrafficMonitoringDB;
END
GO

USE TrafficMonitoringDB;
GO

-- 1. Bảng Role (Phân quyền)
CREATE TABLE Role (
    role_id INT IDENTITY(1,1) PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL,
    description VARCHAR(255)
);
GO

-- 2. Bảng Account (Tài khoản)
CREATE TABLE Account (
    account_id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    role_id INT,
    is_verified BIT DEFAULT 0, 
    created_at DATETIME DEFAULT GETDATE(), 
    FOREIGN KEY (role_id) REFERENCES Role(role_id) ON DELETE SET NULL
);
GO

-- 3. Bảng OTP_Verification (Xác thực Email)
CREATE TABLE OTP_Verification (
    otp_id INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(100) NOT NULL,
    otp_code VARCHAR(6) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    expires_at DATETIME NOT NULL,
    is_used BIT DEFAULT 0,
    type VARCHAR(20) DEFAULT 'REGISTER'
);
GO

-- 4. Bảng Vehicle (Phương tiện đã đăng ký)
CREATE TABLE Vehicle (
    vehicle_id INT IDENTITY(1,1) PRIMARY KEY,
    license_plate VARCHAR(20) UNIQUE NOT NULL,
    account_id INT,
    vehicle_type VARCHAR(50) DEFAULT 'Motorbike',
    FOREIGN KEY (account_id) REFERENCES Account(account_id) ON DELETE CASCADE
);
GO

-- 5. Bảng Penalty_Ticket (Biên bản phạt gộp nhiều lỗi)
CREATE TABLE Penalty_Ticket (
    ticket_id INT IDENTITY(1,1) PRIMARY KEY,
    account_id INT NOT NULL,
    fine_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Unpaid',
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (account_id) REFERENCES Account(account_id) ON DELETE CASCADE
);
GO

-- 6. Bảng Violation_Event (Lịch sử vi phạm cốt lõi)
CREATE TABLE Violation_Event (
    event_id INT IDENTITY(1,1) PRIMARY KEY,
    vehicle_id INT NULL, 
    guest_license_plate VARCHAR(20) NULL, 
    recorded_speed FLOAT NOT NULL,
    speed_limit FLOAT NOT NULL,
    image_url VARCHAR(255),
    timestamp DATETIME DEFAULT GETDATE(),
    admin_status VARCHAR(50) DEFAULT 'Pending', 
    ticket_id INT NULL, 
    
    -- Đã sửa thành ON DELETE NO ACTION để xử lý lỗi Multiple Cascade Paths
    FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id) ON DELETE NO ACTION,
    FOREIGN KEY (ticket_id) REFERENCES Penalty_Ticket(ticket_id) ON DELETE NO ACTION
);
GO