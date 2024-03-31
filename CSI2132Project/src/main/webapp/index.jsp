<%@ page import="com.demo.LayoutService" %>
<%@ page import="com.demo.Pair" %>
<%@ page import="com.demo.Message" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.demo.Customer" %>
<%@ page import="com.demo.CustomerService" %>
<%@ page import="com.demo.RoomService" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    ArrayList<Message> messages;

    // get any incoming messages from session attribute named messages
    // if nothing exists then messages is an empty arraylist
    if ((ArrayList<Message>) session.getAttribute("messages") == null) messages = new ArrayList<>();
        // else get that value
    else messages = (ArrayList<Message>) session.getAttribute("messages");

    String msgField = "";

    // create the object in the form of a stringified json
    for (Message m : messages) {
        msgField += "{\"type\":\"" + m.type + "\",\"value\":\"" + m.value.replaceAll("['\"]+", "") + "\"},";
    }

    // empty session messages
    session.setAttribute("messages", new ArrayList<Message>());

    // retrieve best dribbler/shooter details from database
    Pair<String, Integer> bestDribblerDetails = null, bestShooterDetailes = null;
    LayoutService layoutService = new LayoutService();
    try {
        bestDribblerDetails = layoutService.getBestDribblerDetails();
        bestShooterDetailes = layoutService.getBestShooterDetails();

    } catch (Exception e) {
        e.printStackTrace();
    }

    // Retrieve rooms based on search criteria
    RoomService roomService= new RoomService();
    List<Object[]> rooms = roomService.getHotelCapacity();
    List<Object[]> availableRooms = roomService.getHotelCounts();
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title> Home Page </title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/styles.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
</head>

<body>

    <jsp:include page="navbar.jsp"/>

    <%-- User Selection Form --%>
<div class="container mt-5">
    <div class="row">
        <div class="col-md-4">
            <form action="index.jsp" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">Customer Login:</label>
                    <select name="customerID" class="form-select">
                        <%
                            CustomerService customerService = new CustomerService();
                            List<Customer> customers = customerService.getAllCustomers();
                            for (Customer customer : customers) {
                        %>
                        <option value="<%= customer.getCustomerID() %>"><%= customer.getFirstName() %> <%= customer.getLastName() %></option>
                        <% } %>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Customer Login</button>
            </form>
        </div>

                <div class="col-md-4">
                    <form action="index.jsp" method="post">
                    </form>
                </div>

        <div class="col-md-4">
            <form action="index.jsp" method="post">
                <div class="mb-3">
                    <label for="username1" class="form-label">Employee Login:</label>
                </div>
                Password: <input type="text" name="fakepassword" value="********"> <br>
                <input type="hidden" id="EmployeeLogin" name="customerID" value="-1">
                <button type="submit" class="btn btn-primary">Employee Login</button>
            </form>
        </div>
    </div>
</div>


    <%-- Check if username is user1 or user2 to enable/disable features --%>
    <% if (request.getParameter("customerID") != null) {
        int userID = Integer.parseInt(request.getParameter("customerID"));
    %>

    <div class="container mt-5">
        <div class="row">
            <% if (userID>0) { %>

            <div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title" style="color: red;">Booking</h4>
                        <p class="card-text" id="paragraph">Customer Booking<br></p>
                        <a class="btn btn-primary" id="show-btn" href="booking.jsp?username=<%= request.getParameter("customerID") %>">My Booking</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                    <div class="card" id="card-container-layout">
                        <div class="card-body" id="card">
                            <h4>Hotel Capacity</h4>
                                <table border="1">
                                    <tr>
                                        <th>Hotel Name</th>
                                        <th>Total Capacity</th>
                                     </tr>
                                <% for (Object[] room : rooms) {  %>
                                    <tr>
                                        <td><%= room[0] %></td>
                                        <td><%= room[1] %></td>
                                    </tr>
                                    <% } %>
                                </table>
                        </div>
                    </div>
            </div>

            <div class="col-md-4">
                    <div class="card" id="card-container-layout">
                        <div class="card-body" id="card">
                            <h4>Available Rooms</h4>
                                <table border="1">
                                    <tr>
                                        <th>Area</th>
                                        <th>Available Rooms</th>
                                     </tr>
                                <% for (Object[] room : availableRooms) {  %>
                                    <tr>
                                        <td><%= room[0] %></td>
                                        <td><%= room[1] %></td>
                                    </tr>
                                    <% } %>
                                </table>
                        </div>
                    </div>
            </div>


            <% } else if (userID<0) { %>
            <div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">Hotels</h4>
                        <p class="card-text" id="paragraph">Hotel management<br></p>
                        <a class="btn btn-primary" id="show-btn" href="hotel.jsp">View</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">Rooms</h4>
                        <p class="card-text" id="paragraph">Room management<br></p>
                        <a class="btn btn-primary" id="show-btn" href="room.jsp">View</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card" id="card-container-layout">
                        <div class="card-body" id="card">
                            <h4 class="card-title" style="color: red;">Renting</h4>
                            <p class="card-text" id="paragraph">Renting management<br></p>
                            <a class="btn btn-primary" id="show-btn" href="renting.jsp">View</a>
                        </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card" id="card-container-layout">
                        <div class="card-body" id="card">
                            <h4 class="card-title">Customer</h4>
                            <p class="card-text" id="paragraph">Customer management<br></p>
                            <a class="btn btn-primary" id="show-btn" href="customer.jsp">View</a>
                        </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card" id="card-container-layout">
                        <div class="card-body" id="card">
                            <h4 class="card-title">Employee</h4>
                            <p class="card-text" id="paragraph">Employee management<br></p>
                            <a class="btn btn-primary" id="show-btn" href="employee.jsp">View</a>
                        </div>
                </div>
            </div>

            <% } %>
        </div>
    </div>

    <% } %>

    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="/assets/js/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

    <script>
        $(document).ready(function() {
            toastr.options = {
                "closeButton": true,
                "positionClass": "toast-bottom-right",
                "preventDuplicates": false
            };
            /* In order to access variables sent to ejs file to script you must Parse them to string */
            /* then to parse them back to JSON */
            let messages = document.getElementById("message").value;
            if (messages !== "") messages = JSON.parse("[" + messages.slice(0, -1) + "]");
            else messages = [];

            messages.forEach(({ type, value }) => {
                switch (type) {
                    case "error":
                        toastr.error(value);
                        break;
                    case "success":
                        toastr.success(value);
                        break;
                    case "warning":
                        toastr.warning(value);
                        break;
                    default:
                        toastr.info(value);
                        break;
                }
            });
        });
    </script>
</body>

</html>
