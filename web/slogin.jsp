<%-- 
    Document   : slogin
    Created on : Nov 15, 2018, 7:15:55 PM
    Author     : manoj
--%>
<%@ page import="java.sql.*"%>
        <%@ page import="javax.sql.*"%>
        <%
            String uid = request.getParameter("uname");
            String pswd = request.getParameter("pwd");
            try{
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbms?useSSL=false", "root", "1329");
            String Query="select * from student where stdid=? and pwd=?";
            PreparedStatement psm=conn.prepareStatement(Query);
            psm.setString(1,uid);
            psm.setString(2,pswd);
            ResultSet rs=psm.executeQuery();
            if(rs.next())
            {
                if(rs.getString(6).equals(pswd))
                {
                    String uname=rs.getString(2);
                    session.setAttribute("uname",uname);
                    String id=rs.getString(1);
                    session.setAttribute("id",id);
                    String dept=rs.getString(3);
                    session.setAttribute("dept",dept);
                    response.sendRedirect("home.jsp");
               }
                else
              { 
                  response.sendError(401,"Invalid Credentials");    
              }
            }
            else
              { 
                  response.sendError(401,"Invalid Credentials");
                  
              }
            }
            catch(Exception e)
              {
              out.println(e);
              }
%>