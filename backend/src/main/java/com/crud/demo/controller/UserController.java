package com.crud.demo.controller;

import com.crud.demo.model.request.UserRequest;
import com.crud.demo.model.request.QueryUserRequest;
import com.crud.demo.model.response.UserResponse;
import com.crud.demo.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/users")
@RequiredArgsConstructor
public class UserController {
  private final UserService userService;

  @GetMapping("list")
  public ResponseEntity<Page<UserResponse>> getList(@RequestParam(required = false) String key, @RequestParam(required = false, defaultValue = "0") Integer page, @RequestParam(required = false, defaultValue = "20") Integer size) {
    return ResponseEntity.ok(userService.list(QueryUserRequest.builder()
        .key(key)
        .page(page)
        .size(size)
        .build()));
  }

  @GetMapping("/{id}")
  public ResponseEntity<UserResponse> detail(@PathVariable Long id) {
    return ResponseEntity.ok(userService.detail(id));
  }

  @PostMapping
  public ResponseEntity<Long> create(@Valid @RequestBody UserRequest request) {
    return ResponseEntity.ok(userService.create(request));
  }

  @PutMapping("/{id}")
  public ResponseEntity<Long> update(@PathVariable Long id, @Valid @RequestBody UserRequest request) {
    return ResponseEntity.ok(userService.update(id, request));
  }

  @DeleteMapping("/{id}")
  public ResponseEntity<Void> remove(@PathVariable Long id) {
    userService.remove(id);
    return ResponseEntity.status(HttpStatus.OK).build();
  }
}
