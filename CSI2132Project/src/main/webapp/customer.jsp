<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Date" %>
//<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.demo.CustomerService" %>
<%@ page import="com.demo.Customer" %>

<%
    // Create an instance of CustomerService
    CustomerService customerService = new CustomerService();

    // Get the action parameter from the request
    String action = request.getParameter("action");

    // Perform actions based on the action parameter
    //SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    if (action != null) {
        if (action.equals("insert")) {
            // Insert a new customer
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String dateOfRegistrationStr = request.getParameter("dateOfRegistration");
            Date dateOfRegistration =  Date.valueOf(dateOfRegistrationStr);
            String idType = request.getParameter("idType");
            String idNumber = request.getParameter("idNumber");

            Customer newCustomer = new Customer(firstName, lastName, dateOfRegistration, idType, idNumber);
            customerService.insertCustomer(newCustomer);

        } else if (action.equals("update")) {
            // Update an existing customer
            int customerID = Integer.parseInt(request.getParameter("customerID"));
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String dateOfRegistrationStr = request.getParameter("dateOfRegistration");
            Date dateOfRegistration =  Date.valueOf(dateOfRegistrationStr);
            String idType = request.getParameter("idType");
            String idNumber = request.getParameter("idNumber");

            Customer updatedCustomer = new Customer(customerID, firstName, lastName, dateOfRegistration, idType, idNumber);
            customerService.updateCustomer(updatedCustomer);
        } else if (action.equals("delete")) {
            // Delete a customer
            int customerID = Integer.parseInt(request.getParameter("customerID"));
            customerService.deleteCustomer(customerID);
        }
    }

    // Get all customers
    List<Customer> customers = customerService.getAllCustomers();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Management</title>
</head>
<body>
    <h1>Customer Management</h1>

    <!-- Form for inserting a new customer -->
    <h2>Add a New Customer</h2>
    <form action="customer.jsp" method="post">
        First Name: <input type="text" name="firstName" required><br>
        Last Name: <input type="text" name="lastName" required><br>
        Date of Registration: <input type="date" name="dateOfRegistration" required><br>
        ID Type: <input type="text" name="idType" required><br>
        ID Number: <input type="text" name="idNumber" required><br>
        <input type="hidden" name="action" value="insert">
        <input type="submit" value="Add Customer">
    </form>

    <!-- List all customers -->
 <h2>All Customers</h2>
 <table border="1">
     <tr>
         <th>Customer ID</th>
         <th>First Name</th>
         <th>Last Name</th>
         <th>Date of Registration</th>
         <th>ID Type</th>
         <th>ID Number</th>
         <th>Action</th>
     </tr>
     <% for (Customer customer : customers) { %>
         <tr>
             <td><%= customer.getCustomerID() %></td>
             <td><%= customer.getFirstName() %></td>
             <td><%= customer.getLastName() %></td>
             <td><%= customer.getdateOfRegistration() %></td>
             <td><%= customer.getIdType() %></td>
             <td><%= customer.getIdNumber() %></td>
             <td>
                 <!-- Update Button -->
                 <button onclick="openUpdateForm('<%= customer.getCustomerID() %>', '<%= customer.getFirstName() %>', '<%= customer.getLastName() %>', '<%= customer.getdateOfRegistration() %>', '<%= customer.getIdType() %>', '<%= customer.getIdNumber() %>')">Update</button>

                 <!-- Delete Button -->
                 <form action="customer.jsp" method="post" style="display: inline;">
                     <input type="hidden" name="action" value="delete">
                     <input type="hidden" name="customerID" value="<%= customer.getCustomerID() %>">
                     <input type="submit" value="Delete">
                 </form>
             </td>
         </tr>
     <% } %>
 </table>

 <!-- Hidden Update Form -->
 <div id="updateForm" class="update-form">
     <form action="customer.jsp" method="post">
         <input type="hidden" id="updateAction" name="action" value="update">
         <input type="hidden" id="updateCustomerID" name="customerID">
         First Name: <input type="text" id="updateFirstName" name="firstName"><br>
         Last Name: <input type="text" id="updateLastName" name="lastName"><br>
         Date of Registration: <input type="date" id="updatedateOfRegistration" name="dateOfRegistration"><br>
         ID Type: <input type="text" id="updateIdType" name="idType"><br>
         ID Number: <input type="text" id="updateIdNumber" name="idNumber"><br>
         <input type="submit" value="Update">
         <button type="button" onclick="cancelUpdate()">Cancel</button>
     </form>
 </div>

 <!-- JavaScript to handle popup and form filling -->
 <script>
     function openUpdateForm(customerID, firstName, lastName, dateOfRegistration, idType, idNumber) {
         document.getElementById('updateCustomerID').value = customerID;
         document.getElementById('updateFirstName').value = firstName;
         document.getElementById('updateLastName').value = lastName;
         document.getElementById('updatedateOfRegistration').value = dateOfRegistration;
         document.getElementById('updateIdType').value = idType;
         document.getElementById('updateIdNumber').value = idNumber;
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
