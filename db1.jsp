<%@ page import="java.mysql.*" %>
<%!
    public Connnection getConnection() throws Exception
    {
        String url="jdbc:mysql://localhost:3306/testing"
        String user="root";
        String password="";
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url,user,password);
    }
%>