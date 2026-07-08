package dto;

public class Statistics {

    private int todayViolations;
    private int monthViolations;
    private int unpaidTickets;

    private double totalRevenue;

    private int minorCount;
    private int majorCount;
    private int severeCount;

    public Statistics() {
    }

    public int getTodayViolations() {
        return todayViolations;
    }

    public void setTodayViolations(int todayViolations) {
        this.todayViolations = todayViolations;
    }

    public int getMonthViolations() {
        return monthViolations;
    }

    public void setMonthViolations(int monthViolations) {
        this.monthViolations = monthViolations;
    }

    public int getUnpaidTickets() {
        return unpaidTickets;
    }

    public void setUnpaidTickets(int unpaidTickets) {
        this.unpaidTickets = unpaidTickets;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public int getMinorCount() {
        return minorCount;
    }

    public void setMinorCount(int minorCount) {
        this.minorCount = minorCount;
    }

    public int getMajorCount() {
        return majorCount;
    }

    public void setMajorCount(int majorCount) {
        this.majorCount = majorCount;
    }

    public int getSevereCount() {
        return severeCount;
    }

    public void setSevereCount(int severeCount) {
        this.severeCount = severeCount;
    }

}