<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Get the session
    //HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return; // Prevent further processing if the user is not logged in
    }

    // Retrieve username from the session
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
    <title>Task Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #008888; /* Darker teal background */
            display: flex;
            justify-content: center;
            align-items: flex-start; /* Align items to the top */
            min-height: 100vh;
            margin: 0;
            padding: 20px 0; /* Add padding to the top and bottom */
            animation: fadeInBody 2s ease-in-out;
            overflow: auto; /* Enable scrolling if needed */
        }
        .container {
            background-color: #009d91; /* Pastel teal */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px; /* Reduced padding */
             /* Set a max width for larger screens */
            text-align: center;
            animation: fadeInForm 1.5s ease-in-out;
        }
        h2 {
            color: #333;
            font-size: 24px;
            margin-top: 0;
            animation: fadeIn 1.5s ease-in-out;
        }
        .form-card,
        .table-card {
            background-color: #B0DFC0; /* Pastel green */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            padding: 15px; /* Reduced padding */
            text-align: left;
           
            
        }
        .form-card label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        .form-card input[type="text"],
        .form-card input[type="password"],
        .form-card input[type="date"],
        .form-card input[type="time"],
        .form-card select,
        .form-card textarea {
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px; /* Reduced font size */
            padding: 8px; /* Reduced padding */
            width: calc(100% - 16px); /* Adjust width considering padding */
            margin-bottom: 10px;
        }
        .form-card input[type="submit"] {
            background-color: #2EC4B6; /* Pastel teal */
            border: none;
            border-radius: 5px;
            color: white;
            cursor: pointer;
            font-size: 16px; /* Reduced font size */
            padding: 12px; /* Reduced padding */
            width: 100%;
            transition: background-color 0.3s ease, transform 0.3s ease;
            animation: fadeIn 2.5s ease-in-out;
        }
        .form-card input[type="submit"]:hover {
            background-color: #008479; /* Darker teal */
            transform: translateY(-2px);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #009d91; /* Pastel teal */
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        a {
            text-decoration: none;
            color: #333;
            transition: color 0.3s ease;
        }
        a:hover {
            color: #008479; /* Darker teal */
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
        <h2>Task Management for <%= username %></h2>
        <div class="form-card">
            <form action="TaskServlet" method="get">
                <input type="hidden" name="userId" value="<%= userId %>">
                <label for="project">Project:</label>
                <input type="text" id="project" name="project"><br>
                <label for="date">Date:</label>
                <input type="date" id="date" name="date"><br>
                <label for="startTime">Start Time:</label>
                <input type="time" id="startTime" name="startTime"><br>
                <label for="endTime">End Time:</label>
                <input type="time" id="endTime" name="endTime"><br>
                <label for="category">Category:</label>
                <input type="text" id="category" name="category"><br>
                <label for="description">Description:</label>
                <textarea id="description" name="description"></textarea><br>
                <input type="submit" value="Add Task">
            </form>
        </div>
        <div class="table-card">
            <h3>Your Tasks</h3>
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
                    try {
                        Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM Tasks WHERE employee_id=?");
                        ps.setInt(1, userId);
                        ResultSet rs = ps.executeQuery();
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
                        <a href="EditTaskServlet?taskId=<%= rs.getInt("task_id") %>">Edit</a> |
                        <a href="DeleteTaskServlet?taskId=<%= rs.getInt("task_id") %>">Delete</a>
                    </td>
                </tr>
                <%
                        }
                        rs.close();
                        ps.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </table>
        </div>
        <a href="dashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>
