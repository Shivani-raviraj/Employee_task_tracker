<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Weekly Tasks/Hours Bar Chart</title>
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
            animation: fadeInBody 2s ease-in-out;
        }
        .container {
            background-color: white; /* Pastel teal */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 90%;
            max-width: 900px;
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
            max-width: 100%;
            height: auto;
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
        <h2>Weekly Tasks/Hours Bar Chart</h2>
        <canvas id="AllWeeklyChart"></canvas>
        <a href="viewAllCharts.jsp">Back to Dashboard</a>
    </div>
    <script>
        fetch('AllWeeklyChartServlet')
            .then(response => response.json())
            .then(data => {
                const ctx = document.getElementById('AllWeeklyChart').getContext('2d');

                const labels = [];
                const datasetMap = {};

                data.datasets.forEach(item => {
                    if (!labels.includes(item.day)) {
                        labels.push(item.day);
                    }
                    if (!datasetMap[item.username]) {
                        datasetMap[item.username] = [];
                    }
                    datasetMap[item.username].push({
                        x: item.day,
                        y: item.duration
                    });
                });

                const datasets = Object.keys(datasetMap).map(username => ({
                    label: username,
                    data: datasetMap[username],
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }));

                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
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
                                text: "Weekly Tasks/Hours Distribution"
                            }
                        }
                    }
                });
            })
            .catch(error => console.error("Error fetching data:", error));
    </script>
</body>
</html>
