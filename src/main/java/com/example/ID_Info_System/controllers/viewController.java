package com.example.ID_Info_System.controllers;

import com.example.ID_Info_System.model.User;
import com.example.ID_Info_System.model.User_Info;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
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

import java.util.ArrayList;
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
        String apiUrl = "http://localhost:8081/api/getname/" + username;
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        HttpEntity<String> requestEntity = new HttpEntity<>(headers);
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
            // Redirect to the login page if the User is not authenticated
            return "redirect:/";
        }

        String apiUrl = "http://localhost:8081/api/getInfo/";

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(headers);
        HttpEntity<Map<String, String>> response = restTemplate.exchange(apiUrl + username, HttpMethod.GET, requestEntity, new ParameterizedTypeReference<Map<String, String>>() {});

        model.addAttribute("username", username);
        model.addAttribute("response", response.getBody());
        return "mainPage";
    }


    @RequestMapping("/adminPage")
    public String adminPage(HttpSession session, Model model){
        String adminName = (String) session.getAttribute("username");
        if (adminName == null || adminName.isEmpty()) {
            // Redirect to the login page if the User is not authenticated
            return "redirect:/";
        }

        String apiUrl = "http://localhost:8081/api/getAll";
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        HttpEntity<ArrayList<User>> requestEntity = new HttpEntity<>(headers);
        HttpEntity<ArrayList<User>> response = restTemplate.exchange(apiUrl, HttpMethod.GET, requestEntity, new ParameterizedTypeReference<ArrayList<User>>() {});
        model.addAttribute("Users", response.getBody());

        //get address and other information of the users
        apiUrl = "http://localhost:8081/api/getAllInfo";
        headers = new HttpHeaders();
        HttpEntity<ArrayList<User_Info>> requestEntityForInfo = new HttpEntity<>(headers);
        HttpEntity<ArrayList<User_Info>> responseForInfo = restTemplate.exchange(apiUrl, HttpMethod.GET, requestEntityForInfo, new ParameterizedTypeReference<ArrayList<User_Info>>() {});

        model.addAttribute("userInfo", responseForInfo.getBody());

        model.addAttribute("adminName", adminName);
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
