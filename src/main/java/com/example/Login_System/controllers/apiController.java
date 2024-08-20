package com.example.Login_System.controllers;

import com.example.Login_System.model.User;
import com.example.Login_System.services.loginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RequestMapping("/api")
@RestController
public class apiController {

    @Autowired
    private loginService loginService;

    @PostMapping("/newuser")
    public ResponseEntity<String> registerNewUser(@RequestBody User user) {

        String password = user.getPassword();
        String username = user.getUsername();
        String phoneNum = user.getPhoneNum();
        String ID = user.getId();

        String result = loginService.registerNewUser(phoneNum, username, password, ID);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }


    @PostMapping("/login")
    public ResponseEntity<String> LoginToAccount(@RequestBody User user){

        String password = user.getPassword();
        String username = user.getUsername(); //not necessarily the username, could be the phone number

        if(loginService.LoginToAccount(username, password)){ // username and password are correct
            if(loginService.isAdmin(username)){ //check if the User is an admin
                return new ResponseEntity<>("log in to admin account", HttpStatus.OK);
            }else{
                return new ResponseEntity<>("log in to normal account", HttpStatus.OK);
            }
        }else{
            return new ResponseEntity<>("incorrect username or password", HttpStatus.UNAUTHORIZED);
        }

    }

    @GetMapping("/getname/{name}")
    public ResponseEntity<String> getName(@PathVariable String name){
        return new ResponseEntity<>(loginService.getUsername(name), HttpStatus.OK);
    }

    @GetMapping("/getInfo/{username}")
    public ResponseEntity<Map<String, String>> getInfoByName(@PathVariable String username){
        return new ResponseEntity<>(loginService.getInfoByName(username), HttpStatus.OK);
    }


}
