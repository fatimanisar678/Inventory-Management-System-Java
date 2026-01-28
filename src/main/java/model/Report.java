package model;

public class Report {

    private int productId;
    private String productName;
    private String categoryName;
    private int totalIn;
    private int totalOut;
    private int currentQuantity;

    // Getters & Setters
    public int getProductId() {
        return productId;
    }
    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getCategoryName() {
        return categoryName;
    }
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getTotalIn() {
        return totalIn;
    }
    public void setTotalIn(int totalIn) {
        this.totalIn = totalIn;
    }

    public int getTotalOut() {
        return totalOut;
    }
    public void setTotalOut(int totalOut) {
        this.totalOut = totalOut;
    }

    public int getCurrentQuantity() {
        return currentQuantity;
    }
    public void setCurrentQuantity(int currentQuantity) {
        this.currentQuantity = currentQuantity;
    }
}
