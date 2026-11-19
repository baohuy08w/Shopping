
package murach.business;

import java.io.Serializable;
import java.util.ArrayList;

public class Cart implements Serializable {

    private static final long serialVersionUID = 1L;

    private ArrayList<LineItem> items = new ArrayList<>();

    public Cart() {
    }

    public synchronized ArrayList<LineItem> getItems() {
        ArrayList<LineItem> copy = new ArrayList<>();

        for (LineItem item : items) {
            copy.add(new LineItem(
                    item.getProduct(),
                    item.getQuantity()
            ));
        }

        return copy;
    }

    public synchronized void addItem(Product product) {

        if (product == null) {
            return;
        }

        for (LineItem item : items) {
            if (item.getProduct().getId().equals(product.getId())) {

                if (item.getQuantity() < 10000) {
                    item.setQuantity(item.getQuantity() + 1);
                }
                return;
            }
        }

        items.add(new LineItem(product, 1));
    }

    public synchronized void updateItem(String productId,
                                        int quantity) {

        for (LineItem item : items) {
            if (item.getProduct().getId().equals(productId)) {

                if (quantity <= 0) {
                    items.remove(item);
                } else if (quantity <= 10000) {
                    item.setQuantity(quantity);
                }

                return;
            }
        }
    }

    public synchronized void removeItem(String productId) {
        items.removeIf(item ->
                item.getProduct().getId().equals(productId));
    }

    public synchronized double getTotal() {
        double total = 0;

        for (LineItem item : items) {
            total += item.getAmount();
        }

        return total;
    }
}
