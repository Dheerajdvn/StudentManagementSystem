<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.student.model.Student" %>

<%@ include file="WEB-INF/includes/session-check.jspf" %> <!-- ✅ Session check include -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <style>
        /* (CSS styles remain unchanged) */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .header {
            background-color: #007bff;
            color: white;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .btn {
            background-color: #28a745;
            color: white;
            padding: 0.5rem 1rem;
            text-decoration: none;
            border-radius: 4px;
            display: inline-block;
            margin-bottom: 1rem;
        }
        .btn:hover {
            background-color: #218838;
        }
        .btn-danger {
            background-color: #dc3545;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }
        .btn-warning:hover {
            background-color: #e0a800;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .actions {
            display: flex;
            gap: 0.5rem;
        }
        .actions a {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Student Dashboard</h1>
            <div>
                <span>Welcome, <%= loggedInStudent.getName() %>!</span>
                <a href="logout" class="btn btn-secondary" style="margin-left: 1rem;">Logout</a>
            </div>
        </div>

        <a href="student?action=add" class="btn">Add New Student</a>

        <% if (request.getAttribute("error") != null) { %>
            <div style="color: red; margin-bottom: 1rem;">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Mobile</th>
                    <th>Course</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Student> students = (List<Student>) request.getAttribute("students");
                    if (students != null && !students.isEmpty()) {
                        for (Student student : students) {
                %>
                <tr>
                    <td><%= student.getId() %></td>
                    <td><%= student.getName() %></td>
                    <td><%= student.getEmail() %></td>
                    <td><%= student.getMobile() %></td>
                    <td><%= student.getCourse() %></td>
                    <td class="actions">
                        <a href="student?action=edit&id=<%= student.getId() %>" class="btn btn-warning">Edit</a>
                        <a href="student?action=delete&id=<%= student.getId() %>" 
                           class="btn btn-danger" 
                           onclick="return confirm('Are you sure you want to delete this student?')">Delete</a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="6" style="text-align: center;">No students found</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
