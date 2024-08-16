package com.example.Login_System.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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

    @RequestMapping("/mainPage")
    public String mainPage(Model model, @RequestParam String username){
        model.addAttribute("username", username);
        return "mainPage";
    }

    @RequestMapping("/adminPage")
    public String adminPage(Model model, @RequestParam String username){
        model.addAttribute("username", username);
        return "adminPage";
    }

}
