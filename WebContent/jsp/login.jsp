<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-card {
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            padding: 40px 30px;
            width: 100%;
            max-width: 400px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
        }

        .login-card h3 {
            text-align: center;
            font-weight: 700;
            margin-bottom: 30px;
            color: #333;
        }

        .form-control {
            border-radius: 10px;
            padding: 10px 15px;
            font-size: 16px;
        }

        .btn-login {
            border-radius: 10px;
            padding: 10px;
            font-weight: 500;
            font-size: 16px;
            transition: background 0.3s ease;
            background:#7355b0;
        }

        .btn-login:hover {
            background: #5a67d8;
        }

        .login-footer {
            text-align: center;
            margin-top: 20px;
        }

        .login-footer a {
            text-decoration: none;
            color: #764ba2;
            font-weight: 500;
        }

        .login-footer a:hover {
            text-decoration: underline;
        }

        .alert-msg {
            margin-top: 15px;
            text-align: center;
            font-weight: 500;
        }

    </style>
</head>
<body>

<div class="login-card">
    <h3>Login</h3>

    <form action="<%=request.getContextPath()%>/admin" method="post">
        <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" name="username" class="form-control" placeholder="Enter your username" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
        </div>

        <button class="btn btn-primary w-100 btn-login">Login</button>
    </form>

    <div class="login-footer">
        <span>Don't have an account? </span>
        <a href="<%=request.getContextPath()%>/jsp/signup.jsp">Sign Up</a>
    </div>

    <% if (request.getParameter("signup") != null) { %>
        <p class="alert-msg text-success">Signup successful! Please login.</p>
    <% } else if (request.getParameter("error") != null) { %>
        <p class="alert-msg text-danger">Invalid username or password!</p>
    <% } %>
</div>

</body>
</html>
