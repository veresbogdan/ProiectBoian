package project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import project.criteria.BookSearchCriteria;
import project.model.Author;
import project.model.Book;
import project.service.BookService;
import project.service.UserService;
import java.util.List;

@Controller
@RequestMapping("/book")
public class BookController extends BaseController {

    @Autowired
    private BookService bookService;

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/listAll", method = RequestMethod.GET)
    public @ResponseBody ModelAndView findAllBooks() {
        ModelAndView mav = new ModelAndView("all_books");
        mav.addObject("books_result", bookService.getAllBooks());
        mav.addObject("users_result",userService.getAllUsers());

        return mav;
    }

    @RequestMapping(value = "/manage", method = RequestMethod.GET)
    public @ResponseBody ModelAndView findAll() {
        ModelAndView mav = new ModelAndView("books/manage_books");
        mav.addObject("books_result", bookService.getAllBooks());
        mav.addObject("authors_result", bookService.getAllAuthors());

        return mav;
    }

    @RequestMapping(value = "/find", method = RequestMethod.POST)
    public @ResponseBody List<Book> findByCriteria(@RequestBody BookSearchCriteria searchCriteria) {
        return (List<Book>)bookService.findByCriteria(searchCriteria).get("result");
    }

    @RequestMapping(value = "/findBook/{id}", method = RequestMethod.POST)
    public @ResponseBody Book findById(@PathVariable Long id) {
        return bookService.findBookById(id);
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public @ResponseBody ModelAndView create() {
        ModelAndView mav = new ModelAndView("books/add_book");
        mav.addObject("authors_result", bookService.getAllAuthors());

        return mav;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public @ResponseBody Book createBook(@RequestBody Book book) {
        return bookService.createBook(book);
    }

    @RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
    public @ResponseBody ModelAndView findBookById(@PathVariable Long id) {
        ModelAndView mav = new ModelAndView("books/update");
        mav.addObject("book", bookService.findBookById(id));

        return mav;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public @ResponseBody Book updateBook(@RequestBody Book book) {
        return bookService.updateBook(book);
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public @ResponseBody Book deleteBook(@RequestBody Book book) {
        return bookService.deleteBook(book);
    }

    @RequestMapping(value = "/borrow", method = RequestMethod.POST)
    public @ResponseBody Book borrowBook(@RequestBody Book book) {
        return bookService.borrowBook(book);
    }

    @RequestMapping(value = "/return", method = RequestMethod.POST)
    public @ResponseBody Book returnBook(@RequestBody Book book) {
        return bookService.returnBook(book);
    }

    @RequestMapping(value = "/findAllAuthors", method = RequestMethod.GET)
    public @ResponseBody List<Author> findAllAuthors() {
        return bookService.getAllAuthors();
    }

    @RequestMapping(value = "/findAuthor/{id}", method = RequestMethod.GET)
    public @ResponseBody Author findAuthorById(@PathVariable Long id) {
        return bookService.findAuthorById(id);
    }
}
