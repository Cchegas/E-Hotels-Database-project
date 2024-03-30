package com.demo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;


public class RoomService {

    // Method to insert a room record
    public void insertRoom(Room room) throws Exception {
        String sql = "INSERT INTO rooms (hotelID, roomNumber, price, capacity, views, problems, petFriendly) VALUES (?, ?, ?, ?, ?, ?, ?)";
        // Connection object
        ConnectionDB db = new ConnectionDB();

        try (Connection connection = db.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, room.getHotelID());
            statement.setString(2, room.getRoomNumber());
            statement.setDouble(3, room.getPrice());
            statement.setInt(4, room.getCapacity());
            statement.setString(5, room.getViews());
            statement.setBoolean(6, room.isProblems());
            statement.setBoolean(7, room.isPetFriendly());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to update a room record
    public void updateRoom(int roomID, Room room) throws Exception {
        String sql = "UPDATE rooms SET hotelID=?, roomNumber=?, price=?, capacity=?, views=?, problems=?, petFriendly=? WHERE roomID=?";
        // Connection object
        ConnectionDB db = new ConnectionDB();

        try (Connection connection = db.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, room.getHotelID());
            statement.setString(2, room.getRoomNumber());
            statement.setDouble(3, room.getPrice());
            statement.setInt(4, room.getCapacity());
            statement.setString(5, room.getViews());
            statement.setBoolean(6, room.isProblems());
            statement.setBoolean(7, room.isPetFriendly());
            statement.setInt(8, roomID);

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete a room record
    public void deleteRoom(int roomID) throws Exception {
        String sql = "DELETE FROM rooms WHERE roomID=?";
        // Connection object
        ConnectionDB db = new ConnectionDB();

        try (Connection connection = db.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, roomID);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to retrieve all room records
    public List<Room> getAllRooms() throws Exception {
        List<Room> rooms = new ArrayList<>();

        // SQL query
        String sql = "SELECT * FROM rooms";
        // Connection object
        ConnectionDB db = new ConnectionDB();

        try (Connection connection = db.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Room room = new Room();
                    room.setRoomID(resultSet.getInt("roomID"));
                    room.setHotelID(resultSet.getInt("hotelID"));
                    room.setRoomNumber(resultSet.getString("roomNumber"));
                    room.setPrice(resultSet.getDouble("price"));
                    room.setCapacity(resultSet.getInt("capacity"));
                    room.setViews(resultSet.getString("views"));
                    room.setProblems(resultSet.getBoolean("problems"));
                    room.setPetFriendly(resultSet.getBoolean("petFriendly"));

                rooms.add(room);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rooms;
    }




    public  List<Object[]>  searchRooms(Date searchStartDate, Date searchEndDate, double maxPrice,int roomCapacity, String area, int hotelChainID, int hotelCategory, int numRooms) throws Exception {

        List<Object[]> dataList = new ArrayList<>();

        // SQL query
        String sql = "SELECT r.* , h.name, h.address, h.category, h.numberofrooms , h.chainid\n" +
                "           FROM rooms r JOIN hotels h ON r.hotelid = h.hotelid\n" +
                "           WHERE   chainid =? AND\n" +
                "                   numberofrooms >=? AND\n" +
                "                   category = ? AND\n" +
                "                   capacity =? AND \n" +
                "                   price<=? AND\n" +
                "                   r.roomid NOT IN (\n" +
                "                       SELECT DISTINCT b.roomid FROM booking b\n" +
                "                       WHERE (( b.startdate >=? AND b.startdate < ?) OR\n" +
                "                               ( b.enddate > ? AND b.enddate <= ?))\n" +
                "                   );";



      //  WHERE ( b.startdate >= ? AND b.startdate <= ?)
        // String sql = "SELECT * FROM rooms";

        // Connection object
        ConnectionDB db = new ConnectionDB();

        try (Connection connection = db.getConnection()){

             PreparedStatement statement = connection.prepareStatement(sql);
                statement.setInt(1, hotelChainID);
                statement.setInt(2, numRooms);
                statement.setInt(3, hotelCategory);
                statement.setInt(4, roomCapacity);
                statement.setDouble(5, maxPrice);
                statement.setDate(6, searchStartDate);
                statement.setDate(7, searchEndDate);
                statement.setDate(8, searchStartDate);
                statement.setDate(9, searchEndDate);
             ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {

                if (1>0){
                    dataList.add(new Object[]{
                            resultSet.getInt("roomID"),
                            resultSet.getInt("hotelID"),
                            resultSet.getString("roomNumber"),
                            resultSet.getDouble("price"),
                            resultSet.getInt("capacity"),
                            resultSet.getString("views"),
                            resultSet.getBoolean("problems"),
                            resultSet.getBoolean("petFriendly"),
                            resultSet.getString("name"),
                            resultSet.getString("address")});
                }
            }
            //return rooms;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dataList;
    }



    public List<Room> searchRoomsbyDates(Date searchStartDate, Date searchEndDate) throws Exception {

        List<Room> rooms = new ArrayList<>();


        String   sql = "  SELECT r.* , h.name, h.address, h.category, h.numberofrooms , h.chainid\n" +
                    "        FROM rooms r JOIN hotels h ON r.hotelid = h.hotelid\n" +
                    "        WHERE r.roomid NOT IN (\n" +
                    "                SELECT DISTINCT b.roomid FROM booking b\n" +
                    "                WHERE (( b.startdate >= ? AND b.startdate < ?) OR ( b.enddate > ? AND b.enddate <= ?))\n" +
                    "        );";



        //  WHERE ( b.startdate >= ? AND b.startdate <= ?)
        // String sql = "SELECT * FROM rooms";

        // Connection object
        ConnectionDB db = new ConnectionDB();

        try (Connection connection = db.getConnection()){

            PreparedStatement statement = connection.prepareStatement(sql);

                statement.setDate(1, searchStartDate);
                statement.setDate(2, searchEndDate);
                statement.setDate(3, searchStartDate);
                statement.setDate(4, searchEndDate);

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Room room = new Room();
                room.setRoomID(resultSet.getInt("roomID"));
                room.setHotelID(resultSet.getInt("hotelID"));
                room.setRoomNumber(resultSet.getString("roomNumber"));
                room.setPrice(resultSet.getDouble("price"));
                room.setCapacity(resultSet.getInt("capacity"));
                room.setViews(resultSet.getString("views"));
                room.setProblems(resultSet.getBoolean("problems"));
                room.setPetFriendly(resultSet.getBoolean("petFriendly"));

                if (!room.isProblems()){
                    rooms.add(room);
                }
            }
            return rooms;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rooms;
    }


    public  List<Object[]>   getHotelCapacity() throws Exception {

        List<Object[]> dataList = new ArrayList<>();

        String sql = "SELECT h.name AS hotelName, SUM(r.capacity) AS totalCapacity\n" +
                "   FROM rooms r\n" +
                "   INNER JOIN hotels h ON r.hotelID = h.hotelID\n" +
                "   GROUP BY h.name";

        // Connection object
        ConnectionDB db = new ConnectionDB();

        try (Connection connection = db.getConnection()){
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {

                dataList.add(new Object[]{
                            resultSet.getString("hotelName"),
                            resultSet.getInt("totalCapacity")});
                }
            //return rooms;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dataList;
    }



    public  List<Object[]>   getHotelCounts() throws Exception {

        List<Object[]> dataList = new ArrayList<>();

        String sql = "SELECT h.area AS area, COUNT(r.roomID) AS availableRooms\n" +
                "       FROM hotels h\n" +
                "       LEFT JOIN rooms r ON h.hotelID = r.hotelID\n" +
                "       WHERE r.problems = FALSE \n" +
                "       GROUP BY h.area;";

        // Connection object
        ConnectionDB db = new ConnectionDB();

        try (Connection connection = db.getConnection()){
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {

                dataList.add(new Object[]{
                        resultSet.getString("area"),
                        resultSet.getInt("availableRooms")});
            }
            //return rooms;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dataList;
    }





}
