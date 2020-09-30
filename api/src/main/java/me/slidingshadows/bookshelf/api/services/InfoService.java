package me.slidingshadows.bookshelf.api.services;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import me.slidingshadows.bookshelf.api.responses.GetVersionResponse;

@Service
public class InfoService {

    @Value("${bookshelf.build.product}")
    private String product;

    @Value("${bookshelf.build.version}")
    private String version;

    public GetVersionResponse getVersion() {
        return new GetVersionResponse(product, version);
    }
}
