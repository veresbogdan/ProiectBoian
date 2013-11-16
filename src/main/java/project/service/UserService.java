package project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import project.dao.UserDao;
import project.model.User;

@Service
public class UserService {

    @Autowired
    private UserDao userDao;

    public User getUserById(Long id) {
        return userDao.findById(User.class, id);
    }
}
