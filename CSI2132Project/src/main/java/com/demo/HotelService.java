package com.demo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HotelService {


    // Constructor
    //public HotelService() {}

    // Method to insert a new hotel
    public void insertHotel(Hotel hotel)  throws Exception {
        String sql = "INSERT INTO hotels (chainID, name, category, numberOfRooms, address, area,  contactEmail, phoneNumber) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?,?)";
        ConnectionDB db = new ConnectionDB();
        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, hotel.getChainID());
            statement.setString(2, hotel.getName());
            statement.setInt(3, hotel.getCategory());
            statement.setInt(4, hotel.getNumberOfRooms());
            statement.setString(5, hotel.getAddress());
            statement.setString(6, hotel.getArea());
            statement.setString(7, hotel.getContactEmail());
            statement.setString(8, hotel.getPhoneNumber());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to update an existing hotel
    public void updateHotel(int hotelID, Hotel hotel)  throws Exception {
        String sql = "UPDATE hotels SET chainID=?, name=?, category=?, numberOfRooms=?, address=?, contactEmail=?, phoneNumber=? " +
                "WHERE hotelID=?";
        ConnectionDB db = new ConnectionDB();
        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement statement = con.prepareStatement(sql);

            statement.setInt(1, hotel.getChainID());
            statement.setString(2, hotel.getName());
            statement.setInt(3, hotel.getCategory());
            statement.setInt(4, hotel.getNumberOfRooms());
            statement.setString(5, hotel.getAddress());
            statement.setString(6, hotel.getContactEmail());
            statement.setString(7, hotel.getPhoneNumber());
            statement.setInt(8, hotelID);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete a hotel by its ID
    public void deleteHotel(int hotelID)  throws Exception {
        String sql = "DELETE FROM hotels WHERE hotelID=?";

        ConnectionDB db = new ConnectionDB();
        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setInt(1, hotelID);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to list all hotels
    public List<Hotel> getAllHotels()  throws Exception {
        List<Hotel> hotels = new ArrayList<>();
        String sql = "SELECT * FROM hotels";

        ConnectionDB db = new ConnectionDB();
        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);
            // get the results from executing the query
            ResultSet resultSet = stmt.executeQuery();

            while (resultSet.next()) {
                Hotel hotel = new Hotel();
                hotel.setHotelID(resultSet.getInt("hotelID"));
                hotel.setChainID(resultSet.getInt("chainID"));
                hotel.setName(resultSet.getString("name"));
                hotel.setCategory(resultSet.getInt("category"));
                hotel.setNumberOfRooms(resultSet.getInt("numberOfRooms"));
                hotel.setAddress(resultSet.getString("address"));
                hotel.setArea(resultSet.getString("area"));
                hotel.setContactEmail(resultSet.getString("contactEmail"));
                hotel.setPhoneNumber(resultSet.getString("phoneNumber"));
                hotels.add(hotel);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return hotels;
    }

    public List<Object[]> getAllHotelsChain()  throws Exception {
        List<Object[]> dataList = new ArrayList<>();

        String sql = "SELECT * FROM hotelchain";

        ConnectionDB db = new ConnectionDB();
        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);
            // get the results from executing the query
            ResultSet resultSet = stmt.executeQuery();

            while (resultSet.next()) {
                dataList.add(new Object[]{resultSet.getInt("chainID"), resultSet.getString("name")});
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dataList;
    }

}
