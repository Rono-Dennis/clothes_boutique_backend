package com.example.clothes_boutique_backend.api;


/*import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;*/
import lombok.Data;

@Entity
@Data
public class User {
    @Id
    @GeneratedValue
    Integer id;
    String fullName;
    String email;
    String password;


}
