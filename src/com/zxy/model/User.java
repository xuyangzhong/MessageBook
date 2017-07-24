package com.zxy.model;

import java.util.Date;

/**
 * 此为实体类User
 * 与Message类为多对一关系
 * @author tinytail
 *
 */

public class User {
private Integer id;
private String username;
private String password;
private String email;
private Date gagTime;
public Date getGagTime() {
	return gagTime;
}
public void setGagTime(Date gagTime) {
	this.gagTime = gagTime;
}

public Integer getId() {
	return id;
}
public void setId(Integer id) {
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
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}

}
