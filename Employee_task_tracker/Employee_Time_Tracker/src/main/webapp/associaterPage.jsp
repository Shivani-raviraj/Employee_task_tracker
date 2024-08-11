<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Associate Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #008888; /* Pastel teal background */
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
            height: 300px;
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
        .card {
            background-color: #B0DFC0; /* Pastel green */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 15px 15px;
            width: 55%;
            margin-bottom: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: fadeIn 2s ease-in-out;
            text-decoration: none;
            color: #000;
            display: block;
            font-size: 20px;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        .button {
            background-color: #2EC4B6; /* Pastel teal */
            border: none;
            border-radius: 5px;
            color: white;
            cursor: pointer;
            font-size: 18px;
            padding: 15px 30px;
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.3s ease;
            animation: fadeIn 2.5s ease-in-out;
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
        <h2>Associate Page</h2>
        <a href="viewMyCharts.jsp" class="card">View My Charts</a>
        <a href="dashboard.jsp" class="button">Back to Dashboard</a>
    </div>
</body>
</html>
