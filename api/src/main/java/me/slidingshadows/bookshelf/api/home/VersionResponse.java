package me.slidingshadows.bookshelf.api.home;

public class VersionResponse {
    private String product;
    private String version;

    public VersionResponse(String product, String version) {
        this.product = product;
        this.version = version;
    }

    public String getProduct () {
        return product;
    }

    public String getVersion() {
        return version;
    }
}
