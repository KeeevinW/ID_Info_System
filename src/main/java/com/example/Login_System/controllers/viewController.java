package com.example.Login_System.controllers;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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

    @GetMapping("/normalLogin")
    public String handleNormalLogin(@RequestParam String username, HttpSession session) {
        session.setAttribute("username", username);
        return "redirect:/mainPage";
    }

    @GetMapping("/adminLogin")
    public String handleAdminLogin(@RequestParam String username, HttpSession session) {
        session.setAttribute("username", username);
        return "redirect:/adminPage";
    }

    @RequestMapping("/mainPage")
    public String mainPage(HttpSession session, Model model){
        String username = (String) session.getAttribute("username");
        if (username == null || username.isEmpty()) {
            // Redirect to the login page if the user is not authenticated
            return "redirect:/";
        }
        model.addAttribute("username", username);
        return "mainPage";
    }

    @RequestMapping("/adminPage")
    public String adminPage(HttpSession session, Model model){
        String username = (String) session.getAttribute("username");
        if (username == null || username.isEmpty()) {
            // Redirect to the login page if the user is not authenticated
            return "redirect:/";
        }
        model.addAttribute("username", username);
        return "adminPage";
    }

}
