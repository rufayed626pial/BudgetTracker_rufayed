package com.budget;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class EditBudgetServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        double amount = Double.parseDouble(request.getParameter("amount"));
        String details = request.getParameter("details");
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE budgets SET title=?, amount=?, details=? WHERE id=?");
            ps.setString(1, title);
            ps.setDouble(2, amount);
            ps.setString(3, details);
            ps.setInt(4, id);
            ps.executeUpdate();
            con.close();
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            throw new ServletException("DB error", e);
        }
    }
}