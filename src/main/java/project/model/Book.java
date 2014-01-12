package project.model;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "`book`")
public class Book extends EntityBase {

    private String title;

    private Integer year;

    private Date bookingDate;

    private Date dueDate;

    private String language;

    private String publisher;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    //@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "book_author", joinColumns = { @JoinColumn(name = "book_id") }, inverseJoinColumns = { @JoinColumn(name = "author_id") })
    private List<Author> authors = new ArrayList<Author>();

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Author> getAuthors() {
        return authors;
    }

    public void setAuthors(List<Author> authors) {
        this.authors = authors;
    }
}
