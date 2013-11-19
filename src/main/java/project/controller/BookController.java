package project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import project.criteria.BookSearchCriteria;
import project.model.Book;
import project.service.BookService;

import java.util.List;

@Controller
@RequestMapping("/")
public class BookController extends BaseController {

    @Autowired
    private BookService bookService;

    @RequestMapping(value = "/book/findAll", method = RequestMethod.GET)
    public @ResponseBody List<Book> findByCriteria() {
        return bookService.getAllBooks();
    }

    @RequestMapping(value = "/book/find", method = RequestMethod.POST)
    public @ResponseBody List<Book> findByCriteria(@RequestBody BookSearchCriteria searchCriteria) {
        return (List<Book>)bookService.findByCriteria(searchCriteria).get("result");
    }
}
