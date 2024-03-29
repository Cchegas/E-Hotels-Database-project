package com.demo;

import java.sql.Date;

public class Booking {
    private int bookingID;
    private int roomID;
    private int customerID;
    private Date startDate;
    private Date endDate;
    private double depositAmount;

    public Booking(){};
    public Booking(int roomID, int customerID, Date startDate, Date endDate, double depositAmount) {
        this.roomID = roomID;
        this.customerID = customerID;
        this.startDate = startDate;
        this.endDate = endDate;
        this.depositAmount = depositAmount;
    }

    // Getters and setters
    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
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

    public double getDepositAmount() {
        return depositAmount;
    }

    public void setDepositAmount(double depositAmount) {
        this.depositAmount = depositAmount;
    }
}
