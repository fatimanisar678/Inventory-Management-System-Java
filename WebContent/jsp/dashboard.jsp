<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sess = request.getSession(false);
    if (sess == null || sess.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String admin = (String) sess.getAttribute("admin");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: #f4f6fb;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            height: 100vh;
            position: fixed;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 20px;
        }

        .sidebar h4 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: 700;
        }

        .sidebar a {
            display: block;
            color: white;
            text-decoration: none;
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 10px;
            transition: background 0.3s;
        }

        .sidebar a:hover {
            background: rgba(255,255,255,0.2);
        }

        /* Main Content */
        .main-content {
            margin-left: 250px;
            padding: 30px;
        }

        .topbar {
            background: white;
            padding: 15px 25px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .dashboard-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }

        .dashboard-card h5 {
            font-weight: 600;
        }
    </style>
</head>

<body>

<!-- Sidebar -->
<div class="sidebar">
    <h4>Inventory System</h4>

    <a href="dashboard.jsp">🏠 Dashboard</a>
    <a href="product/list.jsp">📦 Products</a>
    <a href="<%=request.getContextPath()%>/jsp/category/list.jsp">📂 Categories</a>
    <a href="stock/stock.jsp">📊 Stock</a>
    <a href="<%=request.getContextPath()%>/report">📑 Reports</a>

    <hr class="text-white">
    <a href="<%=request.getContextPath()%>/logout">🚪 Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">

    <!-- Top Bar -->
    <div class="topbar">
        <h5 class="mb-0">Admin Dashboard</h5>
        <span>Welcome, <b><%= admin %></b></span>
    </div>

    <!-- Cards -->
    <div class="row g-4">

        <div class="col-md-3">
            <div class="card dashboard-card text-center">
                <div class="card-body">
                    <h5>Products</h5>
                    <p class="text-muted">Manage products</p>
                    <a href="product/list.jsp" class="btn btn-primary btn-sm">Open</a>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card dashboard-card text-center">
                <div class="card-body">
                    <h5>Categories</h5>
                    <p class="text-muted">Manage categories</p>
                    <a href="<%=request.getContextPath()%>/jsp/category/list.jsp" class="btn btn-success btn-sm">Open</a>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card dashboard-card text-center">
                <div class="card-body">
                    <h5>Stock</h5>
                    <p class="text-muted">Stock in / out</p>
                    <a href="stock/stock.jsp" class="btn btn-warning btn-sm">Open</a>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card dashboard-card text-center">
                <div class="card-body">
                    <h5>Reports</h5>
                    <p class="text-muted">Inventory reports</p>
                    <a href="<%=request.getContextPath()%>/report" class="btn btn-info btn-sm">Open</a>
                </div>
            </div>
        </div>

    </div>

</div>

</body>
</html>
