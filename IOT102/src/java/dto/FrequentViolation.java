package dto;

public class FrequentViolation {

    private Account account;
    private Vehicle vehicle;

    private int violationCount;

    private boolean hasUnpaidTicket;

    public FrequentViolation() {
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public Vehicle getVehicle() {
        return vehicle;
    }

    public void setVehicle(Vehicle vehicle) {
        this.vehicle = vehicle;
    }

    public int getViolationCount() {
        return violationCount;
    }

    public void setViolationCount(int violationCount) {
        this.violationCount = violationCount;
    }

    public boolean isHasUnpaidTicket() {
        return hasUnpaidTicket;
    }

    public void setHasUnpaidTicket(boolean hasUnpaidTicket) {
        this.hasUnpaidTicket = hasUnpaidTicket;
    }

}