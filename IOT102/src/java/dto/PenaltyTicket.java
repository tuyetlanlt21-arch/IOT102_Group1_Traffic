package dto;

import java.sql.Date;

public class PenaltyTicket {

    private int ticketId;
    private int accountId;
    private double fineAmount;
    private String status;
    private Date createdAt;    // Đã chuyển sang java.sql.Date
    private Date paymentDate;  // Đã chuyển sang java.sql.Date
    private int resolvedBy;

    public PenaltyTicket() {
    }

    public PenaltyTicket(int ticketId, int accountId, double fineAmount, String status, Date createdAt, Date paymentDate, int resolvedBy) {
        this.ticketId = ticketId;
        this.accountId = accountId;
        this.fineAmount = fineAmount;
        this.status = status;
        this.createdAt = createdAt;
        this.paymentDate = paymentDate;
        this.resolvedBy = resolvedBy;
    }

    // --- GETTERS AND SETTERS ---
    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public double getFineAmount() {
        return fineAmount;
    }

    public void setFineAmount(double fineAmount) {
        this.fineAmount = fineAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public int getResolvedBy() {
        return resolvedBy;
    }

    public void setResolvedBy(int resolvedBy) {
        this.resolvedBy = resolvedBy;
    }
}
