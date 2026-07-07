# 🚦 Smart Speed Monitoring and License Plate Recognition System

## 📌 Overview

The **Smart Speed Monitoring and License Plate Recognition System** is an Internet of Things (IoT) application developed to automatically detect speeding vehicles, capture images, recognize license plates, and notify vehicle owners through a web application and email.

This project integrates embedded systems, image processing, database management, and web technologies into a complete traffic monitoring solution. It is designed for residential areas, campuses, parking lots, or any location requiring speed control.

---

## 🎯 Objectives

- Detect vehicles passing through the monitored area.
- Calculate vehicle speed automatically.
- Identify speeding violations.
- Capture images of violating vehicles.
- Recognize license plates using Optical Character Recognition (OCR).
- Store violation records in a database.
- Notify vehicle owners via email.
- Provide a web application for residents and administrators to manage information.

---

# ✨ Features

## Resident

- Register a new account.
- Verify email using OTP.
- Login securely.
- Register one or multiple vehicles.
- View registered vehicles.
- Receive speeding violation notifications.
- View violation history.
- View captured vehicle images.
- View detected speed and violation details.

---

## Administrator

- Manage user accounts.
- Manage registered vehicles.
- Monitor speeding violations.
- View all captured records.
- Search violations by license plate.
- Manage system information.

---

# 🏗️ System Architecture

```
                   Vehicle
                      │
                      ▼
           Ultrasonic Sensors (HC-SR04)
                      │
                      ▼
                 Arduino UNO
            Speed Calculation Module
                      │
          ┌───────────┴────────────┐
          │                        │
          ▼                        ▼
     Normal Speed            Overspeed Detected
          │                        │
          │                 Trigger ESP32-CAM
          │                        │
          │                        ▼
          │               Capture Vehicle Image
          │                        │
          │                        ▼
          │                Python OCR Server
          │                        │
          │                        ▼
          └────────────► SQL Server Database ◄─────────────┐
                                                           │
                                                           ▼
                                                Java Web Application
                                                           │
                                                           ▼
                                                Email Notification
```

---

# 🔄 System Workflow

1. A vehicle enters the monitoring area.
2. Two ultrasonic sensors detect the vehicle.
3. Arduino UNO records the timestamps.
4. Vehicle speed is calculated.
5. If the speed exceeds the configured limit:
   - Arduino sends a trigger signal.
   - ESP32-CAM captures the vehicle image.
6. Python receives the image.
7. OpenCV preprocesses the image.
8. OCR recognizes the license plate.
9. Vehicle information is matched with the database.
10. Violation data is stored.
11. The system sends an email notification.
12. Residents can log in to the website to review violation details.

---

# 🛠️ Technologies Used

## Hardware

- Arduino UNO
- ESP32-CAM
- HC-SR04 Ultrasonic Sensors
- LCD 16x2 with I2C Module
- Buzzer
- LEDs

---

## Software

### Backend

- Java Servlet
- JSP
- JDBC

### Frontend

- HTML5
- CSS3
- Bootstrap 5
- JavaScript

### Image Processing

- Python
- OpenCV
- EasyOCR

### Database

- Microsoft SQL Server

### Development Tools

- NetBeans IDE
- Arduino IDE
- Visual Studio Code
- SQL Server Management Studio
- Git
- GitHub

---

# 📁 Project Structure

```
Smart-Speed-Monitoring-System
│
├── Arduino/
│   ├── SpeedDetection.ino
│
├── ESP32-CAM/
│   ├── CameraCapture.ino
│
├── Python/
│   ├── OCR.py
│   ├── ImageProcessing.py
│   ├── Database.py
│
├── JavaWeb/
│   ├── src/
│   ├── web/
│   ├── WEB-INF/
│
├── Database/
│   ├── database.sql
│
├── Images/
│
└── README.md
```

---

# 💾 Database

The database stores the following information:

### Users

- Full Name
- Email
- Phone Number
- Password
- Role

### Vehicles

- License Plate
- Vehicle Type
- Owner

### Violations

- License Plate
- Vehicle Speed
- Speed Limit
- Violation Time
- Captured Image
- OCR Result
- Violation Status

---

# 📧 Email Notification

Whenever a speeding violation is detected, the system automatically sends an email containing:

- Vehicle license plate
- Detected speed
- Speed limit
- Violation time
- Notification message
- Link to the web application

---

# 🔐 Security

The web application includes several security mechanisms:

- User authentication
- Email OTP verification
- Password encryption
- Session management
- Role-based authorization
- SQL Injection prevention using PreparedStatement

---

# 🚀 Installation

## 1. Clone the repository

```bash
git clone https://github.com/your-username/Smart-Speed-Monitoring-System.git
```

---

## 2. Configure Database

- Install Microsoft SQL Server.
- Execute the `database.sql` script.
- Update database connection information in both Java and Python projects.

---

## 3. Run Java Web Application

- Open the project in NetBeans.
- Configure Apache Tomcat.
- Build and Run the project.

---

## 4. Install Python Libraries

```bash
pip install opencv-python
pip install easyocr
pip install pyodbc
pip install numpy
```

Run:

```bash
python OCR.py
```

---

## 5. Upload Arduino Program

Open Arduino IDE and upload:

```
Arduino/SpeedDetection.ino
```

---

## 6. Upload ESP32-CAM Program

- Configure WiFi credentials.
- Upload the firmware.
- Verify communication with the server.

---

# 📊 Future Improvements

- YOLO-based vehicle detection.
- Support multiple vehicles simultaneously.
- MQTT communication.
- Real-time dashboard.
- Mobile application.
- Online fine payment.
- AI-powered traffic analytics.

---

# 📷 Demo

The complete system demonstrates the following workflow:

```
Vehicle
   │
   ▼
Ultrasonic Sensors
   │
   ▼
Arduino UNO
   │
   ▼
Speed Calculation
   │
   ▼
Overspeed?
   │
  Yes
   │
   ▼
ESP32-CAM
   │
   ▼
Python OCR
   │
   ▼
SQL Server
   │
   ▼
Java Web Dashboard
   │
   ▼
Email Notification
```

---

# 👨‍💻 Team Members

| Name | Role |
|------|------|
| ... | Hardware Development |
| ... | Backend Development |
| ... | AI & OCR |
| ... | Web Development |

---

# 📜 License

This project is developed for educational and research purposes only.

---

## ⭐ Acknowledgements

This project was developed as part of an Internet of Things (IoT) course to demonstrate the integration of embedded systems, computer vision, web technologies, and database management into a complete smart traffic monitoring solution.
