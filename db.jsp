<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Connection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
</head>
<body>
<%
    // Check if the form is submitted via POST
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Retrieve form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Basic server-side validation
        if(name == null || name.trim().isEmpty() ||
           email == null || email.trim().isEmpty() ||
           phone == null || phone.trim().isEmpty() ||
           password == null || password.trim().isEmpty() ||
           confirmPassword == null || confirmPassword.trim().isEmpty()){
            out.println("<p style='color:red;'>Please fill in all required fields.</p>");
        } else if (!password.equals(confirmPassword)) {
            out.println("<p style='color:red;'>Passwords do not match.</p>");
        } else {
            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                // Update the connection URL and database name as needed
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/majesticmanor", "root", "");
                
                // Prepare an INSERT statement (assumes you have a table "users" with columns name, email, phone, password)
                PreparedStatement ps = con.prepareStatement("INSERT INTO users (name, email, phone, password) VALUES (?, ?, ?, ?)");
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, phone);
                ps.setString(4, password); // For production, store a hashed password!
                
                int result = ps.executeUpdate();
                if(result > 0) {
                    out.println("<p style='color:green;'>Sign Up successful!</p>");
                    // Optionally, you might redirect the user:
                    // response.sendRedirect("welcome.jsp");
                } else {
                    out.println("<p style='color:red;'>Sign Up failed. Please try again.</p>");
                }
                con.close();
            } catch(Exception e) {
                e.printStackTrace();
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        }
    }
%>
</body>
</html>