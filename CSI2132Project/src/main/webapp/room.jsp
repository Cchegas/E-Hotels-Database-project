<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.demo.RoomService" %>
<%@ page import="com.demo.Room" %>

<%
    // Create an instance of RoomService
    RoomService roomService = new RoomService();

    // Get the action parameter from the request
    String action = request.getParameter("action");

    // Perform actions based on the action parameter
    if (action != null) {
        if (action.equals("insert")) {
            // Insert a new room
            int hotelID = Integer.parseInt(request.getParameter("hotelID"));
            String roomNumber = request.getParameter("roomNumber");
            double price = Double.parseDouble(request.getParameter("price"));
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            String views = request.getParameter("views");
            boolean problems = Boolean.parseBoolean(request.getParameter("problems"));
            boolean petFriendly = Boolean.parseBoolean(request.getParameter("petFriendly"));

            Room newRoom = new Room(hotelID, roomNumber, price, capacity, views, problems, petFriendly);
            roomService.insertRoom(newRoom);

        } else if (action.equals("update")) {
            // Update an existing room
            int roomID = Integer.parseInt(request.getParameter("roomID"));
            int hotelID = Integer.parseInt(request.getParameter("hotelID"));
            String roomNumber = request.getParameter("roomNumber");
            double price = Double.parseDouble(request.getParameter("price"));
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            String views = request.getParameter("views");
            boolean problems = Boolean.parseBoolean(request.getParameter("problems"));
            boolean petFriendly = Boolean.parseBoolean(request.getParameter("petFriendly"));

            Room updatedRoom = new Room(hotelID, roomNumber, price, capacity, views, problems, petFriendly);
            roomService.updateRoom(roomID, updatedRoom);
        } else if (action.equals("delete")) {
            // Delete a room
            int roomID = Integer.parseInt(request.getParameter("roomID"));
            roomService.deleteRoom(roomID);
        }
    }

    // Get all rooms
    List<Room> rooms = roomService.getAllRooms();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Room Management</title>
</head>
<body>
    <h1>Room Management</h1>

    <!-- Form for inserting a new room -->
    <h2>Add a New Room</h2>
    <form action="room.jsp" method="post">
        Hotel ID: <input type="text" name="hotelID" required><br>
        Room Number: <input type="text" name="roomNumber" required><br>
        Price: <input type="text" name="price" required><br>
        Capacity: <input type="text" name="capacity" required><br>
        Views: <input type="text" name="views" required><br>
        Problems: <input type="text" name="problems" required><br>
        Pet Friendly: <input type="text" name="petFriendly" required><br>
        <input type="hidden" name="action" value="insert">
        <input type="submit" value="Add Room">
    </form>

    <!-- List all rooms -->
    <h2>All Rooms</h2>
    <table border="1">
        <tr>
            <th>Room ID</th>
            <th>Hotel ID</th>
            <th>Room Number</th>
            <th>Price</th>
            <th>Capacity</th>
            <th>Views</th>
            <th>Problems</th>
            <th>Pet Friendly</th>
            <th>Action</th>
        </tr>
        <% for (Room room : rooms) { %>
            <tr>
                <td><%= room.getRoomID() %></td>
                <td><%= room.getHotelID() %></td>
                <td><%= room.getRoomNumber() %></td>
                <td><%= room.getPrice() %></td>
                <td><%= room.getCapacity() %></td>
                <td><%= room.getViews() %></td>
                <td><%= room.isProblems() %></td>
                <td><%= room.isPetFriendly() %></td>
                <td>
                    <!-- Update Button -->
                    <button onclick="openUpdateForm('<%= room.getRoomID() %>', '<%= room.getHotelID() %>', '<%= room.getRoomNumber() %>', '<%= room.getPrice() %>', '<%= room.getCapacity() %>', '<%= room.getViews() %>', '<%= room.isProblems() %>', '<%= room.isPetFriendly() %>')"> Update</button>

                    <!-- Delete Button -->
                    <form action="room.jsp" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="roomID" value="<%= room.getRoomID() %>">
                        <input type="submit" value="Delete">
                    </form>
                </td>
            </tr>
        <% } %>
    </table>

    <!-- Hidden Update Form -->
    <div id="updateForm" class="update-form">
        <form action="room.jsp" method="post">
            <input type="hidden" id="updateAction" name="action" value="update">
            <input type="hidden" id="updateRoomID" name="roomID">
            Hotel ID: <input type="text" id="updateHotelID" name="hotelID"><br>
            Room Number: <input type="text" id="updateRoomNumber" name="roomNumber"><br>
            Price: <input type="text" id="updatePrice" name="price"><br>
            Capacity: <input type="text" id="updateCapacity" name="capacity"><br>
            Views: <input type="text" id="updateViews" name="views"><br>
            Problems: <input type="text" id="updateProblems" name="problems"><br>
            Pet Friendly: <input type="text" id="updatePetFriendly" name="petFriendly"><br>
            <input type="submit" value="Update">
            <button type="button" onclick="cancelUpdate()">Cancel</button>
        </form>
    </div>

    <!-- JavaScript to handle popup and form filling -->
    <script>
        function openUpdateForm(roomID, hotelID, roomNumber, price, capacity, views, problems, petFriendly) {
            document.getElementById('updateRoomID').value = roomID;
            document.getElementById('updateHotelID').value = hotelID;
            document.getElementById('updateRoomNumber').value = roomNumber;
            document.getElementById('updatePrice').value = price;
            document.getElementById('updateCapacity').value = capacity;
            document.getElementById('updateViews').value = views;
            document.getElementById('updateProblems').value = problems;
            document.getElementById('updatePetFriendly').value = petFriendly;
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
