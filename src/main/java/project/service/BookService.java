package project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import project.criteria.BookSearchCriteria;
import project.dao.BookDao;
import project.model.Author;
import project.model.Book;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class BookService {

    @Autowired
    private BookDao bookDao;

    public List<Book> getAllBooks() {
        return bookDao.findAll(Book.class);
    }

    public Map<String, Object> findByCriteria(BookSearchCriteria searchCriteria) {
        List<Book> images = bookDao.findByCriteria(searchCriteria);

        Map<String, Object> response = new HashMap<String, Object>();
        response.put("total_pages", searchCriteria.getNumberOfPages());
        response.put("result", images);

        return response;
    }

    public List<Author> getAllAuthors() {
        return bookDao.findAll(Author.class);
    }

    public Book createBook(Book book) {
        if (book.getTitle() != null && !book.getTitle().isEmpty() && book.getAuthors() != null && !book.getAuthors().isEmpty() && book.getYear() != null) {
            return bookDao.saveOrUpdate(book);
        }

        return null;
    }

    public Book updateBook(Book book) {
        if (book.getId() != null) {
            Book oldBook = bookDao.findById(Book.class, book.getId());

            if (book.getTitle() != null && !book.getTitle().isEmpty()) {
                oldBook.setTitle(book.getTitle());
            }
            if (book.getYear() != null) {
                oldBook.setYear(book.getYear());
            }
            if (book.getLanguage() != null) {
                oldBook.setLanguage(book.getLanguage());
            }
            if (book.getPublisher() != null) {
                oldBook.setPublisher(book.getPublisher());
            }
            if (book.getAuthors() != null && !book.getAuthors().isEmpty()) {
                oldBook.setAuthors(book.getAuthors());
            }

            return bookDao.saveOrUpdate(oldBook);
        }

        return null;
    }

    public Book deleteBook(Book book) {
        if (book.getId() != null) {
            Book oldBook = bookDao.findById(Book.class, book.getId());

            bookDao.delete(oldBook);
            return oldBook;
        }

        return null;
    }
}
