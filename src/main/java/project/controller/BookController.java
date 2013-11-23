package project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import project.criteria.BookSearchCriteria;
import project.model.Author;
import project.model.Book;
import project.service.BookService;

import java.util.List;

@Controller
@RequestMapping("/book")
public class BookController extends BaseController {

    @Autowired
    private BookService bookService;

    @RequestMapping(value = "/findAll", method = RequestMethod.GET)
    public @ResponseBody List<Book> findAllBooks() {
        return bookService.getAllBooks();
    }

    @RequestMapping(value = "/find", method = RequestMethod.POST)
    public @ResponseBody List<Book> findByCriteria(@RequestBody BookSearchCriteria searchCriteria) {
        return (List<Book>)bookService.findByCriteria(searchCriteria).get("result");
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public @ResponseBody Book createBook(@RequestBody Book book) {
        return bookService.createBook(book);
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
}
