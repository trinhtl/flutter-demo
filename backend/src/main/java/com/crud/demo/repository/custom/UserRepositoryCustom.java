package com.crud.demo.repository.custom;

import com.crud.demo.model.request.QueryUserRequest;
import com.crud.demo.model.response.UserResponse;

import java.util.List;

public interface UserRepositoryCustom {
  public List<UserResponse> filter(QueryUserRequest request);
  public Long count(QueryUserRequest request);

}
