package com.demo;

import java.sql.Date;

public class Customer {
    private int customerID;
    private String firstName;
    private String lastName;
    private Date dateOfRegistration;
    private String idType;
    private String idNumber;

    public Customer(int customerID, String firstName, String lastName, Date dateOfRegistration, String idType, String idNumber) {
        this.customerID = customerID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.dateOfRegistration = dateOfRegistration;
        this.idType = idType;
        this.idNumber = idNumber;
    }

    public Customer(String firstName, String lastName, Date dateOfRegistration, String idType, String idNumber) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.dateOfRegistration = dateOfRegistration;
        this.idType = idType;
        this.idNumber = idNumber;
    }


    // Getters and Setters
    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Date getdateOfRegistration() {
        return dateOfRegistration;
    }

    public void setdateOfRegistration(Date dateOfRegistration) {
        this.dateOfRegistration = dateOfRegistration;
    }

    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) {
        this.idType = idType;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }
}
