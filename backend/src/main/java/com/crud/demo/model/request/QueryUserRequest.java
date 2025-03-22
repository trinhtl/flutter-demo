package com.crud.demo.model.request;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
public class QueryUserRequest {
  private String key;
  private Integer page;
  private Integer size;
}
