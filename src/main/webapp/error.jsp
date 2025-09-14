<%@ page isErrorPage="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #ffe6e6;
            padding: 20px;
        }
        .error-box {
            background-color: white;
            border: 1px solid #f5c6cb;
            padding: 2rem;
            border-radius: 8px;
            color: #721c24;
            max-width: 600px;
            margin: auto;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #dc3545;
        }
    </style>
</head>
<body>
    <div class="error-box">
        <h2>Error occurred</h2>
        <p>Status Code: <strong><%= pageContext.getErrorData().getStatusCode() %></strong></p>
        <p>Message: <strong><%= pageContext.getErrorData().getThrowable() != null ? pageContext.getErrorData().getThrowable().getMessage() : "Unknown Error" %></strong></p>
    </div>
</body>
</html>
