<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Sign Up</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f0f0f0;
            padding: 40px;
        }
        .form-container {
            background: white;
            padding: 30px;
            max-width: 400px;
            margin: auto;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            margin-bottom: 20px;
            text-align: center;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        .btn {
            width: 100%;
            padding: 12px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover {
            background: #0056b3;
        }
        .message {
            color: red;
            margin-bottom: 10px;
            text-align: center;
        }
        .success {
            color: green;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Student Sign Up</h2>

        <% if (request.getParameter("error") != null) { %>
            <div class="message"><%= request.getParameter("error") %></div>
        <% } else if (request.getParameter("success") != null) { %>
            <div class="message success"><%= request.getParameter("success") %></div>
        <% } %>

        <form method="post" action="signup">
            <label for="name">Name</label>
            <input type="text" name="name" required>

            <label for="email">Email</label>
            <input type="email" name="email" required>

            <label for="password">Password</label>
            <input type="password" name="password" required>

            <label for="mobile">Mobile</label>
            <input type="tel" name="mobile" maxlength="10" pattern="[0-9]{10}" required>

            <label for="course">Course</label>
            <input type="text" name="course" required>

            <button type="submit" class="btn">Register</button>
        </form>

        <p style="text-align:center; margin-top:10px;">Already have an account? <a href="login.html">Login</a></p>
    </div>
</body>
</html>
