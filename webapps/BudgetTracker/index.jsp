<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Budget Tracker</title>
    <link rel="stylesheet" href="css/style.css" />
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico">
</head>
<body>
<div class="container">
    <h1>Budget Tracker</h1>
    <form action="AddBudgetServlet" method="post">
        <input type="text" name="title" placeholder="Title" required />
        <input type="number" step="0.01" name="amount" placeholder="Amount" required />
        <textarea name="details" placeholder="Details" required></textarea>
        <button type="submit">Add Budget</button>
    </form>
    <hr/>
    <h2>All Budgets</h2>
    <table>
        <tr><th>Title</th><th>Amount</th><th>Details</th><th>Created At</th><th>Action</th></tr>
        <%
            try {
                Connection con = com.budget.DBConnection.getConnection();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM budgets");
                
                // Initialize the SimpleDateFormat to format the timestamp
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd; HH:mm:ss");

                while(rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("title") %></td>
            <td>৳<%= rs.getDouble("amount") %></td>
            <td><%= rs.getString("details") %></td>
            <td>
                <%
                    // Format the created_at timestamp to the required format
                    java.sql.Timestamp createdAt = rs.getTimestamp("created_at");
                    String formattedDate = (createdAt != null) ? dateFormat.format(createdAt) : "";
                    out.print(formattedDate);
                %>
            </td>
            <td>
                <a href="edit.jsp?id=<%= rs.getInt("id") %>">Edit</a> |
                <a href="DeleteBudgetServlet?id=<%= rs.getInt("id") %>">Delete</a>
            </td>
        </tr>
        <%
                }
                con.close();
            } catch(Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </table>
</div>
</body>
</html>
