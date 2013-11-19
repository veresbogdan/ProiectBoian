package project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import project.dao.UserDao;
import project.model.User;

import java.util.List;

@Service
@Transactional
public class UserService {

    @Autowired
    private UserDao userDao;

    public User getUserById(Long id) {
        return userDao.findById(User.class, id);
    }

    public List<User> getAllUsers() {
        return userDao.findAll(User.class);
    }
}
