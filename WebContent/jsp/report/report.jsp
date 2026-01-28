<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*, model.*" %>

<%
    List<Report> reports = (List<Report>) request.getAttribute("reports");
    if (reports == null) {
        reports = new ArrayList<>();
    }

    int totalIn = 0;
    int totalOut = 0;
    int totalQty = 0;

    for (Report r : reports) {
        totalIn += r.getTotalIn();
        totalOut += r.getTotalOut();
        totalQty += r.getCurrentQuantity();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Inventory Reports</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: #f4f6fb;
        }

        .page-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 20px 30px;
            border-radius: 15px;
            margin-bottom: 25px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
        }

        .card-box {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .stat-card {
            text-align: center;
            padding: 20px;
            border-radius: 15px;
            color: white;
            font-weight: 600;
        }

        .bg-in { background: #198754; }
        .bg-out { background: #dc3545; }
        .bg-qty { background: #0d6efd; }

        .table thead {
            background: #667eea;
            color: white;
        }
    </style>
</head>

<body>

<div class="container mt-4">

    <!-- Header -->
    <div class="page-header">
        <h3 class="mb-0">📑 Inventory Reports</h3>
        <small>Overall inventory analysis</small>
    </div>

    <!-- Summary Cards -->
    <div class="row g-4 mb-4">
        <div class="col-md-4">
            <div class="stat-card bg-in">
                <h4><%= totalIn %></h4>
                <p>Total Stock IN</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="stat-card bg-out">
                <h4><%= totalOut %></h4>
                <p>Total Stock OUT</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="stat-card bg-qty">
                <h4><%= totalQty %></h4>
                <p>Current Quantity</p>
            </div>
        </div>
    </div>

    <!-- Chart -->
    <div class="card-box mb-4">
        <h5 class="mb-3">Stock Overview</h5>
        <canvas id="stockChart" height="100"></canvas>
    </div>

    <!-- Report Table -->
    <div class="card-box">
        <h5 class="mb-3">Detailed Report</h5>

        <table class="table table-hover table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Product</th>
                    <th>Category</th>
                    <th>Total IN</th>
                    <th>Total OUT</th>
                    <th>Current Qty</th>
                </tr>
            </thead>
            <tbody>

            <% if (reports.isEmpty()) { %>
                <tr>
                    <td colspan="6" class="text-center text-muted">No report data available</td>
                </tr>
            <% } %>

            <% for(Report r : reports) { %>
                <tr>
                    <td><%=r.getProductId()%></td>
                    <td><%=r.getProductName()%></td>
                    <td><%=r.getCategoryName()%></td>
                    <td><%=r.getTotalIn()%></td>
                    <td><%=r.getTotalOut()%></td>
                    <td><%=r.getCurrentQuantity()%></td>
                </tr>
            <% } %>

            </tbody>
        </table>
    </div>

</div>

<!-- Chart Script -->
<script>
const ctx = document.getElementById('stockChart');

new Chart(ctx, {
    type: 'bar',
    data: {
        labels: [
            <% for(Report r : reports) { %>
                "<%= r.getProductName() %>",
            <% } %>
        ],
        datasets: [
            {
                label: 'Stock IN',
                data: [
                    <% for(Report r : reports) { %>
                        <%= r.getTotalIn() %>,
                    <% } %>
                ],
                backgroundColor: '#198754'
            },
            {
                label: 'Stock OUT',
                data: [
                    <% for(Report r : reports) { %>
                        <%= r.getTotalOut() %>,
                    <% } %>
                ],
                backgroundColor: '#dc3545'
            }
        ]
    },
    options: {
        responsive: true,
        plugins: {
            legend: {
                position: 'top'
            }
        }
    }
});
</script>

</body>
</html>
