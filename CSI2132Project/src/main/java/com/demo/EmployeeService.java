package com.demo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmployeeService {

    // Method to insert an employee record
    public void insertEmployee(Employee employee) throws Exception {
        String sql = "INSERT INTO employees (firstName, lastName, address, sinNumber, role) VALUES (?, ?, ?, ?, ?)";
        // Connection object
        ConnectionDB db = new ConnectionDB();

        try (Connection connection = db.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, employee.getFirstName());
            statement.setString(2, employee.getLastName());
            statement.setString(3, employee.getAddress());
            statement.setString(4, employee.getSinNumber());
            statement.setString(5, employee.getRole());

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to update an employee record
    public void updateEmployee(Employee employee) throws Exception {
        String sql = "UPDATE employees SET firstName=?, lastName=?, address=?, sinNumber=?, role=? WHERE employeeID=?";
        // Connection object
        ConnectionDB db = new ConnectionDB();

        try (Connection connection = db.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, employee.getFirstName());
            statement.setString(2, employee.getLastName());
            statement.setString(3, employee.getAddress());
            statement.setString(4, employee.getSinNumber());
            statement.setString(5, employee.getRole());
            statement.setInt(6, employee.getEmployeeID());

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete an employee record
    public void deleteEmployee(int employeeID) throws Exception {
        String sql = "DELETE FROM employees WHERE employeeID=?";
        // Connection object
        ConnectionDB db = new ConnectionDB();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, employeeID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new Exception(e.getMessage());
        }
    }

    // Method to retrieve all employee records
    public List<Employee> getAllEmployees() throws Exception {
        List<Employee> employees = new ArrayList<>();

        // SQL query
        String sql = "SELECT * FROM employees";
        // Connection object
        ConnectionDB db = new ConnectionDB();

        // Try to connect to the database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // Prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // Get the results from executing the query
            ResultSet rs = stmt.executeQuery();

            // Iterate through the result set
            while (rs.next()) {
                // Create a new employee object
                Employee employee = new Employee(
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("address"),
                        rs.getString("sinNumber"),
                        rs.getString("role")
                );

                employee.setEmployeeID(rs.getInt("employeeID"));

                // Append the employee to the list
                employees.add(employee);
            }

            // Close the result set
            rs.close();
            // Close the statement
            stmt.close();
            // Close the connection
            con.close();
            // Close the connection object
            db.close();

            // Return the result
            return employees;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }
}
