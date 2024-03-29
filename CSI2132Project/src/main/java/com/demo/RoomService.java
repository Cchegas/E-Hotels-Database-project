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




    public List<Room> searchRooms(Date searchStartDate, Date searchEndDate, double maxPrice,int roomCapacity, String area, int hotelChainID, int hotelCategory, int numRooms) throws Exception {

        List<Room> rooms = new ArrayList<>();

        // SQL query
        String sql = "  SELECT r.* , h.name, h.address, h.category, h.numberofrooms , h.chainid\n" +
                    "        FROM rooms r JOIN hotels h ON r.hotelid = h.hotelid\n" +
                    "        WHERE r.roomid NOT IN (\n" +
                    "                SELECT DISTINCT b.roomid FROM booking b\n" +
                    "                WHERE ( b.startdate >= ? AND b.startdate <= ?)\n" +
                    "        );";



      //  WHERE ( b.startdate >= ? AND b.startdate <= ?)
        // String sql = "SELECT * FROM rooms";

        // Connection object
        ConnectionDB db = new ConnectionDB();

        try (Connection connection = db.getConnection()){

             PreparedStatement statement = connection.prepareStatement(sql);
             statement.setDate(1, searchStartDate);
             statement.setDate(2, searchEndDate);
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


    public List<Room> searchRoomsbyDates(Date searchStartDate, Date searchEndDate) throws Exception {

        List<Room> rooms = new ArrayList<>();

        // SQL query
        String sql = "  SELECT r.* , h.name, h.address, h.category, h.numberofrooms , h.chainid\n" +
                "        FROM rooms r JOIN hotels h ON r.hotelid = h.hotelid\n" +
                "        WHERE r.roomid NOT IN (\n" +
                "                SELECT DISTINCT b.roomid FROM booking b\n" +
                "                WHERE ( b.startdate >= ? AND b.startdate <= ?)\n" +
                "        );";



        //  WHERE ( b.startdate >= ? AND b.startdate <= ?)
        // String sql = "SELECT * FROM rooms";

        // Connection object
        ConnectionDB db = new ConnectionDB();

        try (Connection connection = db.getConnection()){

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setDate(1, searchStartDate);
            statement.setDate(2, searchEndDate);
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


}
