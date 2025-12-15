package dao;

import entity.Employee;
import until.XJpa;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

public class EmployeeDao {
    
    // CREATE
    public boolean create(Employee employee) {
        EntityManager em = XJpa.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(employee);
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
    public Employee findById(int id) {
        EntityManager em = XJpa.getEntityManager();
        try {
            return em.find(Employee.class, id);
        } finally {
            em.close();
        }
    }
    
    // READ - Find All
    public List<Employee> findAll() {
        EntityManager em = XJpa.getEntityManager();
        try {
            String jpql = "SELECT e FROM Employee e";
            TypedQuery<Employee> query = em.createQuery(jpql, Employee.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    // READ - Find by Department
    public List<Employee> findByDepartment(String departmentId) {
        EntityManager em = XJpa.getEntityManager();
        try {
            String jpql = "SELECT e FROM Employee e WHERE e.department.id = :deptId";
            TypedQuery<Employee> query = em.createQuery(jpql, Employee.class);
            query.setParameter("deptId", departmentId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    // UPDATE
    public boolean update(Employee employee) {
        EntityManager em = XJpa.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(employee);
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
    public boolean delete(int id) {
        EntityManager em = XJpa.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Employee employee = em.find(Employee.class, id);
            if (employee != null) {
                em.remove(employee);
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