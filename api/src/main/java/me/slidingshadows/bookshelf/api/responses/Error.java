package me.slidingshadows.bookshelf.api.responses;

public class Error {
    private String code;
    private String description;

    public Error(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public String getCode() {
        return code;
    }
}
