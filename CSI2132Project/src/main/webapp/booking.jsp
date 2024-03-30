<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.demo.HotelService" %>
<%@ page import="com.demo.Room" %>
<%@ page import="com.demo.RoomService" %>
<%@ page import="com.demo.Booking" %>
<%@ page import="com.demo.BookingService" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.time.LocalDate" %>

<%
    RoomService roomService = new RoomService();
    BookingService bookingService = new BookingService();

    String username = request.getParameter("username");

    // Retrieve parameters for room search

    Date searchStartDate = Date.valueOf(LocalDate.now());
    Date searchEndDate = Date.valueOf(LocalDate.now());
    double maxPrice = 1000.00;
    int roomCapacity = 2;
    String area = "Ottawa";
    int hotelChainID = 1;
    int hotelCategory = 1;
    int numRooms = 1;

    // Retrieve rooms based on search criteria
    List<Object[]> rooms = roomService.searchRooms(searchStartDate,searchEndDate,maxPrice,roomCapacity,area,hotelChainID,hotelCategory,numRooms);

    // Search a room
    if (request.getParameter("action") != null && request.getParameter("action").equals("search")) {
         searchStartDate = Date.valueOf(request.getParameter("searchStartDate")) ;
         searchEndDate = Date.valueOf(request.getParameter("searchEndDate")) ;
         maxPrice = Double.parseDouble(request.getParameter("maxPrice")) ;
         roomCapacity = Integer.parseInt(request.getParameter("roomCapacity")) ;
         area = request.getParameter("area");
         hotelChainID = Integer.parseInt(request.getParameter("hotelChainID")) ;
         hotelCategory = Integer.parseInt(request.getParameter("hotelCategory")) ;
         numRooms = Integer.parseInt(request.getParameter("numRooms"));

        // Retrieve rooms based on search criteria
         rooms = roomService.searchRooms(searchStartDate,searchEndDate,maxPrice,roomCapacity,area,hotelChainID,hotelCategory,numRooms);
    }

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
<jsp:include page="navbar.jsp"/>

<h1>Booking Management</h1>


<div style="display: flex;">
    <!-- Search Rooms -->
    <div style="flex: 1; padding-right: 20px;">
        <h2>Search Rooms</h2>
        <form action="booking.jsp" method="post">
            <input type="hidden" id="searchAction" name="action" value="search">

            Start Date: <input type="date" name="searchStartDate" value="<%= searchStartDate %>"><br>
            End Date: <input type="date" name="searchEndDate" value="<%= searchEndDate %>"><br>
            Max Price: <input type="text" name="maxPrice" value="<%= maxPrice %>"><br>
            Room Capacity: <input type="text" name="roomCapacity" value="<%= roomCapacity %>"><br>
            Area: <input type="text" name="area" value="<%= area %>"><br>

            Hotel Chain:
                 <select name="hotelChainID">
                     <%
                         HotelService hotelService = new HotelService();
                         // Assuming you have a list of customers available
                         // Replace this with your actual list of customers
                         //List<Customer> customers = customerService.getAllCustomers();
                         List<Object[]> dataList = hotelService.getAllHotelsChain();
                         for (Object[] data : dataList) {
                     %>
                     <option value="<%= (int) data[0] %>"><%= (String) data[1] %> </option>
                     <% } %>
                 </select><br>

            Hotel Category:
                <select name="hotelCategory">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select><br>
            Number of Rooms: <input type="text" name="numRooms" value="<%= numRooms %>"><br>
            <input type="submit" value="Search">
        </form>

        <h3>Available Rooms</h3>
        <table border="1">
            <tr>
                <th>Room ID</th>
                <th>Hotel Name</th>
                <th>Room Number</th>
                <th>Price</th>
                <th>Capacity</th>
                <th>Views</th>
                <th>Problems</th>
                <th>Pet Friendly</th>
                <th>Hotel Address</th>
                <th>Action</th>
             </tr>
        <% for (Object[] room : rooms) {  %>
            <tr>
                <td><%= room[0] %></td>
                <td><%= room[8] %></td>
                <td><%= room[2] %></td>
                <td><%= room[3] %></td>
                <td><%= room[4] %></td>
                <td><%= room[5] %></td>
                <td><%= room[6] %></td>
                <td><%= room[7] %></td>
                <td><%= room[9] %></td>
                    <td>
                        <form action="booking.jsp" method="post">
                            <input type="hidden" name="roomID" value="<%= room[0] %>">
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
