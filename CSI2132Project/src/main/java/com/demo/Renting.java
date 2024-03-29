package com.demo;


import java.sql.Date;

public class Renting {
    private int rentingID;
    private int roomID;
    private int customerID;
    private Date startDate;
    private Date endDate;
    private String paymentMethod;
    private double paymentAmount;

    public Renting() {}

    public Renting(int roomID, int customerID, Date startDate, Date endDate, String paymentMethod, double paymentAmount) {
        this.roomID = roomID;
        this.customerID = customerID;
        this.startDate = startDate;
        this.endDate = endDate;
        this.paymentMethod = paymentMethod;
        this.paymentAmount = paymentAmount;
    }

    // Getters and setters
    public int getRentingID() {
        return rentingID;
    }

    public void setRentingID(int rentingID) {
        this.rentingID = rentingID;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getPaymentAmount() {
        return paymentAmount;
    }

    public void setPaymentAmount(double paymentAmount) {
        this.paymentAmount = paymentAmount;
    }
}
