<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    } else {
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Monthly Tasks/Hours Bar Chart</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
            padding: 10px; /* Reduced padding for better fit */
            animation: fadeInBody 2s ease-in-out;
        }
        .container {
            background-color: white; /* Pastel teal */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 100%;
            max-width: 800px;
            text-align: center;
            animation: fadeInForm 1.5s ease-in-out;
        }
        h2 {
            color: #333;
            font-size: 24px;
            margin-top: 0;
            animation: fadeIn 1.5s ease-in-out;
        }
        canvas {
            width: 100% !important;
            height: auto !important;
        }
       a {
            display: inline-block;
            background-color: #009d91;
            margin-top: 20px;
            color: #333 ; /* Pastel teal */
            text-decoration: none;
            font-weight: bold;
            border: 1px solid #2EC4B6;
            padding: 10px 20px;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }
        a:hover {
            background-color: #2EC4B6; /* Pastel teal */
            color: #fff;
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
        <h2>Monthly Tasks/Hours Bar Chart</h2>
        <canvas id="ALLMonthlyChart"></canvas>
        <a href="viewAllCharts.jsp">Back to Dashboard</a>
    </div>
    <script>
        fetch('AllMonthlyChartServlet')
            .then(response => response.json())
            .then(data => {
                console.log("Data received from servlet:", data); // Debugging log

                const ctx = document.getElementById('ALLMonthlyChart').getContext('2d');

                const labels = new Set();
                const datasetMap = {};

                // Process userTasks to get labels and datasetMap
                for (const [username, userData] of Object.entries(data.userTasks)) {
                    datasetMap[username] = [];
                    userData.labels.forEach((day, index) => {
                        labels.add(day);
                        datasetMap[username].push({
                            x: day,
                            y: userData.data[index]
                        });
                    });
                }

                // Convert labels Set to an array and sort it
                const sortedLabels = Array.from(labels).sort();

                // Prepare datasets
                const datasets = Object.keys(datasetMap).map(username => ({
                    label: username,
                    data: sortedLabels.map(label => {
                        const point = datasetMap[username].find(p => p.x === label);
                        return point ? point.y : 0;
                    }),
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }));

                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: sortedLabels,
                        datasets: datasets
                    },
                    options: {
                        responsive: true,
                        scales: {
                            x: {
                                type: 'category',
                                title: {
                                    display: true,
                                    text: 'Days'
                                }
                            },
                            y: {
                                beginAtZero: true,
                                title: {
                                    display: true,
                                    text: 'Hours'
                                }
                            }
                        },
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                            title: {
                                display: true,
                                text: "Monthly Tasks/Hours Distribution"
                            }
                        }
                    }
                });
            })
            .catch(error => {
                console.error("Error fetching data:", error); // Debugging log
            });
    </script>
</body>
</html>
<%
    }
%>
