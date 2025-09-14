<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.student.model.Student" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Student</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 1rem;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        input[type="text"], input[type="email"], input[type="password"], input[type="tel"] {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-right: 1rem;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .message {
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        h2 {
            margin-bottom: 1.5rem;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Student</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="message error"><%= request.getAttribute("error") %></div>
        <% } else if (request.getAttribute("success") != null) { %>
            <div class="message success"><%= request.getAttribute("success") %></div>
        <% } %>

        <%
            Student student = (Student) request.getAttribute("student");
            if (student != null) {
        %>
        <form action="student" method="post" autocomplete="off">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= student.getId() %>">

            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="<%= student.getName() %>" maxlength="50" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= student.getEmail() %>" maxlength="100" required>
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" value="<%= student.getPassword() %>" maxlength="50" required>
            </div>

            <div class="form-group">
                <label for="mobile">Mobile:</label>
                <input type="tel" id="mobile" name="mobile" value="<%= student.getMobile() %>" maxlength="10" pattern="[0-9]{10}" required>
            </div>

            <div class="form-group">
                <label for="course">Course:</label>
                <input type="text" id="course" name="course" value="<%= student.getCourse() %>" maxlength="100" required>
            </div>

            <button type="submit" class="btn">Update Student</button>
            <a href="dashboard" class="btn btn-secondary">Cancel</a>
        </form>
        <% } else { %>
            <div class="message error">Student not found!</div>
            <a href="dashboard" class="btn btn-secondary">Back to Dashboard</a>
        <% } %>
    </div>
</body>
</html>
