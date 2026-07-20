package dto;

public class Vehicle {

    private int vehicleId;
    private String licensePlate;
    private int accountId;
    private String brand;
    private String vehicleType;
    private String status;

    public Vehicle() {
    }


    public Vehicle(String licensePlate, int accountId, String brand, String vehicleType, String status) {
        this.licensePlate = licensePlate;
        this.accountId = accountId;
        this.brand = brand;
        this.vehicleType = vehicleType;
        this.status = status;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
