package com.student.servlet;

import com.student.dao.StudentDAO;
import com.student.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

//@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    private StudentDAO studentDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String mobile = req.getParameter("mobile");
        String course = req.getParameter("course");

        // Simple validations
        if (name.isEmpty() || email.isEmpty() || password.isEmpty() || mobile.isEmpty() || course.isEmpty()) {
            resp.sendRedirect("signup.jsp?error=Please fill all fields");
            return;
        }

        // Email already exists?
        if (studentDAO.isEmailExists(email)) {
            resp.sendRedirect("signup.jsp?error=Email already registered");
            return;
        }

        Student student = new Student(name, email, password, mobile, course);

        if (studentDAO.addStudent(student)) {
            resp.sendRedirect("signup.jsp?success=Registration successful! Please login.");
        } else {
            resp.sendRedirect("signup.jsp?error=Failed to register. Try again.");
        }
    }
}
