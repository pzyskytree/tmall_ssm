package org.pzy.tmall.comparator;

import org.pzy.tmall.pojo.Product;

import java.util.Comparator;

public class ProductPriceComparator implements Comparator<Product> {
    @Override
    public int compare(Product p1, Product p2) {
        return p1.getPromotePrice() > p2.getPromotePrice() ? 1 : -1;
    }
}
