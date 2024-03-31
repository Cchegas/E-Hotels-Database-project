<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.demo.EmployeeService" %>
<%@ page import="com.demo.Employee" %>

<%
    // Create an instance of EmployeeService
    EmployeeService employeeService = new EmployeeService();

    // Get the action parameter from the request
    String action = request.getParameter("action");

    // Perform actions based on the action parameter
    if (action != null) {
        if (action.equals("insert")) {
            // Insert a new employee
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String address = request.getParameter("address");
            String sinNumber = request.getParameter("sinNumber");
            String role = request.getParameter("role");

            Employee newEmployee = new Employee(firstName, lastName, address, sinNumber, role);
            employeeService.insertEmployee(newEmployee);

        } else if (action.equals("update")) {
            // Update an existing employee
            int employeeID = Integer.parseInt(request.getParameter("employeeID"));
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String address = request.getParameter("address");
            String sinNumber = request.getParameter("sinNumber");
            String role = request.getParameter("role");

            Employee updatedEmployee = new Employee(firstName, lastName, address, sinNumber, role);
            updatedEmployee.setEmployeeID(employeeID);
            employeeService.updateEmployee( updatedEmployee);
        } else if (action.equals("delete")) {
            // Delete an employee
            int employeeID = Integer.parseInt(request.getParameter("employeeID"));
            employeeService.deleteEmployee(employeeID);
        }
    }

    // Get all employees
    List<Employee> employees = employeeService.getAllEmployees();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Management</title>
</head>
<body>
    <jsp:include page="navbar.jsp"/>

    <h1>Employee Management</h1>

    <!-- Form for inserting a new employee -->
    <h2>Add a New Employee</h2>
    <form action="employee.jsp" method="post">
        First Name: <input type="text" name="firstName" required><br>
        Last Name: <input type="text" name="lastName" required><br>
        Address: <input type="text" name="address" required><br>
        SIN Number: <input type="text" name="sinNumber" required><br>
        Role: <input type="text" name="role" required><br>
        <input type="hidden" name="action" value="insert">
        <input type="submit" value="Add Employee">
    </form>

    <!-- List all employees -->
    <h2>All Employees</h2>
    <table border="1">
        <tr>
            <th>Employee ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Address</th>
            <th>SIN Number</th>
            <th>Role</th>
            <th>Action</th>
        </tr>
        <% for (Employee employee : employees) { %>
            <tr>
                <td><%= employee.getEmployeeID() %></td>
                <td><%= employee.getFirstName() %></td>
                <td><%= employee.getLastName() %></td>
                <td><%= employee.getAddress() %></td>
                <td><%= employee.getSinNumber() %></td>
                <td><%= employee.getRole() %></td>
                <td>
                    <!-- Update Button -->
                    <button onclick="openUpdateForm('<%= employee.getEmployeeID() %>', '<%= employee.getFirstName() %>', '<%= employee.getLastName() %>', '<%= employee.getAddress() %>', '<%= employee.getSinNumber() %>', '<%= employee.getRole() %>')">Update</button>

                    <!-- Delete Button -->
                    <form action="employee.jsp" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="employeeID" value="<%= employee.getEmployeeID() %>">
                        <input type="submit" value="Delete">
                    </form>
                </td>
            </tr>
        <% } %>
    </table>

    <!-- Hidden Update Form -->
    <div id="updateForm" class="update-form">
        <form action="employee.jsp" method="post">
            <input type="hidden" id="updateAction" name="action" value="update">
            <input type="hidden" id="updateEmployeeID" name="employeeID">
            First Name: <input type="text" id="updateFirstName" name="firstName"><br>
            Last Name: <input type="text" id="updateLastName" name="lastName"><br>
            Address: <input type="text" id="updateAddress" name="address"><br>
            SIN Number: <input type="text" id="updateSinNumber" name="sinNumber"><br>
            Role: <input type="text" id="updateRole" name="role"><br>
            <input type="submit" value="Update">
            <button type="button" onclick="cancelUpdate()">Cancel</button>
        </form>
    </div>

    <!-- JavaScript to handle popup and form filling -->
    <script>
        function openUpdateForm(employeeID, firstName, lastName, address, sinNumber, role) {
            document.getElementById('updateEmployeeID').value = employeeID;
            document.getElementById('updateFirstName').value = firstName;
            document.getElementById('updateLastName').value = lastName;
            document.getElementById('updateAddress').value = address;
            document.getElementById('updateSinNumber').value = sinNumber;
            document.getElementById('updateRole').value = role;
            document.getElementById('updateForm').style.display = 'block';
        }

        function cancelUpdate() {
            document.getElementById('updateForm').style.display = 'none';
        }
    </script>

    <!-- CSS for styling popup -->
    <style>
        .update-form {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            border: 1px solid #ccc;
            padding: 20px;
            background-color: #f9f9f9;
            z-index: 1000;
        }
    </style>

</body>
</html>
