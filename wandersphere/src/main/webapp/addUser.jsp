<%@ page import="java.sql.*" %>
<%
String username = request.getParameter("username");
String email = request.getParameter("email");
String password = request.getParameter("password");
String role = request.getParameter("role");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wandersphere", "root", "");
PreparedStatement ps = con.prepareStatement("INSERT INTO users(username, email, password, role) VALUES(?,?,?,?)");
ps.setString(1, username);
ps.setString(2, email);
ps.setString(3, password);
ps.setString(4, role);
ps.executeUpdate();
response.sendRedirect("users.jsp");
%>
