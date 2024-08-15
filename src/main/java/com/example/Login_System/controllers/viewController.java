package com.example.Login_System.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class viewController {

    @RequestMapping("/")
    public String showLogin(){
        return "index";
    }

    @RequestMapping("/newuser")
    public String registerNewUser(){
        return "register";
    }

}
