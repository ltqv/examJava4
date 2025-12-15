package Servlet;

import dao.DepartmentDao;
import dao.EmployeeDao;
import entity.Department;
import entity.Employee;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/test")
public class TestServlet extends HttpServlet {
    
    private DepartmentDao departmentDao = new DepartmentDao();
    private EmployeeDao employeeDao = new EmployeeDao();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        
        out.println("<html><head><title>Test JPA</title>");
        out.println("<style>body{font-family:Arial;margin:20px;}</style></head><body>");
        out.println("<h1>Test JPA CRUD Operations</h1>");
        
        // Test Department
        out.println("<h2>Departments:</h2>");
        List<Department> departments = departmentDao.findAll();
        if (departments.isEmpty()) {
            out.println("<p>Chưa có department nào. Đang thêm dữ liệu mẫu...</p>");
            testCreateDepartments();
            departments = departmentDao.findAll();
        }
        
        out.println("<ul>");
        for (Department dept : departments) {
            out.println("<li>" + dept.getId() + " - " + dept.getName() + "</li>");
        }
        out.println("</ul>");
        
        // Test Employee
        out.println("<h2>Employees:</h2>");
        List<Employee> employees = employeeDao.findAll();
        if (employees.isEmpty()) {
            out.println("<p>Chưa có employee nào. Đang thêm dữ liệu mẫu...</p>");
            testCreateEmployees();
            employees = employeeDao.findAll();
        }
        
        out.println("<ul>");
        for (Employee emp : employees) {
            out.println("<li>ID: " + emp.getId() + " - " + emp.getName() + 
                       " - Salary: " + emp.getSalary() + 
                       " - Dept: " + (emp.getDepartment() != null ? emp.getDepartment().getName() : "N/A") + 
                       "</li>");
        }
        out.println("</ul>");
        
        out.println("<p><a href='Department.jsp'>Quản lý Departments</a></p>");
        out.println("<p><a href='Employee.jsp'>Quản lý Employees</a></p>");
        out.println("</body></html>");
    }
    
    private void testCreateDepartments() {
        departmentDao.create(new Department("dp01", "Phòng Kế toán"));
        departmentDao.create(new Department("dp02", "Phòng Nhân sự"));
        departmentDao.create(new Department("dp03", "Phòng Kỹ thuật"));
    }
    
    private void testCreateEmployees() {
        Department dept1 = departmentDao.findById("dp01");
        Department dept2 = departmentDao.findById("dp02");
        
        employeeDao.create(new Employee("Tuấn", 5000, dept1));
        employeeDao.create(new Employee("Lan", 3000, dept1));
        employeeDao.create(new Employee("Bình", 7000, dept1));
        employeeDao.create(new Employee("Dũng", 2000, dept2));
    }
}