<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
   // HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return; // Prevent further processing if the user is not logged in
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View My Charts</title>
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
            width: 400px;
            height: 400px;
            display: flex;
            flex-direction: column;
            justify-content: space-around;
            align-items: center;
            text-align: center;
            animation: fadeInForm 1.5s ease-in-out;
        }
        h2 {
            color: #333;
            font-size: 24px;
            margin-top: 0;
            animation: fadeIn 1.5s ease-in-out;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            margin: 10px 0;
        }
        a {
            display: block;
            background-color: #B0DFC0; /* Pastel green */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            color: #333;
            font-size: 18px;
            margin-bottom: 15px;
            padding: 15px 30px;
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.3s ease;
            animation: fadeIn 2s ease-in-out;
        }
        a:hover {
            background-color: #A0D8A0; /* Lighter pastel green */
            transform: translateY(-5px);
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
        <h2>My Charts</h2>
        <ul>
            <li><a href="dailyChart.jsp">View Daily Chart</a></li>
            <li><a href="weeklyChart.jsp">View Weekly Chart</a></li>
            <li><a href="monthlyChart.jsp">View Monthly Chart</a></li>
        </ul>
        <a href="dashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>
