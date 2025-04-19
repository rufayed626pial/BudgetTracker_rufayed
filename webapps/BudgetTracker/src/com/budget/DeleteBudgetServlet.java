package com.budget;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class DeleteBudgetServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM budgets WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            con.close();
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            throw new ServletException("DB error", e);
        }
    }
}