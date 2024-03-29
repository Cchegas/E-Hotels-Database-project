<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.demo.HotelService" %>
<%@ page import="com.demo.Hotel" %>

<%
    // Create an instance of HotelService
    HotelService hotelService = new HotelService();

    // Get the action parameter from the request
    String action = request.getParameter("action");

    // Perform actions based on the action parameter
    if (action != null) {
        if (action.equals("insert")) {
            // Insert a new hotel
            int chainID = Integer.parseInt(request.getParameter("chainID"));
            String name = request.getParameter("name");
            int category = Integer.parseInt(request.getParameter("category"));
            int numberOfRooms = Integer.parseInt(request.getParameter("numberOfRooms"));
            String address = request.getParameter("address");
            String contactEmail = request.getParameter("contactEmail");
            String phoneNumber = request.getParameter("phoneNumber");

            Hotel newHotel = new Hotel(chainID, name, category, numberOfRooms, address, contactEmail, phoneNumber);
            hotelService.insertHotel(newHotel);

        } else if (action.equals("update")) {
            // Update an existing hotel
            int hotelID = Integer.parseInt(request.getParameter("hotelID"));
            int chainID = Integer.parseInt(request.getParameter("chainID"));
            String name = request.getParameter("name");
            int category = Integer.parseInt(request.getParameter("category"));
            int numberOfRooms = Integer.parseInt(request.getParameter("numberOfRooms"));
            String address = request.getParameter("address");
            String contactEmail = request.getParameter("contactEmail");
            String phoneNumber = request.getParameter("phoneNumber");

            Hotel updatedHotel = new Hotel( chainID, name, category, numberOfRooms, address, contactEmail, phoneNumber);
            hotelService.updateHotel(hotelID, updatedHotel);
        } else if (action.equals("delete")) {
            // Delete a hotel
            int hotelID = Integer.parseInt(request.getParameter("hotelID"));
            hotelService.deleteHotel(hotelID);
        }
    }

    // Get all hotels
    List<Hotel> hotels = hotelService.getAllHotels();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hotel Management</title>
</head>
<body>
    <h1>Hotel Management</h1>

    <!-- Form for inserting a new hotel -->
    <h2>Add a New Hotel</h2>
    <form action="hotel.jsp" method="post">
        Chain ID: <input type="text" name="chainID" required><br>
        Name: <input type="text" name="name" required><br>
        Category: <input type="text" name="category" required><br>
        Number of Rooms: <input type="text" name="numberOfRooms" required><br>
        Address: <input type="text" name="address" required><br>
        Contact Email: <input type="email" name="contactEmail" required><br>
        Phone Number: <input type="text" name="phoneNumber" required><br>
        <input type="hidden" name="action" value="insert">
        <input type="submit" value="Add Hotel">
    </form>




    <!-- List all hotels -->
    <h2>All Hotels</h2>
    <table border="1">
        <tr>
            <th>Hotel ID</th>
            <th>Chain ID</th>
            <th>Name</th>
            <th>Category</th>
            <th>Number of Rooms</th>
            <th>Address</th>
            <th>Contact Email</th>
            <th>Phone Number</th>
            <th>Action</th>
        </tr>
        <% for (Hotel hotel : hotels) { %>
            <tr>
                <td><%= hotel.getHotelID() %></td>
                <td><%= hotel.getChainID() %></td>
                <td><%= hotel.getName() %></td>
                <td><%= hotel.getCategory() %></td>
                <td><%= hotel.getNumberOfRooms() %></td>
                <td><%= hotel.getAddress() %></td>
                <td><%= hotel.getContactEmail() %></td>
                <td><%= hotel.getPhoneNumber() %></td>
                <td>
                    <!-- Update Button -->
                    <button onclick="openUpdateForm('<%= hotel.getHotelID() %>', '<%= hotel.getChainID() %>', '<%= hotel.getName() %>', '<%= hotel.getCategory() %>', '<%= hotel.getNumberOfRooms() %>', '<%= hotel.getAddress() %>', '<%= hotel.getContactEmail() %>', '<%= hotel.getPhoneNumber() %>')"> Update</button>

                    <!-- Delete Button -->
                    <form action="hotel.jsp" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="hotelID" value="<%= hotel.getHotelID() %>">
                        <input type="submit" value="Delete">
                    </form>
                </td>
            </tr>
        <% } %>
    </table>

    <!-- Hidden Update Form -->
    <div id="updateForm" class="update-form">
        <form action="hotel.jsp" method="post">
            <input type="hidden" id="updateAction" name="action" value="update">
            <input type="hidden" id="updateHotelID" name="hotelID">
            Chain ID: <input type="text" id="updateChainID" name="chainID"><br>
            Name: <input type="text" id="updateName" name="name"><br>
            Category: <input type="text" id="updateCategory" name="category"><br>
            Number of Rooms: <input type="text" id="updateNumberOfRooms" name="numberOfRooms"><br>
            Address: <input type="text" id="updateAddress" name="address"><br>
            Contact Email: <input type="email" id="updateContactEmail" name="contactEmail"><br>
            Phone Number: <input type="text" id="updatePhoneNumber" name="phoneNumber"><br>
            <input type="submit" value="Update">
            <button type="button" onclick="cancelUpdate()">Cancel</button>
        </form>
    </div>

    <!-- JavaScript to handle popup and form filling -->
    <script>
        function openUpdateForm(hotelID, chainID, name, category, numberOfRooms, address, contactEmail, phoneNumber) {
            document.getElementById('updateHotelID').value = hotelID;
            document.getElementById('updateChainID').value = chainID;
            document.getElementById('updateName').value = name;
            document.getElementById('updateCategory').value = category;
            document.getElementById('updateNumberOfRooms').value = numberOfRooms;
            document.getElementById('updateAddress').value = address;
            document.getElementById('updateContactEmail').value = contactEmail;
            document.getElementById('updatePhoneNumber').value = phoneNumber;
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
