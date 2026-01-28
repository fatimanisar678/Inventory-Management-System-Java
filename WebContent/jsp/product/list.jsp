<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*, model.*, dao.*" %>

<%
    List<Product> products = ProductDAO.getAllProducts();
    List<Category> categories = CategoryDAO.getAllCategories();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Product Management</title>

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

        .table td, .table th {
            vertical-align: middle;
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
        <h3 class="mb-0">📦 Product Management</h3>
        <small>Add, view and manage products</small>
    </div>

    <!-- Add Product -->
    <div class="card-box">
        <h5 class="mb-3">Add New Product</h5>

        <form action="<%=request.getContextPath()%>/ProductServlet" method="post">
            <input type="hidden" name="action" value="add">

            <div class="row g-3">
                <div class="col-md-3">
                    <input type="text" name="name" class="form-control" placeholder="Product name" required>
                </div>

                <div class="col-md-3">
                    <select name="category_id" class="form-select" required>
                        <option value="">Select category</option>
                        <% for(Category c : categories) { %>
                            <option value="<%=c.getId()%>"><%=c.getName()%></option>
                        <% } %>
                    </select>
                </div>

                <div class="col-md-2">
                    <input type="number" name="quantity" class="form-control" placeholder="Qty" required>
                </div>

                <div class="col-md-2">
                    <input type="number" step="0.01" name="price" class="form-control" placeholder="Price" required>
                </div>

                <div class="col-md-2 d-grid">
                    <button class="btn btn-success btn-rounded">➕ Add Product</button>
                </div>
            </div>
        </form>
    </div>

    <!-- Product Table -->
    <div class="card-box">
        <h5 class="mb-3">Product List</h5>

        <table class="table table-hover table-bordered">
            <thead>
                <tr>
                    <th width="5%">ID</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th width="10%">Qty</th>
                    <th width="10%">Price</th>
                    <th width="15%">Actions</th>
                </tr>
            </thead>
            <tbody>

            <% if(products.isEmpty()) { %>
                <tr>
                    <td colspan="6" class="text-center text-muted">No products found</td>
                </tr>
            <% } %>

            <% for(Product p : products) { %>
                <tr>
                    <td><%=p.getId()%></td>
                    <td><%=p.getName()%></td>
                    <td><%=p.getCategoryName()%></td>
                    <td><%=p.getQuantity()%></td>
                    <td>Rs. <%=p.getPrice()%></td>
                    <td>
                        <form action="<%=request.getContextPath()%>/ProductServlet"
                              method="post"
                              style="display:inline"
                              onsubmit="return confirm('Delete this product?');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%=p.getId()%>">
                            <button class="btn btn-danger btn-sm btn-rounded">🗑 Delete</button>
                        </form>
                    </td>
                </tr>
            <% } %>

            </tbody>
        </table>
    </div>

</div>

</body>
</html>
