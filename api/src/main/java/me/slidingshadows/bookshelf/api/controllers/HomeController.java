package me.slidingshadows.bookshelf.api.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import me.slidingshadows.bookshelf.api.responses.GetVersionResponse;
import me.slidingshadows.bookshelf.api.services.InfoService;

@RestController
public class HomeController {
    
    @Autowired
    InfoService infoService;

    @GetMapping("/")
    public GetVersionResponse getVersion() {
        return infoService.getVersion();
    }
}
