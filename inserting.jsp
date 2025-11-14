<%@ include file="db1.jsp" %>
<%
    Connection c=null;
    PreparedStatement ps=null;

    String name=request.getParameter("name");
    String password=request.getParameter("password");
    String age=request.getParamater("age");
    String email=request.getParameter("email");
    String  gender=request.getParameter("gender");
    String city=request.getParameter("city");

    try
    {
        con=getConnection();
        
        String sql="INSERT INTO summa (name,password,age,email,gender,city) VALUES (?,?,?,?,?,?) "

        ps=con.prepareStatement();

        ps.setString(1,name);
        ps.setString(2,password);
        ps.setString(3,age);
        ps.setString(4,email);
        ps.setString(5,gender);
        ps.setString(6,city);

        int count=ps.executeUpdate();

        if(count>0)
        {
            out.println(Signup successfull);
        }
        else{
            out.println(Signup not successfull);
        }
    }
    catch(Exception e)
    {
        out.println(e.getMessage());
    }
    finally{
        if(con!=null)   con.close();
        if(ps!=null)    ps.close();
    }
%>