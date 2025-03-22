package com.crud.demo.service.impl;

import com.crud.demo.mapper.UserMapper;
import com.crud.demo.model.entity.User;
import com.crud.demo.model.request.UserRequest;
import com.crud.demo.model.request.QueryUserRequest;
import com.crud.demo.model.response.UserResponse;
import com.crud.demo.repository.UserRepository;
import com.crud.demo.service.UserService;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validator;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import java.util.Optional;
import java.util.Set;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService {
  private final UserRepository userRepository;
  private final Validator validator;
  private final ZoneId zoneId = ZoneId.of("Asia/Ho_Chi_Minh");
  @Override
  @Transactional
  @SneakyThrows
  public Long create(UserRequest request) {
    log.info("Create user with request {}", request.toString());
    Set<ConstraintViolation<UserRequest>> validated = validator.validate(request);
    User user = UserMapper.INSTANCE.toEntity(request);
    user.setCreatedDate(LocalDateTime.now(zoneId));
    user.setModifiedDate(LocalDateTime.now(zoneId));
    User saved = userRepository.save(user);
    return saved.getId();
  }

  @Override
  @SneakyThrows
  @Transactional
  public Long update(Long id, UserRequest request) {
    log.info("Update user with request {}", request.toString());
    validator.validate(request);
    Optional<User> userOptional = userRepository.findById(id);
    if (userOptional.isEmpty()) {
      throw new Exception("User not found");
    }
    User user = userOptional.get();
    UserMapper.INSTANCE.partialUpdate(user, request);
    user.setModifiedDate(LocalDateTime.now(zoneId));
    userRepository.save(user);
    return id;
  }

  @Override
  @SneakyThrows
  public void remove(Long id) {
    log.info("Remove user with id {}", id);
    Optional<User> userOptional = userRepository.findById(id);
    if (userOptional.isEmpty()) {
      throw new Exception("User not found");
    }
    User user = userOptional.get();
    userRepository.delete(user);
  }

  @Override
  @SneakyThrows
  public UserResponse detail(Long id) {
    log.info("Get user with id {}", id);
    Optional<User> userOptional = userRepository.findById(id);
    if (userOptional.isEmpty()) {
      throw new Exception("User not found");
    }
    User user = userOptional.get();
    return UserMapper.INSTANCE.toResponse(user);
  }

  @Override
  public Page<UserResponse> list(QueryUserRequest request) {
    log.info("Get list user with request {}", request.toString());
    List<UserResponse> userResponses = userRepository.filter(request);
    Long count = userRepository.count(request);
    return new PageImpl<>(userResponses, Pageable.ofSize(request.getSize()), count);
  }
}
