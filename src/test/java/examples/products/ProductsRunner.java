package examples.products;

import com.intuit.karate.junit5.Karate;

class ProductsRunner {
    @Karate.Test
    Karate testAllProducts() {
        return Karate.run("get-all-products").relativeTo(getClass());
    }
}
