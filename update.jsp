<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update User</title>
</head>
<body>
<%
    String email = request.getParameter("mail");
    String password = request.getParameter("pass");
    String newPhone = request.getParameter("phno");

    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/majesticmanor", "root", "");

        // Check if email and password match
        String query = "SELECT * FROM rdetails WHERE email = ? AND password = ?";
        pst = conn.prepareStatement(query);
        pst.setString(1, email);
        pst.setString(2, password);
        rs = pst.executeQuery();

        if (rs.next()) {
            // Update mobile number
            String updateQuery = "UPDATE rdetails SET phone = ? WHERE email = ?";
            pst = conn.prepareStatement(updateQuery);
            pst.setString(1, newPhone);
            pst.setString(2, email);

            int updated = pst.executeUpdate();
            if (updated > 0) {
                out.println("<script>alert('Phone number updated successfully'); window.location='index.html';</script>");
            } else {
                out.println("<script>alert('Failed to update phone number'); window.location='update.html';</script>");
            }
        } else {
            out.println("<script>alert('Invalid email or password'); window.location='update.html';</script>");
        }
    } catch (Exception e) {
        out.println("<script>alert('Error: " + e.getMessage() + "'); window.location='update.html';</script>");
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (conn != null) conn.close();
    }
%>
</body>
</html>
