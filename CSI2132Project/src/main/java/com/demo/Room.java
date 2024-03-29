package com.demo;
public class Room {
    private int roomID;
    private int hotelID;
    private String roomNumber;
    private double price;
    private int capacity;
    private String views;
    private boolean problems;
    private boolean petFriendly;

    public Room() {
    }

    public Room( int hotelID, String roomNumber, double price, int capacity, String views, boolean problems, boolean petFriendly) {
       // this.roomID = roomID;
        this.hotelID = hotelID;
        this.roomNumber = roomNumber;
        this.price = price;
        this.capacity = capacity;
        this.views = views;
        this.problems = problems;
        this.petFriendly = petFriendly;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public int getHotelID() {
        return hotelID;
    }

    public void setHotelID(int hotelID) {
        this.hotelID = hotelID;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getViews() {
        return views;
    }

    public void setViews(String views) {
        this.views = views;
    }

    public boolean isProblems() {
        return problems;
    }

    public void setProblems(boolean problems) {
        this.problems = problems;
    }

    public boolean isPetFriendly() {
        return petFriendly;
    }

    public void setPetFriendly(boolean petFriendly) {
        this.petFriendly = petFriendly;
    }
}
