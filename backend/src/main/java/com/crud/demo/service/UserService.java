package com.crud.demo.service;

import com.crud.demo.model.request.UserRequest;
import com.crud.demo.model.request.QueryUserRequest;
import com.crud.demo.model.response.UserResponse;
import org.springframework.data.domain.Page;

public interface UserService {
  Long create(UserRequest request);
  Long update(Long id, UserRequest request);
  void remove(Long id);
  UserResponse detail(Long id);
  Page<UserResponse> list(QueryUserRequest request);
}
