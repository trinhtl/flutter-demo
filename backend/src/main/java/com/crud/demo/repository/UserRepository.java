package com.crud.demo.repository;

import com.crud.demo.model.entity.User;
import com.crud.demo.repository.custom.UserRepositoryCustom;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Long>, UserRepositoryCustom {

}
