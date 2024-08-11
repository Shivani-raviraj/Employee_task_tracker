<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return; // Prevent further processing if the user is not logged in
    }

    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Weekly Tasks/Hours Bar Chart</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #008888;
            color: #333;
            text-align: center;
            margin: 0;
            padding: 20px;
        }
        .chart-container {
            width: 100%;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
        canvas {
            width: 100% !important;
            height: auto !important;
        }
        a {
            background-color: #B0DFC0; 
            color: black;
            text-decoration: none;
            padding: 15px 30px;
            border: 1px solid ;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
            display: inline-block;
            margin-top: 20px;
        }
        a:hover {
            background-color:  #A0D8A0;
            color: #333;
        }
    </style>
</head>
<body>
    <h2>Weekly Tasks/Hours Bar Chart for <%= username %></h2>
    <div class="chart-container">
        <canvas id="weeklyChart"></canvas>
        
    </div>
    <script>
        fetch('WeeklyChartsServlet')
        .then(response => response.json())
        .then(data => {
            const ctx = document.getElementById('weeklyChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: data.labels,
                    datasets: [{
                        label: 'Tasks/Hours',
                        data: data.data,
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    },
                    maintainAspectRatio: false
                }
            });
        })
        .catch(error => {
            console.error('Error fetching chart data:', error);
        });
    </script>
    <a href="dashboard.jsp">Back to Dashboard</a>
</body>
</html>
