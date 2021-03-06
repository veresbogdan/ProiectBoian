package project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import project.criteria.BookSearchCriteria;
import project.dao.BookDao;
import project.model.Author;
import project.model.Book;

import java.util.*;

@Service
@Transactional
public class BookService {

    @Autowired
    private BookDao bookDao;

    @Autowired
    private UserService userService;

    public List<Book> getAllBooks() {
        return bookDao.findAll(Book.class);
    }

    public Map<String, Object> findByCriteria(BookSearchCriteria searchCriteria) {
        List<Book> books = bookDao.findByCriteria(searchCriteria);

        Map<String, Object> response = new HashMap<String, Object>();
//        response.put("total_pages", searchCriteria.getNumberOfPages());
        response.put("result", books);

        return response;
    }

    public List<Author> getAllAuthors() {
        return bookDao.findAll(Author.class);
    }

    public Book createBook(Book book) {
        if (book.getTitle() != null && !book.getTitle().isEmpty() && book.getAuthors() != null && !book.getAuthors().isEmpty() && book.getYear() != null) {
            List<Author> newAuthors = new ArrayList<Author>();

            for (Author author: book.getAuthors()) {
                if (author.getId() != null && findAuthorById(author.getId()) != null) {
                    Author oldAuthor = findAuthorById(author.getId());
                    newAuthors.add(oldAuthor);
                } else {
                    newAuthors.add(author);
                }
            }
            book.setAuthors(newAuthors);

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

            if (oldBook.getUser() == null) {
                bookDao.delete(oldBook);
                return oldBook;
            }
        }

        return null;
    }

    public Book borrowBook(Book book) {
        if (book.getId() != null && book.getUser() != null && userService.getUserById(book.getUser().getId()) != null) {
            Book oldBook = bookDao.findById(Book.class, book.getId());

            Date date = new Date();
            Calendar calendar = new GregorianCalendar();
            calendar.setTime(date);
            calendar.add(Calendar.DATE, 14);

            oldBook.setUser(userService.getUserById(book.getUser().getId()));
            oldBook.setBookingDate(date);
            oldBook.setDueDate(calendar.getTime());

            return bookDao.saveOrUpdate(oldBook);
        }

        return null;
    }

    public Book returnBook(Book book) {
        if (book.getId() != null && book.getUser() != null) {
            Book oldBook = bookDao.findById(Book.class, book.getId());

            oldBook.setUser(null);
            oldBook.setBookingDate(null);
            oldBook.setDueDate(null);

            return bookDao.saveOrUpdate(oldBook);
        }

        return null;
    }

    public Book findBookById(Long id) {
        return bookDao.findById(Book.class, id);
    }

    public Author findAuthorById(Long id) {
        return bookDao.findById(Author.class, id);
    }
}
