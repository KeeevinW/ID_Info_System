package com.example.ID_Info_System.controllers;

import com.example.ID_Info_System.model.User;
import com.example.ID_Info_System.model.User_Info;
import com.example.ID_Info_System.services.loginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
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

        String result = loginService.LoginToAccount(username, password);

        if(result.equals("Successfully logged in")){ // username and password are correct
            if(loginService.isAdmin(username)){ //check if the User is an admin
                return new ResponseEntity<>("log in to admin account", HttpStatus.OK);
            }else{
                return new ResponseEntity<>("log in to normal account", HttpStatus.OK);
            }
        }else if(result.equals("There are more than one password")){
            return new ResponseEntity<>("There are more than one password", HttpStatus.OK);
        }else{
            return new ResponseEntity<>("incorrect username or password", HttpStatus.UNAUTHORIZED);
        }

    }

    @GetMapping("/getname/{name}")
    public ResponseEntity<String> getName(@PathVariable String name){
        return new ResponseEntity<>(loginService.getUsername(name), HttpStatus.OK);
    }

    @GetMapping("/getInfo/{nameOrPhoneNum}")
    public ResponseEntity<Map<String, String>> getInfoByName(@PathVariable String nameOrPhoneNum){
        return new ResponseEntity<>(loginService.getInfoByName(nameOrPhoneNum), HttpStatus.OK);
    }

    @PutMapping("/makeAdmin")
    public ResponseEntity<String> makeAdmin(@RequestBody String username){
        loginService.makeAdmin(username);
        return new ResponseEntity<>("admin maked", HttpStatus.OK);
    }

    @GetMapping("/getAll")
    public ResponseEntity<ArrayList<User>> getAll(){
        return new ResponseEntity<>(loginService.getAll(), HttpStatus.OK);
    }

    @GetMapping("/getAllInfo")
    public ResponseEntity<ArrayList<User_Info>> getAllInfo(){
        return new ResponseEntity<>(loginService.getAllInfo(), HttpStatus.OK);
    }

    @PutMapping("/resetPassword")
    public ResponseEntity<String> resetPassword(@RequestParam String phoneNum){
        loginService.resetPassword(phoneNum);
        return new ResponseEntity<>("password reset", HttpStatus.OK);
    }

    @PutMapping("/setPassword")
    public ResponseEntity<String> setPassword(@RequestParam String nameOrPhone, @RequestParam String password){
        loginService.setPassword(nameOrPhone, password);
        return new ResponseEntity<>("password set", HttpStatus.OK);
    }

    @DeleteMapping("/deleteUser")
    public ResponseEntity<String> deleteUser(@RequestParam String phoneNum){
        loginService.deleteUser(phoneNum);
        return new ResponseEntity<>("User deleted", HttpStatus.OK);
    }

    @PutMapping("/updateUser")
    public ResponseEntity<String> updateUser(@RequestParam String phoneNum, @RequestParam String username, @RequestParam String password, @RequestParam String ID, @RequestParam Boolean isAdmin){
        String result = loginService.updateUser(phoneNum, username, password, ID, isAdmin);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }
}
