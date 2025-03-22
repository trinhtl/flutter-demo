package com.crud.demo.model.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.springframework.lang.NonNull;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class UserRequest {
  @NotBlank(message = "First Name could not be empty")
  private String firstName;
  @NotBlank(message = "Last Name could not be empty")
  private String lastName;
  @NotBlank(message = "Email could not be empty")
  private String email;
  private String phoneNumber;
  private String zipCode;
}
