
package murach.business;

import java.io.Serializable;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;
    private String description;
    private double price;

    private static final Map<String, Product> products =
            new LinkedHashMap<>();

    static {
        addProduct(new Product(
                "8601",
                "86 (the band) - True Life Songs and Pictures",
                14.95
        ));

        addProduct(new Product(
                "PF01",
                "Paddlefoot - The first CD",
                12.95
        ));

        addProduct(new Product(
                "PF02",
                "Paddlefoot - The second CD",
                14.95
        ));

        addProduct(new Product(
                "JR01",
                "Joe Rut - Genuine Wood Grained Finish",
                14.95
        ));
    }

    public Product(String id, String description, double price) {
        this.id = id;
        this.description = description;
        this.price = price;
    }

    private static void addProduct(Product product) {
        products.put(product.getId(), product);
    }

    public static Product findById(String id) {
        return products.get(id);
    }

    public static Collection<Product> getAllProducts() {
        return java.util.Collections.unmodifiableCollection(
                products.values()
        );
    }

    public String getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public double getPrice() {
        return price;
    }
}
