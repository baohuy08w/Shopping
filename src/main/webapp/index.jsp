
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="murach.business.Product" %>
<%@ page import="java.util.Locale" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CD List</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 14px;
            margin: 20px;
        }

        h2 {
            color: teal;
        }

        table {
            border-collapse: collapse;
            width: 650px;
        }

        th, td {
            border: 1px solid gray;
            padding: 6px;
            text-align: left;
        }

        td:nth-child(2) {
            text-align: right;
        }

        form {
            margin: 0;
        }
    </style>
</head>

<body>

<h2>CD list</h2>

<table>
    <tr>
        <th>Description</th>
        <th>Price</th>
        <th></th>
    </tr>

    <% for (Product p : Product.getAllProducts()) { %>
    <tr>
        <td><%= p.getDescription() %></td>

        <td>
            <%= String.format(Locale.US, "$%.2f", p.getPrice()) %>
        </td>

        <td>
            <form action="<%= response.encodeURL(request.getContextPath() + "/cart") %>"
                  method="post">

                <input type="hidden"
                       name="action"
                       value="add">

                <input type="hidden"
                       name="productId"
                       value="<%= p.getId() %>">

                <button type="submit">Add To Cart</button>
            </form>
        </td>
    </tr>
    <% } %>
</table>

</body>
</html>
