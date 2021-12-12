package com.project.covidhandong.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserDAO userDAO;
	
	@Override
	public int insertUser(UserVO vo) {
		return userDAO.insertUser(vo);
	}
	@Override
	public int updateUser(UserVO vo) {
		return userDAO.updateUser(vo);
	}
	@Override
	public int deleteUser(int id) {
		return userDAO.deleteUser(id);
	}
	@Override
	public UserVO getUser(UserVO vo) {
		return userDAO.getUser(vo);
	}
	@Override
	public List<UserVO> getUserList(){
		return userDAO.getUserList();
	}
}