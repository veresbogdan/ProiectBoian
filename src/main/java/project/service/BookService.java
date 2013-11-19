package project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import project.criteria.BookSearchCriteria;
import project.dao.BookDao;
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
}
