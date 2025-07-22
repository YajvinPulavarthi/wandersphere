<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("user_id");
String name = request.getParameter("username");
String email = request.getParameter("email");
String role = request.getParameter("role");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wandersphere", "root", "");
PreparedStatement ps = con.prepareStatement("UPDATE users SET username=?, email=?, role=? WHERE user_id=?");
ps.setString(1, name);
ps.setString(2, email);
ps.setString(3, role);
ps.setInt(4, Integer.parseInt(id));
ps.executeUpdate();
response.sendRedirect("users.jsp");
%>
