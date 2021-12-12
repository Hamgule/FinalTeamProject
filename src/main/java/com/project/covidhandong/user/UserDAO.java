package com.project.covidhandong.user;

import java.util.List;

public interface UserDAO {
	public int insertUser(UserVO vo);
	public int updateUser(UserVO vo);
	public int deleteUser(int id);
	public UserVO getUser(UserVO vo);
	public List<UserVO> getUserList();
}
