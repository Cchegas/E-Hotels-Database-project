<%@ page import="java.util.List" %>
<%@ page import="com.demo.Room" %>
<%@ page import="com.demo.RoomService" %>
<%@ page import="com.demo.Booking" %>
<%@ page import="com.demo.BookingService" %>
<%@ page import="com.demo.Renting" %>
<%@ page import="com.demo.RentingService" %>
<%@ page import="java.sql.Date" %>

<%
    RoomService roomService = new RoomService();
    BookingService bookingService = new BookingService();
    RentingService rentingService = new RentingService();

    // Retrieve parameters for room search
    Date searchStartDate = request.getParameter("searchStartDate") != null ? Date.valueOf(request.getParameter("searchStartDate")) : null;
    Date searchEndDate = request.getParameter("searchEndDate") != null ? Date.valueOf(request.getParameter("searchEndDate")) : null;

    // Retrieve rooms based on search criteria
    List<Room> rooms = roomService.searchRoomsbyDates(searchStartDate, searchEndDate);

    // List all existing bookings
    List<Booking> bookings = bookingService.getAllBookings();

    // List all rentings
    List<Renting> rentings = rentingService.getAllRentings();

    // Check in a booking
    if (request.getParameter("action") != null && request.getParameter("action").equals("checkin")) {
        int bookingID = Integer.parseInt(request.getParameter("bookingID"));
        int roomID = Integer.parseInt(request.getParameter("roomID"));
        int customerID = Integer.parseInt(request.getParameter("customerID"));
        Date startDate =Date.valueOf(request.getParameter("startDate"));
        Date endDate = Date.valueOf(request.getParameter("endDate"));
        String paymentMethod = request.getParameter("paymentMethod");
        double paymentAmount = Double.parseDouble(request.getParameter("paymentAmount"));

        Renting newRenting = new Renting(roomID, customerID, startDate, endDate, paymentMethod , paymentAmount);
        rentingService.insertRenting(newRenting);
        // Redirect after delete
        response.sendRedirect("renting.jsp");
    }

    // Book a room
    if (request.getParameter("action") != null && request.getParameter("action").equals("book")) {
        int roomID = Integer.parseInt(request.getParameter("roomID"));
        int customerID = Integer.parseInt(request.getParameter("customerID"));
        Date startDate = Date.valueOf(request.getParameter("startDate"));
        Date endDate = Date.valueOf(request.getParameter("endDate"));
        double depositAmount = Double.parseDouble(request.getParameter("depositAmount"));
        Booking newBooking = new Booking(roomID, customerID, startDate, endDate, depositAmount);
        bookingService.insertBooking(newBooking);
        // Redirect after booking
        response.sendRedirect("renting.jsp");
    }
%>

<html>
<head>
    <title>Renting and Check in</title>
</head>
<body>

<h1>Booking Management</h1>

<div style="display: flex;">
    <!-- Search Rooms -->
    <div style="flex: 1; padding-right: 20px;">
        <h2>Available Rooms</h2>
        <form action="renting.jsp" method="get">
            Start Date: <input type="date" name="searchStartDate"><br>
            End Date: <input type="date" name="searchEndDate"><br>
            <input type="submit" value="Search">
        </form>

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
                         <!-- Rent Button -->
                         <button onclick="openRentForm('<%= room.getRoomID() %>', '<%= searchStartDate %>',  '<%= searchEndDate %>')">Rent</button>
                    </td>
                </tr>
            <% } %>
        </table>
    </div>


 <!-- Hidden Update Form -->
 <div id="rentingForm" class="update-form">
     <form action="renting.jsp" method="post">
         <input type="hidden" id="rentAction" name="action" value="rent">
         <input type="hidden" id="updateCustomerID" name="customerID">
         First Name: <input type="text" id="updateFirstName" name="firstName"><br>
         Last Name: <input type="text" id="updateLastName" name="lastName"><br>
         <input type="submit" value="Rent">
         <button type="button" onclick="cancelUpdate()">Cancel</button>
     </form>
 </div>


    <!-- Existing Bookings -->
    <div style="flex: 1;">
        <h2>Existing Bookings</h2>
        <table border="1">
            <tr>
                <th>Booking ID</th>
                <th>Room ID</th>
                <th>Customer ID</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Deposit Amount</th>
                <th>Action</th>
            </tr>
            <% for (Booking booking : bookings) { %>
                <tr>
                    <td><%= booking.getBookingID() %></td>
                    <td><%= booking.getRoomID() %></td>
                    <td><%= booking.getCustomerID() %></td>
                    <td><%= booking.getStartDate() %></td>
                    <td><%= booking.getEndDate() %></td>
                    <td>$<%= booking.getDepositAmount() %></td>
                    <td>
                        <button onclick="openCheckinForm('<%= booking.getBookingID() %>', '<%= booking.getRoomID() %>', '<%= booking.getCustomerID() %>', '<%= booking.getStartDate() %>', '<%= booking.getEndDate() %>')">Check In</button>
                    </td>
                </tr>
            <% } %>
        </table>
        <h2>All Rentings</h2>
        <table border="1">
            <tr>
                <th>Renting ID</th>
                <th>Room ID</th>
                <th>Customer ID</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Payment Method</th>
                <th>Payment Amount</th>
            </tr>
            <% for (Renting renting : rentings) { %>
                <tr>
                    <td><%= renting.getRentingID() %></td>
                    <td><%= renting.getRoomID() %></td>
                    <td><%= renting.getCustomerID() %></td>
                    <td><%= renting.getStartDate() %></td>
                    <td><%= renting.getEndDate() %></td>
                    <td><%= renting.getPaymentMethod() %></td>
                    <td>$<%= renting.getPaymentAmount() %></td>
                </tr>
            <% } %>
        </table>
    </div>
</div>





 <!-- Hidden Update Form -->
 <div id="checkinForm" class="update-form">
     <form action="renting.jsp" method="post">
         <input type="hidden" id="checkinAction" name="action" value="checkin">

         <input type="hidden" id="checkinBookingID" name="bookingID" >
         <input type="hidden" id="checkinRoomID" name="roomID" >
         <input type="hidden" id="checkinCustomerID"  name="customerID" >
         <input type="hidden" id="checkinStartDate"  name="startDate" >
         <input type="hidden" id="checkinEndDate"  name="endDate" >

         Payment Method: <input type="text" id="paymentMethod" name="paymentMethod"><br>
         Payment Amount: <input type="text" id="paymentAmount" name="paymentAmount"><br>

         <input type="submit" value="Check In">
         <button type="button" onclick="cancelCheckin()">Cancel</button>
     </form>
 </div>


 <!-- JavaScript to handle popup and form filling -->
 <script>
     function openRentForm(rooID,searchStartDate, searchEndDate) {
         document.getElementById('rentingForm').style.display = 'block';
     }

     function cancelUpdate() {
            document.getElementById('rentingForm').style.display = 'none';
        }

     function openCheckinForm(bookingID,roomID,customerID,startDate, endDate) {
          document.getElementById('checkinBookingID').value = bookingID;
          document.getElementById('checkinRoomID').value = roomID;
          document.getElementById('checkinCustomerID').value = customerID;
          document.getElementById('checkinStartDate').value = startDate;
          document.getElementById('checkinEndDate').value = endDate;

         document.getElementById('checkinForm').style.display = 'block';
     }

     function cancelCheckin() {
            document.getElementById('checkinForm').style.display = 'none';
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
