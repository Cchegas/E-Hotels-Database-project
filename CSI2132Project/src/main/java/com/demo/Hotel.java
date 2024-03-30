package com.demo;


public class Hotel {
    private int hotelID;
    private int chainID;
    private String name;
    private int category;
    private int numberOfRooms;
    private String address;
    private String area;
    private String contactEmail;
    private String phoneNumber;

    // Constructors
    public Hotel() {
    }

    public Hotel(int chainID, String name, int category, int numberOfRooms, String address, String area,String contactEmail, String phoneNumber) {
        this.chainID = chainID;
        this.name = name;
        this.category = category;
        this.numberOfRooms = numberOfRooms;
        this.address = address;
        this.area=area;
        this.contactEmail = contactEmail;
        this.phoneNumber = phoneNumber;
    }

    // Getters and setters
    public int getHotelID() {
        return hotelID;
    }

    public void setHotelID(int hotelID) {
        this.hotelID = hotelID;
    }

    public int getChainID() {
        return chainID;
    }

    public void setChainID(int chainID) {
        this.chainID = chainID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCategory() {
        return category;
    }

    public void setCategory(int category) {
        this.category = category;
    }

    public int getNumberOfRooms() {
        return numberOfRooms;
    }

    public void setNumberOfRooms(int numberOfRooms) {
        this.numberOfRooms = numberOfRooms;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getContactEmail() {
        return contactEmail;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    // toString method
    @Override
    public String toString() {
        return "Hotel{" +
                "hotelID=" + hotelID +
                ", chainID=" + chainID +
                ", name='" + name + '\'' +
                ", category=" + category +
                ", numberOfRooms=" + numberOfRooms +
                ", address='" + address + '\'' +
                ", contactEmail='" + contactEmail + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                '}';
    }
}
