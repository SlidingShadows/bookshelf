package me.slidingshadows.bookshelf.api.validators;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

@Constraint(validatedBy = AuthenticatedValidator.class)
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface Authenticated {
    String message() default "{bookshelf.authenticated.username}";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
