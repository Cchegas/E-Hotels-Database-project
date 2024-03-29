package com.demo;
import java.sql.*;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class CustomerService {


    // Method to insert a customer record
    public void insertCustomer(Customer customer)  throws Exception {
        String sql = "INSERT INTO customer (firstName, lastName, dateOfRegistration, idType, idNumber) VALUES (?, ?, ?, ?, ?)";
        // connection object
        ConnectionDB db = new ConnectionDB();

        try (Connection connection = db.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, customer.getFirstName());
            statement.setString(2, customer.getLastName());
            statement.setDate(3, customer.getdateOfRegistration());
            statement.setString(4, customer.getIdType());
            statement.setString(5, customer.getIdNumber());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to update a customer record
    public void updateCustomer(Customer customer) throws Exception{
        String sql = "UPDATE customer SET firstName=?, lastName=?, dateOfRegistration=?, idType=?, idNumber=? WHERE customerID=?";
        // connection object
        ConnectionDB db = new ConnectionDB();


        try (Connection connection = db.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, customer.getFirstName());
            statement.setString(2, customer.getLastName());
            statement.setDate(3,  customer.getdateOfRegistration());
            statement.setString(4, customer.getIdType());
            statement.setString(5, customer.getIdNumber());
            statement.setInt(6, customer.getCustomerID());

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete a customer record
    public void deleteCustomer(int customerID) throws Exception {
        String sql = "DELETE FROM customer WHERE customerID=?";
        // connection object
        ConnectionDB db = new ConnectionDB();
        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, customerID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new Exception(e.getMessage());
        }
    }

    // Method to retrieve all customer records
    public List<Customer> getAllCustomers() throws Exception {
        List<Customer> customers = new ArrayList<Customer>();

        // Return the list of all rooms

        // sql query
        String sql = "SELECT * FROM customer";
        // connection object
        ConnectionDB db = new ConnectionDB();


        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();

            // iterate through the result set
            while (rs.next()) {
                // create new student object
                Customer customer = new Customer(
                        rs.getInt("customerID"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getDate("dateOfRegistration"),
                        rs.getString("idType"),
                        rs.getString("idNumber")
                );

                // append student in students list
                customers.add(customer);
            }


            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();

            // return result
            return customers;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }

    }
}