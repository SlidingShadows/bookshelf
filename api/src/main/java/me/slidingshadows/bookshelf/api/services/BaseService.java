package me.slidingshadows.bookshelf.api.services;

import java.util.Set;

import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import me.slidingshadows.bookshelf.api.responses.BaseResponse;

import org.springframework.beans.factory.annotation.Autowired;

public class BaseService {

    @Autowired
    Validator validator;

    <R extends BaseResponse, T>
    void validate(R response, T request) {
        Set<ConstraintViolation<T>> violations = validator.validate(request);

        for (ConstraintViolation<T> violation : violations) {
            response.addError(violation);
        }
    }
}
