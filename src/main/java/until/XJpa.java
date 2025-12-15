package until;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class XJpa {
private static EntityManagerFactory factory;
    
    static {
        factory = Persistence.createEntityManagerFactory("JAV4");
    }

    public static EntityManager getEntityManager() {
        return factory.createEntityManager();
    }
    public static void main(String[] args) {
		EntityManager em = XJpa.getEntityManager();
		try {
			System.out.println("kn thanh cong nha hehhe");
		} catch (Exception e) {
		    e.printStackTrace(); // BẮT BUỘC
		}
		
	}
}
