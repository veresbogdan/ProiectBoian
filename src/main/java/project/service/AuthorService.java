package project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import project.dao.AuthorDao;
import project.model.Author;

import java.util.List;

@Service
@Transactional
public class AuthorService {

    @Autowired
    private AuthorDao authorDao;

    public Author getAuthorById(Long id) {
        return authorDao.findById(Author.class, id);
    }

    public List<Author> getAllAuthors() {
        return authorDao.findAll(Author.class);
    }

    public Author createAuthor(Author author) {
        Author responseAuthor = null;
        if (author.getName() != null && !author.getName().isEmpty()) {
            responseAuthor =  authorDao.saveOrUpdate(author);
        }

        return responseAuthor;
    }

    public Author updateAuthor(Author author) {
        if (author.getId() != null) {
            Author oldAuthor = authorDao.findById(Author.class, author.getId());

            if (author.getName() != null && !author.getName().isEmpty()) {
                oldAuthor.setName(author.getName());
            }
            if (author.getNationality() != null && !author.getNationality().isEmpty()) {
                oldAuthor.setNationality(author.getNationality());
            }

            return authorDao.saveOrUpdate(oldAuthor);
        }

        return null;
    }

    public Author deleteAuthor(Author author) {
        if (author.getId() != null) {
            Author oldAuthor = authorDao.findById(Author.class, author.getId());

            if (oldAuthor.getBooks().isEmpty()) {
                //To Do: delete many to many reference
               // oldAuthor.delete(oldAuthor);
                return oldAuthor;
            }
        }

        return null;
    }
}
