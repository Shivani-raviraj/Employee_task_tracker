<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #008888; /* Light pastel blue */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            animation: fadeInBody 2s ease-in-out;
        }
        .login-container {
            background-color: #009d91; /* Pastel teal */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 300px;
            text-align: center;
            animation: fadeInForm 1.5s ease-in-out;
        }
        h2 {
            color: #333;
            font-size: 24px;
            margin-top: 0;
            animation: fadeIn 1.5s ease-in-out;
        }
        label {
            display: block;
            color: #555555; /* Medium grey for labels */
            margin-bottom: 5px;
            font-size: 16px;
        }
        input[type="text"], input[type="password"] {
            width: calc(100% - 22px);
            padding: 12px;
            margin: 8px 0;
            margin-bottom: 20px;
            border: 1px solid #cccccc;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #2EC4B6; /* Highlight color */
            outline: none;
        }
        input[type="password"] {
            margin-bottom: 20px; /* Add space between password field and button */
        }
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #2EC4B6; /* Pastel teal */
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease, transform 0.3s ease;
            animation: fadeIn 2s ease-in-out;
        }
        input[type="submit"]:hover {
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
    <div class="login-container">
        <h2>Login</h2>
        <form action="LoginServlet" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password">
            <input type="submit" value="Login">
        </form>
    </div>
</body>
</html>
