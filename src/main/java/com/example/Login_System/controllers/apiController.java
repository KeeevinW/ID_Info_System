package com.example.Login_System.controllers;

import com.example.Login_System.model.user;
import com.example.Login_System.services.loginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api")
@RestController
public class apiController {

    @Autowired
    private loginService loginService;

    @PostMapping("/newuser")
    public ResponseEntity<String> registerNewUser(@RequestBody user user) {
        String password = user.getPassword();
        String username = user.getUsername();
        String result = loginService.registerNewUser(username, password);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @PostMapping("/login")
    public ResponseEntity<String> LoginToAccount(@RequestBody user user){

        String password = user.getPassword();
        String username = user.getUsername();

        if(loginService.LoginToAccount(username, password)){ // username and password are correct
            if(loginService.isAdmin(username)){ //check if the user is an admin
                return new ResponseEntity<>("log in to admin account", HttpStatus.OK);
            }else{
                return new ResponseEntity<>("log in to normal account", HttpStatus.OK);
            }
        }else{
            return new ResponseEntity<>("incorrect username or password", HttpStatus.UNAUTHORIZED);
        }

    }



}
