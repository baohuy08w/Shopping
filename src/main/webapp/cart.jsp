
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Locale" %>
<%@ page import="murach.business.LineItem" %>

<%
    ArrayList<LineItem> items =
        (ArrayList<LineItem>) request.getAttribute("items");

    if (items == null) {
        response.sendRedirect(
            response.encodeRedirectURL(
                request.getContextPath() + "/cart"
            )
        );
        return;
    }

    String cartUrl = response.encodeURL(
        request.getContextPath() + "/cart"
    );
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your cart</title>

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
            width: 720px;
        }

        th, td {
            border: 1px solid gray;
            padding: 6px;
            text-align: left;
        }

        td:nth-child(3),
        td:nth-child(4) {
            text-align: right;
        }

        input[type="number"] {
            width: 48px;
        }

        form {
            margin: 0;
        }

        .actions {
            margin-top: 14px;
        }

        .actions a {
            display: block;
            width: fit-content;
            margin-bottom: 8px;
            padding: 3px 8px;
            background: #eeeeee;
            border: 1px solid gray;
            color: black;
            text-decoration: none;
        }
    </style>
</head>

<body>

<h2>Your cart</h2>

<table>
    <tr>
        <th>Quantity</th>
        <th>Description</th>
        <th>Price</th>
        <th>Amount</th>
        <th></th>
    </tr>

    <% for (LineItem item : items) { %>
    <tr>
        <td>
            <form action="<%= cartUrl %>" method="post">

                <input type="hidden"
                       name="action"
                       value="update">

                <input type="hidden"
                       name="productId"
                       value="<%= item.getProduct().getId() %>">

                <input type="number"
                       name="quantity"
                       min="0"
                       max="10000"
                       value="<%= item.getQuantity() %>"
                       required>

                <button type="submit">Update</button>
            </form>
        </td>

        <td><%= item.getProduct().getDescription() %></td>

        <td>
            <%= String.format(Locale.US, "$%.2f",
                    item.getProduct().getPrice()) %>
        </td>

        <td>
            <%= String.format(Locale.US, "$%.2f",
                    item.getAmount()) %>
        </td>

        <td>
            <form action="<%= cartUrl %>" method="post">

                <input type="hidden"
                       name="action"
                       value="remove">

                <input type="hidden"
                       name="productId"
                       value="<%= item.getProduct().getId() %>">

                <button type="submit">Remove Item</button>
            </form>
        </td>
    </tr>
    <% } %>
</table>

<% if (items.isEmpty()) { %>
    <p>Your cart is empty.</p>
<% } %>

<p>
    To change the quantity, enter the new quantity
    and click on the Update button.
</p>

<div class="actions">
    <a href="<%= response.encodeURL(request.getContextPath() + "/index.jsp") %>">
        Continue Shopping
    </a>

    <a href="<%= response.encodeURL(request.getContextPath() + "/checkout.jsp") %>">
        Checkout
    </a>
</div>

</body>
</html>
