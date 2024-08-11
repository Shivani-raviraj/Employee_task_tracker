<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return; // Prevent further processing if the user is not logged in
    }

    String username = (String) session.getAttribute("username");
    int userId = 0;
    String dbUrl = "jdbc:mysql://localhost:3306/EmployeeTaskTracker";
    String dbUser = "root";
    String dbPass = "believeinu23";

    // Query to get user_id from username
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
        PreparedStatement ps = con.prepareStatement("SELECT user_id FROM Users WHERE username=?");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            userId = rs.getInt("user_id");
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View All Tasks</title>
     <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #008888; /* Darker teal background */
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            animation: fadeInBody 2s ease-in-out;
        }
        .container {
            background-color: #009d91; /* Pastel teal */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 90%;
            max-width: 1200px;
            animation: fadeInForm 1.5s ease-in-out;
            display: flex;
            flex-direction: column;
            align-items: center; /* Center align items horizontally */
        }
        h2 {
            color: #333;
            font-size: 24px;
            margin-top: 0;
            animation: fadeIn 1.5s ease-in-out;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #B0DFC0; /* Pastel teal */
            color: black;
        }
        a {
            color: #2EC4B6; /* Pastel teal */
            text-decoration: none;
            padding: 5px 10px;
            border: 1px solid #2EC4B6;
            border-radius: 3px;
            transition: background-color 0.3s, color 0.3s;
        }
        a:hover {
            background-color: #2EC4B6; /* Pastel teal */
            color: #fff;
        }
        .button {
            display: inline-block;
            padding: 12px 24px;
            background-color: #B0DFC0; /* Pastel teal */
            color: black;
            border: none;
            border-radius: 5px;
            text-align: center;
            font-size: 16px;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
            margin-top: 20px; /* Add margin to space it from the table */
        }
        .button:hover {
            background-color: #008479; /* Darker teal */
            transform: translateY(-2px);
        }
        @keyframes fadeInBody {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        @keyframes fadeInForm {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>All Tasks for <%= username %></h2>
        <table>
            <tr>
                <th>Project</th>
                <th>Date</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Category</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
            <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                    ps = con.prepareStatement("SELECT * FROM Tasks WHERE user_id=?");
                    ps.setInt(1, userId);
                    rs = ps.executeQuery();
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("project") %></td>
                <td><%= rs.getDate("date") %></td>
                <td><%= rs.getTime("start_time") %></td>
                <td><%= rs.getTime("end_time") %></td>
                <td><%= rs.getString("category") %></td>
                <td><%= rs.getString("description") %></td>
                <td>
                    <a href="EditTaskServlet?taskId=<%= rs.getInt("task_id") %>">Edit</a>
                    <a href="DeleteTaskServlet?taskId=<%= rs.getInt("task_id") %>">Delete</a>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </table>
        <a href="dashboard.jsp" class="button">Back to Dashboard</a>
    </div>
</body>
</html>
