package me.slidingshadows.bookshelf.api.responses;

public class GetVersionResponse extends BaseResponse {
    private String product;
    private String version;

    public GetVersionResponse(String product, String version) {
        this.product = product;
        this.version = version;
    }

    public String getProduct() {
        return product;
    }

    public String getVersion() {
        return version;
    }
}
