package project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import project.model.User;
import project.service.UserService;

import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController{

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/findAll", method = RequestMethod.GET)
    public @ResponseBody List<User> findByCriteria() {
        return userService.getAllUsers();
    }

    @RequestMapping(value = "/find/{id}", method = RequestMethod.GET)
    public @ResponseBody User findById(@PathVariable Long id) {
        return userService.getUserById(id);
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public @ResponseBody User createUser(@RequestBody User user) {
        return userService.createUser(user);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public @ResponseBody User updateUser(@RequestBody User user) {
        return userService.updateUSer(user);
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public @ResponseBody User deleteUser(@RequestBody User user) {
        return userService.deleteUser(user);
    }
}
