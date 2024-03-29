package com.demo;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RentingService {

    // Method to insert a new renting
    public void insertRenting(Renting renting) throws Exception {
        String sql = "INSERT INTO renting (roomID, customerID, startDate, endDate, paymentMethod, paymentAmount) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        ConnectionDB db = new ConnectionDB();
        try (Connection con = db.getConnection()) {
            PreparedStatement statement = con.prepareStatement(sql);

            statement.setInt(1, renting.getRoomID());
            statement.setInt(2, renting.getCustomerID());
            statement.setDate(3, renting.getStartDate());
            statement.setDate(4, renting.getEndDate());
            statement.setString(5, renting.getPaymentMethod());
            statement.setDouble(6, renting.getPaymentAmount());

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to update an existing renting
    public void updateRenting(int rentingID, Renting renting) throws Exception {
        String sql = "UPDATE renting SET roomID=?, customerID=?, startDate=?, endDate=?, paymentMethod=?, paymentAmount=? " +
                "WHERE rentingID=?";
        ConnectionDB db = new ConnectionDB();
        try (Connection con = db.getConnection()) {
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, renting.getRoomID());
            statement.setInt(2, renting.getCustomerID());
            statement.setDate(3, renting.getStartDate());
            statement.setDate(4, renting.getEndDate());
            statement.setString(5, renting.getPaymentMethod());
            statement.setDouble(6, renting.getPaymentAmount());
            statement.setInt(7, rentingID);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete a renting by its ID
    public void deleteRenting(int rentingID) throws Exception {
        String sql = "DELETE FROM renting WHERE rentingID=?";
        ConnectionDB db = new ConnectionDB();
        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, rentingID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to list all rentings
    public List<Renting> getAllRentings() throws Exception {
        List<Renting> rentings = new ArrayList<>();
        String sql = "SELECT * FROM renting";
        ConnectionDB db = new ConnectionDB();
        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet resultSet = stmt.executeQuery();
            while (resultSet.next()) {
                Renting renting = new Renting();
                renting.setRentingID(resultSet.getInt("rentingID"));
                renting.setRoomID(resultSet.getInt("roomID"));
                renting.setCustomerID(resultSet.getInt("customerID"));
                renting.setStartDate(resultSet.getDate("startDate"));
                renting.setEndDate(resultSet.getDate("endDate"));
                renting.setPaymentMethod(resultSet.getString("paymentMethod"));
                renting.setPaymentAmount(resultSet.getDouble("paymentAmount"));
                rentings.add(renting);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rentings;
    }
}
