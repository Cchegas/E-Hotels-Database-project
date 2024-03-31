package com.demo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class BookingService {

    // Method to insert a new booking
    public void insertBooking(Booking booking) throws Exception {
        String sql = "INSERT INTO booking (roomID, customerID, startDate, endDate, depositAmount)  " +
                "VALUES (?, ?, ?, ?, ?)";
        ConnectionDB db = new ConnectionDB();
        try (Connection con = db.getConnection()) {
            PreparedStatement statement = con.prepareStatement(sql);

            statement.setInt(1, booking.getRoomID());
            statement.setInt(2, booking.getCustomerID());
            statement.setDate(3, booking.getStartDate());
            statement.setDate(4, booking.getEndDate());
            statement.setDouble(5, booking.getDepositAmount());

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to update an existing booking
    public void updateBooking(int bookingID, Booking booking) throws Exception {
        String sql = "UPDATE booking SET roomID=?, customerID=?, startDate=?, endDate=?, depositAmount=? " +
                "WHERE bookingID=?";
        ConnectionDB db = new ConnectionDB();
        try (Connection con = db.getConnection()) {
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, booking.getRoomID());
            statement.setInt(2, booking.getCustomerID());
            statement.setDate(3, booking.getStartDate());
            statement.setDate(4, booking.getEndDate());
            statement.setDouble(5, booking.getDepositAmount());
            statement.setInt(6, bookingID);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete a booking by its ID
    public void deleteBooking(int bookingID) throws Exception {
        String sql = "DELETE FROM booking WHERE bookingID=?";
        ConnectionDB db = new ConnectionDB();
        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, bookingID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to list all bookings
    public List<Booking> getAllBookings() throws Exception {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM booking";
        ConnectionDB db = new ConnectionDB();
        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet resultSet = stmt.executeQuery();
            while (resultSet.next()) {
                Booking booking = new Booking();
                booking.setBookingID(resultSet.getInt("bookingID"));
                booking.setRoomID(resultSet.getInt("roomID"));
                booking.setCustomerID(resultSet.getInt("customerID"));
                booking.setStartDate(resultSet.getDate("startDate"));
                booking.setEndDate(resultSet.getDate("endDate"));
                booking.setDepositAmount(resultSet.getDouble("depositAmount"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }



    public  List<Object[]>  getUserBookings(int userID) throws Exception {

        List<Object[]> dataList = new ArrayList<>();

        String sql = "SELECT b.*, r.roomNumber, h.name\n" +
                "       FROM booking b\n" +
                "       JOIN rooms r ON b.roomID = r.roomID\n" +
                "       JOIN hotels h ON r.hotelID = h.hotelID\n" +
                "       where customerid=?;";

        // Connection object
        ConnectionDB db = new ConnectionDB();

        try (Connection connection = db.getConnection()){
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userID);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                dataList.add(new Object[]{
                        resultSet.getInt("bookingID"),
                        resultSet.getString("name"),
                        resultSet.getString("roomnumber"),
                        resultSet.getDate("startdate"),
                        resultSet.getDate("enddate"),
                        resultSet.getDouble("depositamount")});
            }
            //return rooms;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dataList;
    }



}
