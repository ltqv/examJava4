package DAO;

import entity.User;
import until.HibernateUtil;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

public class UserDAO {
	public void saveUser(User user) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.saveOrUpdate(user);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    public void deleteUser(String id) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            User user = session.get(User.class, id);
            if (user != null) {
                session.delete(user);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    public User getUser(String id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(User.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @SuppressWarnings("unchecked")
    public List<User> getAllUsers() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("from User").list();
        }
    }

    @SuppressWarnings("unchecked")
    public List<User> searchUsers(String keyword) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "from User where id like :keyword " +
                         "or username like :keyword " +
                         "or fullname like :keyword " +
                         "or email like :keyword";
            return session.createQuery(hql)
                    .setParameter("keyword", "%" + keyword + "%")
                    .list();
        }
    }
}
