package com.student.servlet;

import com.student.dao.StudentDAO;
import com.student.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class StudentServlet extends HttpServlet {
    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("dashboard");
            return;
        }

        switch (action) {
            case "add":
                request.getRequestDispatcher("/add-student.jsp").forward(request, response);
                break;

            case "edit":
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Student student = studentDAO.getStudentById(id);
                    if (student != null) {
                        request.setAttribute("student", student);
                        request.getRequestDispatcher("/edit-student.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("dashboard?error=Student not found");
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect("dashboard?error=Invalid student ID");
                }
                break;

            case "delete":
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    if (studentDAO.deleteStudent(id)) {
                        response.sendRedirect("dashboard?success=Student deleted successfully");
                    } else {
                        response.sendRedirect("dashboard?error=Failed to delete student");
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect("dashboard?error=Invalid student ID");
                }
                break;

            default:
                response.sendRedirect("dashboard");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addStudent(request, response);
        } else if ("update".equals(action)) {
            updateStudent(request, response);
        } else {
            response.sendRedirect("dashboard");
        }
    }

    private void addStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String mobile = request.getParameter("mobile");
        String course = request.getParameter("course");

        if (name == null || email == null || password == null ||
            mobile == null || course == null ||
            name.trim().isEmpty() || email.trim().isEmpty() ||
            password.trim().isEmpty() || mobile.trim().isEmpty() ||
            course.trim().isEmpty()) {
            response.sendRedirect("student?action=add&error=Please fill all fields");
            return;
        }

        if (studentDAO.isEmailExists(email)) {
            response.sendRedirect("student?action=add&error=Email already exists");
            return;
        }

        Student student = new Student(name, email, password, mobile, course);

        if (studentDAO.addStudent(student)) {
            response.sendRedirect("dashboard?success=Student added successfully");
        } else {
            response.sendRedirect("student?action=add&error=Failed to add student");
        }
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String mobile = request.getParameter("mobile");
            String course = request.getParameter("course");

            if (name == null || email == null || password == null ||
                mobile == null || course == null ||
                name.trim().isEmpty() || email.trim().isEmpty() ||
                password.trim().isEmpty() || mobile.trim().isEmpty() ||
                course.trim().isEmpty()) {
                response.sendRedirect("student?action=edit&id=" + id + "&error=Please fill all fields");
                return;
            }

            Student student = new Student(id, name, email, password, mobile, course);

            if (studentDAO.updateStudent(student)) {
                response.sendRedirect("dashboard?success=Student updated successfully");
            } else {
                response.sendRedirect("student?action=edit&id=" + id + "&error=Failed to update student");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("dashboard?error=Invalid student ID");
        }
    }
}
