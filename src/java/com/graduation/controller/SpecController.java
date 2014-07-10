package com.graduation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller

public class SpecController {
	
	@RequestMapping(value = "./appletindex", method = RequestMethod.GET)
    public String specviewapplet() {
        return "./appletindex";

    }
}
