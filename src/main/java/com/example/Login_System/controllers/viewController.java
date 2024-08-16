package com.example.Login_System.controllers;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;

@Controller
public class viewController {

    @Autowired
    private RestTemplate restTemplate;

    @RequestMapping("/")
    public String showLogin(){
        return "index";
    }

    @RequestMapping("/newuser")
    public String registerNewUser(){
        return "register";
    }

    private void getRealName(@RequestParam String username, HttpSession session) {
        String apiUrl = "http://localhost:8080/api/getname?name=" + username;
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(headers);
        HttpEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.GET, requestEntity, String.class);
        String result = response.getBody();
        session.setAttribute("username", result);
    }

    @GetMapping("/normalLogin")
    public String handleNormalLogin(@RequestParam String username, HttpSession session) {
        getRealName(username, session);
        return "redirect:/mainPage";
    }

    @GetMapping("/adminLogin")
    public String handleAdminLogin(@RequestParam String username, HttpSession session) {
        getRealName(username, session);
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

    @RequestMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        // Invalidate the session to clear all attributes, including the username
        session.invalidate();
        redirectAttributes.addFlashAttribute("logoutSuccess", true); // Pass the logout success flag
        // Redirect to the login page after logout
        return "redirect:/";
    }

}
