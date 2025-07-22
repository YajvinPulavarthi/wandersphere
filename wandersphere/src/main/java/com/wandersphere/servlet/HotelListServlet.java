package com.wandersphere.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/HotelListServlet")
public class HotelListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String destination = request.getParameter("destination");
        JSONArray hotelArray = new JSONArray();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wandersphere", "root", "");

            String query = "SELECT hotel_name, price_per_night FROM hotels WHERE destination = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, destination);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                JSONObject hotel = new JSONObject();
                hotel.put("hotel_name", rs.getString("hotel_name"));
                hotel.put("price_per_night", rs.getDouble("price_per_night"));
                hotelArray.put(hotel);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(hotelArray.toString());
        out.flush();
    }
}

