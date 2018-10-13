package org.pzy.tmall.service;

import java.util.List;
import org.pzy.tmall.pojo.User;
public interface UserService {
    void add(User user);

    void delete(int id);

    void update(User user);

    User get(int id);

    List list();

    boolean isExist(String name);

    User get(String name, String password);
}
