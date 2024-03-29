<%@ page import="java.util.List" %>
<%@ page import="com.demo.Room" %>
<%@ page import="com.demo.RoomService" %>
<%@ page import="com.demo.Booking" %>
<%@ page import="com.demo.BookingService" %>
<%@ page import="java.sql.Date" %>

<%
    RoomService roomService = new RoomService();
    BookingService bookingService = new BookingService();

    // Retrieve parameters for room search

    Date searchStartDate = request.getParameter("searchStartDate") != null ? Date.valueOf(request.getParameter("searchStartDate")) : null;
    Date searchEndDate = request.getParameter("searchEndDate") != null ? Date.valueOf(request.getParameter("searchEndDate")) : null;
    double maxPrice = request.getParameter("maxPrice") != null ? Double.parseDouble(request.getParameter("maxPrice")) : Double.MAX_VALUE;
    int roomCapacity = request.getParameter("roomCapacity") != null ? Integer.parseInt(request.getParameter("roomCapacity")) : 0;
    String area = request.getParameter("area");
    int hotelChainID = request.getParameter("hotelChainID") != null ? Integer.parseInt(request.getParameter("hotelChainID")) : 0;
    int hotelCategory = request.getParameter("hotelCategory") != null ? Integer.parseInt(request.getParameter("hotelCategory")) : 0;
    int numRooms = request.getParameter("numRooms") != null ? Integer.parseInt(request.getParameter("numRooms")) : 0;

    // Retrieve rooms based on search criteria
    List<Room> rooms = roomService.searchRooms(searchStartDate,searchEndDate,maxPrice,roomCapacity,area,hotelChainID,hotelCategory,numRooms);


    // List all existing bookings
    List<Booking> bookings = bookingService.getAllBookings();

    // Cancel a booking
    if (request.getParameter("action") != null && request.getParameter("action").equals("cancel")) {
        int bookingID = Integer.parseInt(request.getParameter("bookingID"));
        bookingService.deleteBooking(bookingID);
        // Redirect after delete
        response.sendRedirect("booking.jsp");
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
        response.sendRedirect("booking.jsp");
    }
%>

<html>
<head>
    <title>Booking Management</title>
</head>
<body>

<h1>Booking Management</h1>
    <jsp:include page="navbar.jsp"/>

<div style="display: flex;">
    <!-- Search Rooms -->
    <div style="flex: 1; padding-right: 20px;">
        <h2>Search Rooms</h2>
        <form action="booking.jsp" method="get">
            Start Date: <input type="date" name="searchStartDate" value="<%= request.getParameter("searchStartDate") %>"><br>
            End Date: <input type="date" name="searchEndDate" value="<%= request.getParameter("searchEndDate") %>"><br>
            Max Price: <input type="text" name="maxPrice" value="<%= request.getParameter("maxPrice") %>"><br>
            Room Capacity: <input type="text" name="roomCapacity" value="<%= request.getParameter("roomCapacity") %>"><br>
            Area: <input type="text" name="area" value="<%= request.getParameter("area") %>"><br>
            Hotel Chain ID: <input type="text" name="hotelChainID" value="<%= request.getParameter("hotelChainID") %>"><br>
            Hotel Category: <input type="text" name="hotelCategory" value="<%= request.getParameter("hotelCategory") %>"><br>
            Number of Rooms: <input type="text" name="numRooms" value="<%= request.getParameter("numRooms") %>"><br>
            <input type="submit" value="Search">
        </form>

        <h3>Available Rooms</h3>
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
                        <form action="booking.jsp" method="post">
                            <input type="hidden" name="roomID" value="<%= room.getRoomID() %>">
                            <input type="hidden" name="customerID" value="2"> <!-- Assuming customerID is 1 for now -->
                            <input type="hidden" name="startDate" value="<%= searchStartDate %>">
                            <input type="hidden" name="endDate" value="<%= searchEndDate %>"> <!-- Assuming same start and end date for now -->
                            <input type="hidden" name="depositAmount" value="100"> <!-- Assuming deposit amount is 100 for now -->
                            <input type="hidden" name="action" value="book">
                            <input type="submit" value="Book">
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>
    </div>

    <!-- Existing Bookings -->
    <div style="flex: 1;">
        <h2>My Bookings</h2>
        <table border="1">
            <tr>
                <th>Booking ID</th>
                <th>Room ID</th>
                <th>Customer ID</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Deposit Amount</th>
                <th>Actions</th>
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
                        <form action="booking.jsp" method="post">
                            <input type="hidden" name="bookingID" value="<%= booking.getBookingID() %>">
                            <input type="hidden" name="action" value="cancel">
                            <input type="submit" value="Cancel">
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>
    </div>
</div>

</body>
</html>
