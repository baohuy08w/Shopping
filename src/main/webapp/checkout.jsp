
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
</head>

<body>
    <h2>Checkout</h2>

    <p>Thank you for shopping with us!</p>
    <p>This is a demo checkout. No payment has been made.</p>

    <a href="<%= response.encodeURL(request.getContextPath() + "/cart") %>">
        Back to Cart
    </a>
</body>
</html>
