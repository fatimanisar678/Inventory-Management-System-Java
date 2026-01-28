<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*, model.*, dao.*" %>

<%
    List<Category> categories = CategoryDAO.getAllCategories();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Category Management</title>

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
        <h3 class="mb-0">📂 Category Management</h3>
        <small>Manage product categories</small>
    </div>

    <!-- Add Category -->
    <div class="card-box mb-4">
        <h5 class="mb-3">Add New Category</h5>

        <form action="<%=request.getContextPath()%>/CategoryServlet" method="post">
            <input type="hidden" name="action" value="add">
            <div class="row g-2">
                <div class="col-md-10">
                    <input type="text" name="name" class="form-control" placeholder="Enter category name" required>
                </div>
                <div class="col-md-2 d-grid">
                    <button class="btn btn-success btn-rounded">➕ Add</button>
                </div>
            </div>
        </form>
    </div>

    <!-- Category Table -->
    <div class="card-box">
        <h5 class="mb-3">Category List</h5>

        <table class="table table-hover table-bordered">
            <thead>
                <tr>
                    <th width="10%">ID</th>
                    <th>Name</th>
                    <th width="25%">Actions</th>
                </tr>
            </thead>
            <tbody>
            <% if(categories.isEmpty()) { %>
                <tr>
                    <td colspan="3" class="text-center text-muted">No categories found</td>
                </tr>
            <% } %>

            <% for(Category c : categories) { %>
                <tr>
                    <td><%=c.getId()%></td>
                    <td><%=c.getName()%></td>
                    <td>
                        <!-- Edit -->
                        <a href="<%=request.getContextPath()%>/jsp/category/edit.jsp?id=<%=c.getId()%>"
                           class="btn btn-primary btn-sm btn-rounded">✏️ Edit</a>

                        <!-- Delete -->
                        <form action="<%=request.getContextPath()%>/CategoryServlet"
                              method="post"
                              style="display:inline"
                              onsubmit="return confirm('Are you sure you want to delete this category?');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%=c.getId()%>">
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
