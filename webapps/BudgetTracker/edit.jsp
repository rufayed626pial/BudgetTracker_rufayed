<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String title = "", details = "";
    double amount = 0;
    try {
        Connection con = com.budget.DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM budgets WHERE id=?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            title = rs.getString("title");
            amount = rs.getDouble("amount");
            details = rs.getString("details");
        }
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
<html>
<head>
    <title>Edit Budget</title>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body>
<div class="container">
    <h1>Edit Budget</h1>
    <form action="EditBudgetServlet" method="post">
        <input type="hidden" name="id" value="<%= id %>" />
        <input type="text" name="title" value="<%= title %>" required />
        <input type="number" step="0.01" name="amount" value="<%= amount %>" required />
        <textarea name="details" required><%= details %></textarea>
        <button type="submit">Update</button>
    </form>
</div>
</body>
</html>