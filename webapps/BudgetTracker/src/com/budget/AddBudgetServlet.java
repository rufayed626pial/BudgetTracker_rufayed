package com.budget;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class AddBudgetServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String amount = request.getParameter("amount");
        String details = request.getParameter("details");
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO budgets (title, amount, details) VALUES (?, ?, ?)");
            ps.setString(1, title);
            ps.setDouble(2, Double.parseDouble(amount));
            ps.setString(3, details);
            ps.executeUpdate();
            con.close();
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            throw new ServletException("DB error", e);
        }
    }
}