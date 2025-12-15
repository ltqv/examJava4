package dao;

import entity.Department;
import until.XJpa;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

public class DepartmentDao {
    
    // CREATE
    public boolean create(Department department) {
        EntityManager em = XJpa.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(department);
            trans.commit();
            return true;
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    
    // READ - Find by ID
    public Department findById(String id) {
        EntityManager em = XJpa.getEntityManager();
        try {
            return em.find(Department.class, id);
        } finally {
            em.close();
        }
    }
    
    // READ - Find All
    public List<Department> findAll() {
        EntityManager em = XJpa.getEntityManager();
        try {
            String jpql = "SELECT d FROM Department d";
            TypedQuery<Department> query = em.createQuery(jpql, Department.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    // UPDATE
    public boolean update(Department department) {
        EntityManager em = XJpa.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(department);
            trans.commit();
            return true;
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    
    // DELETE
    public boolean delete(String id) {
        EntityManager em = XJpa.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Department department = em.find(Department.class, id);
            if (department != null) {
                em.remove(department);
                trans.commit();
                return true;
            }
            trans.rollback();
            return false;
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}