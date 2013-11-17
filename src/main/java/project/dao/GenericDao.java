package project.dao;

import project.model.EntityBase;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;
import java.util.Map;

public class GenericDao {

    @PersistenceContext()
    protected EntityManager entityManager;

    public <T extends EntityBase> List<T> findAll(Class<T> entityClass) {
        return entityManager.createQuery("SELECT t FROM " + entityClass.getSimpleName() + " t").getResultList();
    }

    //todo: refactor
    public <T extends EntityBase> List<T> findByCriteria(Map<String, Object> criteriaMap, Class<T> entityClass) {
        Query query = constructSelectQuery(criteriaMap, entityClass);
        return query.getResultList();
    }

    public <T extends EntityBase> Query constructSelectQuery(Map<String, Object> criteriaMap, Class<T> entityClass) {
        String queryString = constructQueryString(criteriaMap, entityClass);
        return addParametersToQuery(criteriaMap, queryString);
    }

    public <T extends EntityBase> Query constructCountQuery(Map<String, Object> criteriaMap, Class<T> entityClass) {
        String queryString = constructQueryString(criteriaMap, entityClass);
        queryString = queryString.replace("SELECT t FROM", "SELECT COUNT(*) FROM");
        return addParametersToQuery(criteriaMap, queryString);
    }

    public <T extends EntityBase> String constructQueryString(Map<String, Object> criteriaMap, Class<T> entityClass) {
        int propertyCounter = 1;
        String queryString = "SELECT t FROM " + entityClass.getSimpleName() + " t";
        if (!criteriaMap.isEmpty()) {
            queryString += " WHERE ";
            for (String key : criteriaMap.keySet()) {
                queryString += "t." + key + "=:t" + propertyCounter;
                if (propertyCounter != criteriaMap.keySet().size()) {
                    queryString += " AND ";
                    propertyCounter++;
                }
            }
        }

        return queryString;
    }

    public Query addParametersToQuery (Map<String, Object> criteriaMap, String queryString) {
        int propertyCounter = 1;
        Query query = entityManager.createQuery(queryString);
        for (String key : criteriaMap.keySet()) {
            query.setParameter("t" + propertyCounter, criteriaMap.get(key));
            propertyCounter++;
        }
        return query;
    }

//    public <T extends EntityBase, E extends BaseSearchCriteria> List<T> findByPagedCriteria(E criteria, Map<String, Object> criteriaMap, Class<T> entityClass) {
//        Query selectQuery = constructSelectQuery(criteriaMap, entityClass);
//
//        if (criteria.getPageNo() != null && criteria.getPerPage() != null) {
//
//            Query countQuery = constructCountQuery(criteriaMap, entityClass);
//            Long count = (Long)countQuery.getSingleResult();
//            criteria.setTotalNo(count.intValue());
//
//            selectQuery.setFirstResult(criteria.getStartRecord());
//            selectQuery.setMaxResults(criteria.getPerPage());
//        }
//
//        return selectQuery.getResultList();
//    }

    public <T extends EntityBase> T saveOrUpdate(T entity) {
        T savedEntity = entityManager.merge(entity);
        entityManager.flush();
        return savedEntity;
    }

    public <T extends EntityBase> T findById(Class<T> entityClass, Object entity) {
        return (T)entityManager.find(entityClass, entity);
    }

    public <T extends EntityBase> void delete(Object entity) {
        entityManager.remove(entity);
    }

    public <T extends EntityBase> void delete(Long id, Class<T> entityClass) {
        T entity = findById(entityClass, id);
        entityManager.remove(entity);
    }
}