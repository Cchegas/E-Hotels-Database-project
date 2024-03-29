<%@ page import="com.demo.LayoutService" %>
<%@ page import="com.demo.Pair" %>
<%@ page import="com.demo.Message" %>
<%@ page import="java.util.ArrayList" %>
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
        <form action="index.jsp" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Select User:</label>
                <select class="form-select" name="username" id="username">
                    <option value="user1">Customer</option>
                    <option value="user2">Employee</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
        </form>
    </div>

    <%-- Check if username is user1 or user2 to enable/disable features --%>
    <% if (request.getParameter("username") != null) {
        String username = request.getParameter("username");
        boolean isUser1 = "user1".equals(username);
        boolean isUser2 = "user2".equals(username);
    %>

    <div class="container mt-5">
        <div class="row">
            <% if (isUser1) { %>

            <div class="col-md-4">
                <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">Booking</h4>
                        <p class="card-text" id="paragraph">Customer Booking<br></p>
                        <a class="btn btn-primary" id="show-btn" href="booking.jsp">My Booking</a>
                    </div>
                </div>
            </div>

            <% } else if (isUser2) { %>
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
                        <h4 class="card-title">Renting</h4>
                        <p class="card-text" id="paragraph">Renting management<br></p>
                        <a class="btn btn-primary" id="show-btn" href="renting.jsp">View</a>
                    </div>
                </div>
            </div>
            <div class="card" id="card-container-layout">
                    <div class="card-body" id="card">
                        <h4 class="card-title">Customer</h4>
                        <p class="card-text" id="paragraph">Customer management<br></p>
                        <a class="btn btn-primary" id="show-btn" href="customer.jsp">View</a>
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
