package project.dao;

import org.springframework.stereotype.Repository;
import project.criteria.BookSearchCriteria;
import project.model.Book;

import javax.persistence.Query;
import java.util.List;

@Repository
public class BookDao extends GenericDao {

    public List<Book> findByCriteria(BookSearchCriteria searchCriteria) {
        String queryString = constructQueryString(searchCriteria);
        Query selectQuery = addParametersToQuery(queryString, searchCriteria);

        if (searchCriteria.getPageNo() != null && searchCriteria.getPerPage() != null) {
            queryString = queryString.replace("SELECT t FROM", "SELECT COUNT(*) FROM");
            Query countQuery = addParametersToQuery(queryString, searchCriteria);

            Long count = (Long)countQuery.getSingleResult();
            searchCriteria.setTotalNo(count.intValue());

            selectQuery.setFirstResult(searchCriteria.getStartRecord());
            selectQuery.setMaxResults(searchCriteria.getPerPage());
        }

        return selectQuery.getResultList();
    }

    private String constructQueryString(BookSearchCriteria searchCriteria) {
        String queryString = "SELECT t FROM Book t";
        Boolean first = true;

        if (searchCriteria.getId() != null) {
            queryString += " WHERE t.id =:id ";
            first = false;
        }

        if (searchCriteria.getTitle() != null) {
            if (first) {
                queryString += " WHERE t.title =:title ";
                first = false;
            } else {
                queryString += " AND t.title =:title ";
            }
        }

        if (searchCriteria.getYear() != null) {
            if (first) {
                queryString += " WHERE t.year =:year ";
                first = false;
            } else {
                queryString += " AND t.year =:year ";
            }
        }

        if (searchCriteria.getPublisher() != null) {
            if (first) {
                queryString += " WHERE t.publisher =:publisher ";
                first = false;
            } else {
                queryString += " AND t.publisher =:publisher ";
            }
        }

        if (searchCriteria.getAuthorId() != null) {
            if (first) {
                queryString += " WHERE ";
            } else {
                queryString += "AND ";
            }
            queryString += ":authorId IN (SELECT ba.author.id FROM BookAuthor ba WHERE ba.book.id = t.id)";
        }

        return queryString;
    }

    private Query addParametersToQuery(String queryString, BookSearchCriteria searchCriteria) {
        Query query = entityManager.createQuery(queryString);

        if (searchCriteria.getId() != null) {
            query.setParameter("id", searchCriteria.getId());
        }
        if (searchCriteria.getTitle() != null) {
            query.setParameter("title", searchCriteria.getTitle());
        }
        if (searchCriteria.getYear() != null) {
            query.setParameter("year", searchCriteria.getYear());
        }
        if (searchCriteria.getPublisher() != null) {
            query.setParameter("publisher", searchCriteria.getPublisher());
        }
        if (searchCriteria.getAuthorId() != null) {
            query.setParameter("authorId", searchCriteria.getAuthorId());
        }

        return query;
    }
}