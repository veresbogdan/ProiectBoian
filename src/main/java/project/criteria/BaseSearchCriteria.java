package project.criteria;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.Serializable;

public class BaseSearchCriteria implements Serializable {

    private Long id;

    @JsonProperty(value = "page_no")
    private Integer pageNo;

    @JsonProperty(value = "per_page")
    private Integer perPage;

    @JsonIgnore
    private Integer totalNo;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getPageNo() {
        return pageNo;
    }

    public void setPageNo(Integer pageNo) {
        this.pageNo = pageNo;
    }

    public Integer getPerPage() {
        return perPage;
    }

    public void setPerPage(Integer perPage) {
        this.perPage = perPage;
    }

    public Integer getTotalNo() {
        return totalNo;
    }

    public void setTotalNo(Integer totalNo) {
        this.totalNo = totalNo;
    }

    public int getNumberOfPages() {
        int noPages;

        if (this.totalNo == null || this.perPage == null || this.perPage.equals(0)) {
            noPages = 1;
        } else {
            noPages = totalNo / this.perPage + ((this.totalNo % this.perPage == 0) ? 0 : 1);
        }
        return noPages;
    }

    public int getStartRecord() {
        int startRecord = (this.pageNo - 1) * this.perPage;
        return startRecord;
    }
}
