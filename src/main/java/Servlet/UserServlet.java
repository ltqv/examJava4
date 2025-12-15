package Servlet;

import DAO.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/users")

public class UserServlet extends HttpServlet {
	
	private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String search = request.getParameter("search");

        if ("delete".equals(action)) {
            String id = request.getParameter("id");
            if (id != null && !id.isEmpty()) {
                userDAO.deleteUser(id);
            }
        } else if ("edit".equals(action)) {
            String id = request.getParameter("id");
            if (id != null && !id.isEmpty()) {
                User user = userDAO.getUser(id);
                request.setAttribute("user", user);
            }
        }

        List<User> list;
        if (search != null && !search.trim().isEmpty()) {
            list = userDAO.searchUsers(search);
        } else {
            list = userDAO.getAllUsers();
        }
        request.setAttribute("listUser", list);
        request.getRequestDispatcher("/User.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        boolean admin = "Admin".equals(role);

        User user = new User();
        user.setId(id);
        user.setUsername(username);
        user.setPassword(password);
        user.setFullname(fullname);
        user.setEmail(email);
        user.setAdmin(admin);

        userDAO.saveUser(user);

        response.sendRedirect("users");
    }

}
