package project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import project.model.User;
import project.service.UserService;

import java.util.List;

@Controller
@RequestMapping("/")
public class UserController extends BaseController{

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/user/findAll", method = RequestMethod.GET)
    public @ResponseBody List<User> findByCriteria() {
        return userService.getAllUsers();
    }
}
