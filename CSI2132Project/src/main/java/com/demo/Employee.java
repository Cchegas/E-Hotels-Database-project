package com.demo;

public class Employee {
    private int employeeID;
    private String firstName;
    private String lastName;
    private String address;
    private String sinNumber;
    private String role;

    public Employee() {
    }

    public Employee(String firstName, String lastName, String address, String sinNumber, String role) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.sinNumber = sinNumber;
        this.role = role;
    }

    // Getters and Setters
    public int getEmployeeID() {
        return employeeID;
    }

    public void setEmployeeID(int employeeID) {
        this.employeeID = employeeID;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getSinNumber() {
        return sinNumber;
    }

    public void setSinNumber(String sinNumber) {
        this.sinNumber = sinNumber;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
