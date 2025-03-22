package com.crud.demo.repository.custom.impl;

import com.crud.demo.mapper.UserMapper;
import com.crud.demo.model.entity.User;
import com.crud.demo.model.request.QueryUserRequest;
import com.crud.demo.model.response.UserResponse;
import com.crud.demo.repository.custom.UserRepositoryCustom;
import jakarta.persistence.Tuple;
import lombok.RequiredArgsConstructor;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class UserRepositoryCustomImpl implements UserRepositoryCustom {
  private final SessionFactory sessionFactory;
  @Override
  @Transactional
  public List<UserResponse> filter(QueryUserRequest request) {
    Session session = sessionFactory.getCurrentSession();
    StringBuilder query = new StringBuilder("FROM User u ORDER BY u.id DESC");
    List<User> users = session.createQuery(query.toString()).getResultList();
    return users.stream().map(user -> UserMapper.INSTANCE.toResponse(user)).toList();
  }

  @Override
  @Transactional
  public Long count(QueryUserRequest request) {
    Session session = sessionFactory.getCurrentSession();
    StringBuilder query = new StringBuilder("SELECT count(*) FROM User");
    Long count = session.createQuery(query.toString(), Long.class).getSingleResult();
    return count;
  }
}
