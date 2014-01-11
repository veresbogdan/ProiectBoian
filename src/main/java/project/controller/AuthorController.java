package project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import project.model.Author;
import project.service.AuthorService;

import java.util.List;

@Controller
@RequestMapping("/author")
public class AuthorController extends BaseController{

    @Autowired
    private AuthorService authorService;

    @RequestMapping(value = "/manage", method = RequestMethod.GET)
    public @ResponseBody ModelAndView findByCriteria() {
        ModelAndView mav = new ModelAndView("manage_authors");
        mav.addObject("authors_result", authorService.getAllAuthors());

        return mav;
    }

    @RequestMapping(value = "/find/{id}", method = RequestMethod.GET)
    public @ResponseBody Author findById(@PathVariable Long id) {
        return authorService.getAuthorById(id);
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public @ResponseBody Author createAuthor(@RequestBody Author author) {
        return authorService.createAuthor(author);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public @ResponseBody Author updateAuthor(@RequestBody Author author) {
        return authorService.updateAuthor(author);
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public @ResponseBody Author deleteAuthor(@RequestBody Author author) {
        return authorService.deleteAuthor(author);
    }
}
