<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.DepartmentDao" %>
<%@ page import="entity.Department" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Department</title>
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
            border-bottom: 3px solid #4CAF50;
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
            background-color: #4CAF50;
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
        .form-group input {
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
        <h1>Quản lý Phòng Ban (Department)</h1>
        
        <%
            DepartmentDao dao = new DepartmentDao();
            String action = request.getParameter("action");
            String message = "";
            String messageType = "";
            
            // Xử lý các action
            if ("add".equals(action)) {
                String id = request.getParameter("id");
                String name = request.getParameter("name");
                
                if (id != null && name != null && !id.trim().isEmpty() && !name.trim().isEmpty()) {
                    Department dept = new Department(id, name);
                    if (dao.create(dept)) {
                        message = "Thêm phòng ban thành công!";
                        messageType = "success";
                    } else {
                        message = "Lỗi khi thêm phòng ban!";
                        messageType = "error";
                    }
                }
            } else if ("delete".equals(action)) {
                String id = request.getParameter("id");
                if (dao.delete(id)) {
                    message = "Xóa phòng ban thành công!";
                    messageType = "success";
                } else {
                    message = "Lỗi khi xóa phòng ban!";
                    messageType = "error";
                }
            } else if ("update".equals(action)) {
                String id = request.getParameter("id");
                String name = request.getParameter("name");
                
                if (id != null && name != null && !id.trim().isEmpty() && !name.trim().isEmpty()) {
                    Department dept = new Department(id, name);
                    if (dao.update(dept)) {
                        message = "Cập nhật phòng ban thành công!";
                        messageType = "success";
                    } else {
                        message = "Lỗi khi cập nhật phòng ban!";
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
        <h2>Thêm/Sửa Phòng Ban</h2>
        <form method="post">
            <div class="form-group">
                <label>Mã phòng ban:</label>
                <input type="text" name="id" required placeholder="Ví dụ: dp01">
            </div>
            <div class="form-group">
                <label>Tên phòng ban:</label>
                <input type="text" name="name" required placeholder="Ví dụ: Phòng Kế toán">
            </div>
            <div class="form-group">
                <button type="submit" name="action" value="add" class="btn btn-add">Thêm mới</button>
                <button type="submit" name="action" value="update" class="btn btn-edit">Cập nhật</button>
            </div>
        </form>
        
        <!-- Danh sách -->
        <h2>Danh sách Phòng Ban</h2>
        <table>
            <thead>
                <tr>
                    <th>Mã phòng ban</th>
                    <th>Tên phòng ban</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Department> departments = dao.findAll();
                    for (Department dept : departments) {
                %>
                <tr>
                    <td><%= dept.getId() %></td>
                    <td><%= dept.getName() %></td>
                    <td>
                        <a href="?action=delete&id=<%= dept.getId() %>" 
                           class="btn btn-delete"
                           onclick="return confirm('Bạn có chắc muốn xóa phòng ban này?')">Xóa</a>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        
        <p style="margin-top: 20px;">
            <a href="Employee.jsp" class="btn btn-add">Quản lý Nhân viên</a>
            <a href="test" class="btn btn-add">Trang chủ</a>
        </p>
    </div>
</body>
</html>