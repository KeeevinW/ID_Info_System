package com.example.ID_Info_System.services;

import com.example.ID_Info_System.model.User_Info;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.Map;

@Service
public class apiService {
    public String addNewUser(String apiUrl){

        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(apiUrl))
                .POST(HttpRequest.BodyPublishers.noBody())
                .build();
        try{
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() == 200) {
                String responseBody = response.body();
                return responseBody;
            } else {
                return "Error: " + response.statusCode();
            }
        } catch (IOException | InterruptedException e) {
            return e.getMessage();
        }

    }

    public Map<String, String> getInfoByName(String apiUrl){

        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(apiUrl))
                .build();
        try{
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() == 200) {
                ObjectMapper mapper = new ObjectMapper();
                Map<String, String> responseBody = mapper.readValue(response.body(), Map.class);
                return responseBody;
            } else {
                throw new RuntimeException("Failed: HTTP error code : " + response.statusCode());
            }
        } catch (IOException | InterruptedException e) {
            throw new RuntimeException("Request failed", e);
        }

    }

    public ArrayList<User_Info> getAllInfo(String apiUrl){
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(apiUrl))
                .build();
        try{
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() == 200) {
                ObjectMapper mapper = new ObjectMapper();
                ArrayList<User_Info> responseBody = mapper.readValue(response.body(), ArrayList.class);
                return responseBody;
            } else {
                throw new RuntimeException("Failed: HTTP error code : " + response.statusCode());
            }
        } catch (IOException | InterruptedException e) {
            throw new RuntimeException("Request failed", e);
        }
    }
}
