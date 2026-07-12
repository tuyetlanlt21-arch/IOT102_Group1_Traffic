package dto;

import java.sql.Date;

public class ViolationEvent {

    private int eventId;
    private int vehicleId;
    private double recordedSpeed;
    private double speedLimit;
    private String imageUrl;
    private Date timestamp;
    private String adminStatus;
    private int ticketId;

    // Các trường phụ lấy từ bảng Vehicle để hiển thị cho tiện
    private String licensePlate;
    private String brand;

    //Lấy từ bảng account
    private String ownerName;
    private String ownerEmail;

    public ViolationEvent() {
    }

    public ViolationEvent(int eventId, int vehicleId, double recordedSpeed, double speedLimit, String imageUrl, Date timestamp, String adminStatus, int ticketId) {
        this.eventId = eventId;
        this.vehicleId = vehicleId;
        this.recordedSpeed = recordedSpeed;
        this.speedLimit = speedLimit;
        this.imageUrl = imageUrl;
        this.timestamp = timestamp;
        this.adminStatus = adminStatus;
        this.ticketId = ticketId;
    }

    // --- GETTERS AND SETTERS ---
    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public double getRecordedSpeed() {
        return recordedSpeed;
    }

    public void setRecordedSpeed(double recordedSpeed) {
        this.recordedSpeed = recordedSpeed;
    }

    public double getSpeedLimit() {
        return speedLimit;
    }

    public void setSpeedLimit(double speedLimit) {
        this.speedLimit = speedLimit;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public String getAdminStatus() {
        return adminStatus;
    }

    public void setAdminStatus(String adminStatus) {
        this.adminStatus = adminStatus;
    }

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }

    public String getOwnerEmail() {
        return ownerEmail;
    }

    public void setOwnerEmail(String ownerEmail) {
        this.ownerEmail = ownerEmail;
    }
}
