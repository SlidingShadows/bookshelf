package me.slidingshadows.bookshelf.api.responses;

import java.util.ArrayList;
import java.util.List;

import javax.validation.ConstraintViolation;

public class BaseResponse {
    private Boolean succeeded;
    private List<Error> errors;

    public BaseResponse() {
        this.succeeded = true;
        this.errors = new ArrayList<Error>();
    }

    public List<Error> getErrors() {
        return errors;
    }

    public Boolean getSucceeded() {
        return succeeded;
    }

    public void addError(String code, String description) {
        this.errors.add(new Error(code, description));
        this.succeeded = false;
    }

    public void addError(ConstraintViolation<?> violation) {
        addError(violation.getPropertyPath().toString(), violation.getMessage());
    }
}
