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

    public User createUser(User user) {
        User responseUser = null;
        if (user.getName() != null && !user.getName().isEmpty() && user.getCnp() != null) {
            responseUser =  userDao.saveOrUpdate(user);
        }

        return responseUser;
    }

    public User updateUSer(User user) {
        if (user.getId() != null) {
            User oldUser = userDao.findById(User.class, user.getId());

            if (user.getName() != null && !user.getName().isEmpty()) {
                oldUser.setName(user.getName());
            }
            if (user.getCnp() != null) {
                oldUser.setCnp(user.getCnp());
            }
            if (user.getEmail() != null && !user.getEmail().isEmpty()) {
                oldUser.setEmail(user.getEmail());
            }

            return userDao.saveOrUpdate(oldUser);
        }

        return null;
    }

    public User deleteUser(User user) {
        if (user.getId() != null) {
            User oldUser = userDao.findById(User.class, user.getId());

            if (oldUser.getBooks().isEmpty()) {
                userDao.delete(oldUser);
                return oldUser;
            }
        }

        return null;
    }
}
