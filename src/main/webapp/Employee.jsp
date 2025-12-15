<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.EmployeeDao" %>
<%@ page import="dao.DepartmentDao" %>
<%@ page import="entity.Employee" %>
<%@ page import="entity.Department" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Employee</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            border-bottom: 3px solid #2196F3;
            padding-bottom: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #2196F3;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .btn {
            padding: 8px 16px;
            margin: 2px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-add {
            background-color: #4CAF50;
            color: white;
        }
        .btn-edit {
            background-color: #2196F3;
            color: white;
        }
        .btn-delete {
            background-color: #f44336;
            color: white;
        }
        .btn:hover {
            opacity: 0.8;
        }
        .form-group {
            margin: 15px 0;
        }
        .form-group label {
            display: inline-block;
            width: 150px;
            font-weight: bold;
        }
        .form-group input, .form-group select {
            padding: 8px;
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .message {
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Quản lý Nhân Viên (Employee)</h1>
        
        <%
            EmployeeDao empDao = new EmployeeDao();
            DepartmentDao deptDao = new DepartmentDao();
            String action = request.getParameter("action");
            String message = "";
            String messageType = "";
            
            // Xử lý các action
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                String salaryStr = request.getParameter("salary");
                String deptId = request.getParameter("deptId");
                
                if (name != null && salaryStr != null && deptId != null && 
                    !name.trim().isEmpty() && !deptId.trim().isEmpty()) {
                    try {
                        double salary = Double.parseDouble(salaryStr);
                        Department dept = deptDao.findById(deptId);
                        
                        if (dept != null) {
                            Employee emp = new Employee(name, salary, dept);
                            if (empDao.create(emp)) {
                                message = "Thêm nhân viên thành công!";
                                messageType = "success";
                            } else {
                                message = "Lỗi khi thêm nhân viên!";
                                messageType = "error";
                            }
                        } else {
                            message = "Phòng ban không tồn tại!";
                            messageType = "error";
                        }
                    } catch (NumberFormatException e) {
                        message = "Lương phải là số!";
                        messageType = "error";
                    }
                }
            } else if ("delete".equals(action)) {
                String idStr = request.getParameter("id");
                try {
                    int id = Integer.parseInt(idStr);
                    if (empDao.delete(id)) {
                        message = "Xóa nhân viên thành công!";
                        messageType = "success";
                    } else {
                        message = "Lỗi khi xóa nhân viên!";
                        messageType = "error";
                    }
                } catch (NumberFormatException e) {
                    message = "ID không hợp lệ!";
                    messageType = "error";
                }
            } else if ("update".equals(action)) {
                String idStr = request.getParameter("id");
                String name = request.getParameter("name");
                String salaryStr = request.getParameter("salary");
                String deptId = request.getParameter("deptId");
                
                if (idStr != null && name != null && salaryStr != null && deptId != null) {
                    try {
                        int id = Integer.parseInt(idStr);
                        double salary = Double.parseDouble(salaryStr);
                        Department dept = deptDao.findById(deptId);
                        
                        if (dept != null) {
                            Employee emp = new Employee(name, salary, dept);
                            emp.setId(id);
                            
                            if (empDao.update(emp)) {
                                message = "Cập nhật nhân viên thành công!";
                                messageType = "success";
                            } else {
                                message = "Lỗi khi cập nhật nhân viên!";
                                messageType = "error";
                            }
                        } else {
                            message = "Phòng ban không tồn tại!";
                            messageType = "error";
                        }
                    } catch (NumberFormatException e) {
                        message = "ID hoặc lương không hợp lệ!";
                        messageType = "error";
                    }
                }
            }
            
            if (!message.isEmpty()) {
        %>
            <div class="message <%= messageType %>"><%= message %></div>
        <%
            }
        %>
        
        <!-- Form thêm/sửa -->
        <h2>Thêm/Sửa Nhân Viên</h2>
        <form method="post">
            <div class="form-group">
                <label>ID (để trống nếu thêm mới):</label>
                <input type="number" name="id" placeholder="Tự động tạo khi thêm mới">
            </div>
            <div class="form-group">
                <label>Tên nhân viên:</label>
                <input type="text" name="name" required placeholder="Ví dụ: Nguyễn Văn A">
            </div>
            <div class="form-group">
                <label>Lương:</label>
                <input type="number" name="salary" step="0.01" required placeholder="Ví dụ: 5000">
            </div>
            <div class="form-group">
                <label>Phòng ban:</label>
                <select name="deptId" required>
                    <option value="">-- Chọn phòng ban --</option>
                    <%
                        List<Department> departments = deptDao.findAll();
                        for (Department dept : departments) {
                    %>
                    <option value="<%= dept.getId() %>"><%= dept.getName() %></option>
                    <%
                        }
                    %>
                </select>
            </div>
            <div class="form-group">
                <button type="submit" name="action" value="add" class="btn btn-add">Thêm mới</button>
                <button type="submit" name="action" value="update" class="btn btn-edit">Cập nhật</button>
            </div>
        </form>
        
        <!-- Danh sách -->
        <h2>Danh sách Nhân Viên</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên nhân viên</th>
                    <th>Lương</th>
                    <th>Phòng ban</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Employee> employees = empDao.findAll();
                    for (Employee emp : employees) {
                %>
                <tr>
                    <td><%= emp.getId() %></td>
                    <td><%= emp.getName() %></td>
                    <td><%= String.format("%.2f", emp.getSalary()) %></td>
                    <td><%= emp.getDepartment() != null ? emp.getDepartment().getName() : "N/A" %></td>
                    <td>
                        <a href="?action=delete&id=<%= emp.getId() %>" 
                           class="btn btn-delete"
                           onclick="return confirm('Bạn có chắc muốn xóa nhân viên này?')">Xóa</a>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        
        <p style="margin-top: 20px;">
            <a href="Department.jsp" class="btn btn-add">Quản lý Phòng ban</a>
            <a href="test" class="btn btn-add">Trang chủ</a>
        </p>
    </div>
</body>
</html>