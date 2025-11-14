<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DELETE</title>
</head>
<body>
<%
    String email = request.getParameter("email");
    Connection conn = null;
    PreparedStatement pst = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "your_username", "your_password");

        String query = "DELETE FROM users WHERE email = ?";
        pst = conn.prepareStatement(query);
        pst.setString(1, email);

        int rowsAffected = pst.executeUpdate();

        if (rowsAffected > 0) {
            out.println("<script>alert('Account deleted successfully'); window.location='index.html';</script>");
        } else {
            out.println("<script>alert('No account found with this email'); window.location='delete.html';</script>");
        }
    } catch (Exception e) {
        out.println("<script>alert('Error occurred: " + e.getMessage() + "'); window.location='delete.html';</script>");
    } finally {
        if (pst != null) pst.close();
        if (conn != null) conn.close();
    }
%>
</body>
</html>