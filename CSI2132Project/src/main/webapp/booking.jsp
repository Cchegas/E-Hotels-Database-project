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

    int userID =  Integer.parseInt(request.getParameter("username"));

    //Retrieve areas of hotels;
    List<Object[]> availableRooms = roomService.getHotelCounts();

    // Retrieve parameters for room search

    Date searchStartDate = Date.valueOf(LocalDate.now());
    Date searchEndDate = Date.valueOf(LocalDate.now().plusDays(1));
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
   List<Object[]>  bookings = bookingService.getUserBookings(userID);

    // Cancel a booking
    if (request.getParameter("action") != null && request.getParameter("action").equals("cancel")) {
        int bookingID = Integer.parseInt(request.getParameter("bookingID"));
        bookingService.deleteBooking(bookingID);
        // Redirect after delete
        response.sendRedirect("booking.jsp?username=" + userID );
    }

    // Book a room
    if (request.getParameter("action") != null && request.getParameter("action").equals("booking")) {
        int roomID = Integer.parseInt(request.getParameter("roomID"));
        int customerID =  userID;
        Date startDate = Date.valueOf(request.getParameter("startDate"));
        Date endDate = Date.valueOf(request.getParameter("endDate"));
        double depositAmount = Double.parseDouble(request.getParameter("depositAmount"));
        Booking newBooking = new Booking(roomID, customerID, startDate, endDate, depositAmount);
        bookingService.insertBooking(newBooking);
        // Redirect after booking
        response.sendRedirect("booking.jsp?username=" + userID );
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
            <input type="hidden" name="username" value="<%= userID %>">

            Start Date: <input type="date" name="searchStartDate" value="<%= searchStartDate %>"><br>
            End Date: <input type="date" name="searchEndDate" value="<%= searchEndDate %>"><br>
            Max Price: <input type="text" name="maxPrice" value="<%= maxPrice %>"><br>
            Room Capacity: <input type="text" name="roomCapacity" value="<%= roomCapacity %>"><br>
            Area:
                 <select name="area">
                     <%
                         for (Object[] data : availableRooms) {
                     %>
                     <option value="<%= (String) data[0] %>"  <% if(area.equals((String) data[0])) { %> selected <% } %> ><%= (String) data[0] %> </option>
                     <% } %>
                 </select><br>
            Hotel Chain:
                 <select name="hotelChainID">
                     <%
                         HotelService hotelService = new HotelService();
                         List<Object[]> dataList = hotelService.getAllHotelsChain();
                         for (Object[] data : dataList) {
                     %>
                     <option value="<%= (int) data[0] %>"  <% if(hotelChainID== (int) data[0]) { %> selected <% } %> ><%= (String) data[1] %> </option>
                     <% } %>
                 </select><br>
            Hotel Category:
                <select name="hotelCategory">
                    <option value="1" <% if(hotelCategory==1) { %> selected <% } %>>1</option>
                    <option value="2" <% if(hotelCategory==2) { %> selected <% } %>>2</option>
                    <option value="3" <% if(hotelCategory==3) { %> selected <% } %>>3</option>
                    <option value="4" <% if(hotelCategory==4) { %> selected <% } %>>4</option>
                    <option value="5" <% if(hotelCategory==5) { %> selected <% } %>>5</option>
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
                        <button onclick="openBookingForm('<%= (int) room[0] %>', '<%= searchStartDate %>', '<%= searchEndDate %>')">Book</button>
                    </td>
                </tr>
            <% } %>
        </table>
    </div>



 <!-- Hidden Check In Form -->
 <div id="bookingForm" class="update-form">
     <form action="booking.jsp" method="post">
         <input type="hidden" id="checkinAction" name="action" value="booking">
         <input type="hidden" name="username" value="<%= userID %>">
         <input type="hidden" id="bookingRoomID" name="roomID" >
         <input type="hidden" id="bookingStartDate"  name="startDate" >
         <input type="hidden" id="bookingEndDate"  name="endDate" >
         <p>Customer ID: <%= userID %></p>
         <p>Start Date: <%= searchStartDate %></p>
         <p>End Date: <%= searchEndDate %></p>
         Deposit Amount: <input type="text" id="depositAmount" name="depositAmount" value="100"><br>

         <input type="submit" value="Book">
         <button type="button" onclick="cancelBooking()">Cancel</button>
     </form>
 </div>

 <!-- JavaScript to handle popup and form filling -->
 <script>
     function openBookingForm(roomID, searchStartDate, searchEndDate) {
           document.getElementById('bookingRoomID').value = roomID;
           document.getElementById('bookingStartDate').value = searchStartDate;
           document.getElementById('bookingEndDate').value = searchEndDate;

         document.getElementById('bookingForm').style.display = 'block';
     }

     function cancelBooking() {
         document.getElementById('bookingForm').style.display = 'none';
     }
 </script>






    <!-- Existing Bookings -->
    <div style="flex: 1;">
        <h2>My Bookings</h2>
        <table border="1">
            <tr>
                <th>Booking ID</th>
                <th>Hotel</th>
                <th>Room Number</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Deposit Amount</th>
                <th>Actions</th>
            </tr>
            <% for (Object[] booking : bookings) { %>
                <tr>
                    <td><%=  booking[0] %></td>
                    <td><%=  booking[1] %></td>
                    <td><%=  booking[2] %></td>
                    <td><%=  booking[3] %></td>
                    <td><%=  booking[4] %></td>
                    <td>$<%= booking[5] %></td>
                    <td>
                        <form action="booking.jsp" method="post">
                            <input type="hidden" name="username" value="<%= userID %>">
                            <input type="hidden" name="bookingID" value="<%= booking[0] %>">
                            <input type="hidden" name="action" value="cancel">
                            <input type="submit" value="Cancel">
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>
    </div>
</div>



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
