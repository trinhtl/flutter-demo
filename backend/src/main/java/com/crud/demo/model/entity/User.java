package com.crud.demo.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;
import java.time.LocalDateTime;

@Entity
@Table(name = "\"user\"")
@Getter
@Setter
@RequiredArgsConstructor
public class User {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  @Column(name = "first_name", nullable = false)
  private String firstName;
  @Column(name = "last_name", nullable = false)
  private String lastName;
  @Column(name = "email", nullable = false)
  private String email;
  @Column(name = "phone_number")
  private String phoneNumber;
  @Column(name = "zip_code")
  private String zipCode;
  @Column(name = "created_date", columnDefinition = "timestamp default current_timestamp")
  private LocalDateTime createdDate;
  @Column(name = "created_by")
  private String createdBy;
  @Column(name = "modified_date", columnDefinition = "timestamp default current_timestamp")
  private LocalDateTime modifiedDate;
  @Column(name = "modified_by")
  private String modifiedBy;
}
