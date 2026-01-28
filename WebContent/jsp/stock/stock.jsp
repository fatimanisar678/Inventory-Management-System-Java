<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*, model.*, dao.*" %>

<%
    List<Product> products = ProductDAO.getAllProducts();
    List<Stock> stockList = StockDAO.getAllStock();
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Stock Management</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

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
            padding: 25px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            margin-bottom: 25px;
        }

        .table thead {
            background: #667eea;
            color: white;
        }

        .badge-in {
            background-color: #198754;
        }

        .badge-out {
            background-color: #dc3545;
        }

        .btn-rounded {
            border-radius: 8px;
        }
    </style>
</head>

<body>

<div class="container mt-4">

    <!-- Header -->
    <div class="page-header">
        <h3 class="mb-0">📊 Stock Management</h3>
        <small>Stock In & Stock Out records</small>
    </div>

    <!-- Error Alert -->
    <% if ("1".equals(error)) { %>
        <div class="alert alert-danger">
            ⚠ Cannot remove more stock than available!
        </div>
    <% } %>

    <!-- Add Stock -->
    <div class="card-box">
        <h5 class="mb-3">Add Stock Entry</h5>

        <form action="<%=request.getContextPath()%>/StockServlet" method="post">
            <input type="hidden" name="action" value="add">

            <div class="row g-3">
                <div class="col-md-4">
                    <select name="product_id" class="form-select" required>
                        <option value="">Select product</option>
                        <% for(Product p : products) { %>
                            <option value="<%=p.getId()%>">
                                <%=p.getName()%> (Available: <%=p.getQuantity()%>)
                            </option>
                        <% } %>
                    </select>
                </div>

                <div class="col-md-3">
                    <select name="type" class="form-select" required>
                        <option value="">Stock type</option>
                        <option value="IN">Stock IN</option>
                        <option value="OUT">Stock OUT</option>
                    </select>
                </div>

                <div class="col-md-3">
                    <input type="number" name="quantity" class="form-control" placeholder="Quantity" required>
                </div>

                <div class="col-md-2 d-grid">
                    <button class="btn btn-success btn-rounded">➕ Add</button>
                </div>
            </div>
        </form>
    </div>

    <!-- Stock Table -->
    <div class="card-box">
        <h5 class="mb-3">Stock History</h5>

        <table class="table table-hover table-bordered">
            <thead>
                <tr>
                    <th width="5%">ID</th>
                    <th>Product</th>
                    <th width="10%">Type</th>
                    <th width="10%">Quantity</th>
                    <th width="20%">Date</th>
                </tr>
            </thead>
            <tbody>

            <% if(stockList.isEmpty()) { %>
                <tr>
                    <td colspan="5" class="text-center text-muted">No stock records found</td>
                </tr>
            <% } %>

            <% for(Stock s : stockList) { %>
                <tr>
                    <td><%=s.getId()%></td>
                    <td><%=s.getProductName()%></td>
                    <td>
                        <% if("IN".equals(s.getType())) { %>
                            <span class="badge badge-in">IN</span>
                        <% } else { %>
                            <span class="badge badge-out">OUT</span>
                        <% } %>
                    </td>
                    <td><%=s.getQuantity()%></td>
                    <td><%=s.getDate()%></td>
                </tr>
            <% } %>

            </tbody>
        </table>
    </div>

</div>

</body>
</html>
