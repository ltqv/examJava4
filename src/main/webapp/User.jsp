<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Management - CRUD</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-dark text-white">
            <h3 class="mb-0">User Management - CRUD</h3>
            <small>Fill in the data below.</small>
        </div>
        <div class="card-body">
            <form action="users" method="post">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label>User ID <span class="text-danger">*</span></label>
                        <input type="text" name="id" class="form-control"
                               value="${user != null ? user.id : ''}"
                               ${user != null ? 'readonly' : ''} required>
                    </div>
                    <div class="col-md-6">
                        <label>Username</label>
                        <input type="text" name="username" class="form-control"
                               value="${user != null ? user.username : ''}">
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label>Password <span class="text-danger">*</span></label>
                        <input type="password" name="password" class="form-control"
                               value="${user != null ? user.password : ''}" required>
                    </div>
                    <div class="col-md-6">
                        <label>Full Name <span class="text-danger">*</span></label>
                        <input type="text" name="fullname" class="form-control"
                               value="${user != null ? user.fullname : ''}" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label>Email <span class="text-danger">*</span></label>
                    <input type="email" name="email" class="form-control"
                           value="${user != null ? user.email : ''}" required>
                </div>

                <div class="mb-3">
                    <label>Role:</label>
                    <select name="role" class="form-select">
                        <option value="User" ${user == null || !user.admin ? 'selected' : ''}>User</option>
                        <option value="Admin" ${user != null && user.admin ? 'selected' : ''}>Admin</option>
                    </select>
                </div>

                <div class="mb-3">
                    <button type="submit" class="btn btn-primary">
                        ${user != null ? 'Update' : 'Create'}
                    </button>
                    <button type="reset" class="btn btn-secondary">Reset</button>
                </div>
            </form>

            <!-- Tìm kiếm -->
            <form action="users" method="get" class="mb-4">
                <div class="input-group">
                    <input type="text" name="search" class="form-control"
                           placeholder="Tìm theo ID, Username, Tên hoặc Email..."
                           value="${param.search}">
                    <button class="btn btn-outline-primary" type="submit">Tìm kiếm</button>
                </div>
            </form>

            <!-- Bảng danh sách -->
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                <tr>
                    <th>No.</th>
                    <th>User ID</th>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${listUser}" var="u" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${u.id}</td>
                        <td>${u.username}</td>
                        <td>${u.password}</td>
                        <td>${u.fullname}</td>
                        <td>${u.email}</td>
                        <td>${u.admin ? 'Admin' : 'User'}</td>
                        <td>
                            <a href="users?action=edit&id=${u.id}" class="btn btn-sm btn-info text-white">Edit</a>
                            <a href="users?action=delete&id=${u.id}"
                               class="btn btn-sm btn-danger text-white"
                               onclick="return confirm('Xóa user ${u.id} này?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>