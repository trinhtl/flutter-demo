package com.crud.demo.mapper;

import com.crud.demo.model.entity.User;
import com.crud.demo.model.request.UserRequest;
import com.crud.demo.model.response.UserResponse;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import org.mapstruct.NullValuePropertyMappingStrategy;
import org.mapstruct.factory.Mappers;

@Mapper(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface UserMapper {
  UserMapper INSTANCE = Mappers.getMapper(UserMapper.class);
  User toEntity(UserRequest request);
  void partialUpdate(@MappingTarget User user, UserRequest request);
  UserResponse toResponse(User user);
}
