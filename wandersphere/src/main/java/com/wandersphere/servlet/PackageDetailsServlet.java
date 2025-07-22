package com.wandersphere.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONObject;

@WebServlet("/PackageDetailsServlet")
public class PackageDetailsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String packageId = request.getParameter("package_id");
        JSONObject packageData = new JSONObject();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wandersphere", "root", "");

            String query = "SELECT p.destination, a.duration FROM packages p " +
                           "JOIN package_availability a ON p.package_id = a.package_id " +
                           "WHERE p.package_id = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, Integer.parseInt(packageId));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                packageData.put("destination", rs.getString("destination"));
                packageData.put("duration", rs.getInt("duration"));
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(packageData.toString());
        out.flush();
    }
}
