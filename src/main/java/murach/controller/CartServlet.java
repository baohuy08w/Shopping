
package murach.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import murach.business.Cart;
import murach.business.Product;

import java.io.IOException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private Cart getCart(HttpSession session) {
        synchronized (session) {
            Cart cart = (Cart) session.getAttribute("cart");

            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }

            return cart;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        Cart cart = getCart(request.getSession());

        request.setAttribute("items", cart.getItems());

        request.getRequestDispatcher("/cart.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String productId = request.getParameter("productId");

        Product product = Product.findById(productId);

        if (product == null) {
            response.sendError(400, "Invalid product");
            return;
        }

        Cart cart = getCart(request.getSession());

        if ("add".equals(action)) {

            cart.addItem(product);

        } else if ("update".equals(action)) {

            try {
                int quantity = Integer.parseInt(
                        request.getParameter("quantity")
                );

                if (quantity < 0 || quantity > 10000) {
                    response.sendError(400, "Invalid quantity");
                    return;
                }

                cart.updateItem(productId, quantity);

            } catch (NumberFormatException e) {
                response.sendError(400, "Invalid quantity");
                return;
            }

        } else if ("remove".equals(action)) {

            cart.removeItem(productId);

        } else {
            response.sendError(400, "Invalid action");
            return;
        }

        String url = request.getContextPath() + "/cart";
        response.sendRedirect(response.encodeRedirectURL(url));
    }
}
