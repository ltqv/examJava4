package dao;

import entity.Department;

import java.util.List;

public class DepartmentDaoImpl extends DepartmentDao {
    
    // Bạn có thể thêm các phương thức đặc biệt khác ở đây
    
    public List<Department> searchByName(String keyword) {
        // Implementation tìm kiếm theo tên
        return null;
    }
    
    public int countEmployeesInDepartment(String departmentId) {
        // Implementation đếm số nhân viên
        return 0;
    }
}