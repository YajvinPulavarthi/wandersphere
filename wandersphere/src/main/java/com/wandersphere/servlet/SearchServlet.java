package com.wandersphere.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

public class SearchServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String source = request.getParameter("source");
        String destination = request.getParameter("destination");
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");

        System.out.println("Source: " + source);
        System.out.println("Destination: " + destination);
        System.out.println("Start Date: " + startDate);
        System.out.println("End Date: " + endDate);

        List<Map<String, Object>> packages = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/wandersphere", "root", "");

            String sql = "SELECT p.package_id, p.source, p.destination, p.start_date, p.end_date, " +
                         "a.availability, a.no_of_slots_available, a.description, a.included_service, a.duration " +
                         "FROM packages p JOIN package_availability a ON p.package_id = a.package_id " +
                         "WHERE p.source = ? AND p.destination = ? " +
                         "AND p.start_date <= ? AND p.end_date >= ? " +
                         "AND a.availability = 'yes'";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, source);
            ps.setString(2, destination);
            ps.setString(3, endDate);    // Keep this for date-range logic
            ps.setString(4, startDate);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("package_id", rs.getInt("package_id"));
                row.put("source", rs.getString("source"));
                row.put("destination", rs.getString("destination"));
                row.put("start_date", rs.getDate("start_date"));
                row.put("end_date", rs.getDate("end_date"));
                row.put("availability", rs.getString("availability"));
                row.put("slots", rs.getInt("no_of_slots_available"));
                row.put("description", rs.getString("description"));
                row.put("services", rs.getString("included_service"));
                row.put("duration", rs.getInt("duration"));
                packages.add(row);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error fetching package details: " + e.getMessage());
        }

        request.setAttribute("packages", packages);
        request.setAttribute("source", source);
        request.setAttribute("destination", destination);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);

        RequestDispatcher rd = request.getRequestDispatcher("result.jsp");
        rd.forward(request, response);
    }
}
