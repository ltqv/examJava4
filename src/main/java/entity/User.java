package entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Users")
public class User {
@Id

@Column(name = "Id")
private String id;

@Column(name = "Username")
private String username;

@Column(name = "Password")
  private String password;

@Column(name = "Fullname")
private String fullname;

@Column(name = "Email")
private String email;

@Column(name = "Admin")
private boolean admin;

public User() {}


public User(String id, String username, String password, String fullname, String email, boolean admin) {
	super();
	this.id = id;
	this.username = username;
	this.password = password;
	this.fullname = fullname;
	this.email = email;
	this.admin = admin;
}


public String getId() {
	return id;
}

public void setId(String id) {
	this.id = id;
}

public String getUsername() {
	return username;
}

public void setUsername(String username) {
	this.username = username;
}

public String getPassword() {
	return password;
}

public void setPassword(String password) {
	this.password = password;
}

public String getFullname() {
	return fullname;
}

public void setFullname(String fullname) {
	this.fullname = fullname;
}

public String getEmail() {
	return email;
}

public void setEmail(String email) {
	this.email = email;
}

public boolean isAdmin() {
	return admin;
}

public void setAdmin(boolean admin) {
	this.admin = admin;
}


}

