package com.project.covidhandong.user;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAOImpl implements UserDAO{
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int insertUser(UserVO vo) {
		System.out.println("insertUser");
		return sqlSession.insert("USerDAO.insertUser", vo);
	}
	@Override
	public int updateUser(UserVO vo) {
		System.out.println("updateUser");
		return sqlSession.update("USerDAO.updateUser", vo);
	}
	@Override
	public int deleteUser(int id) {
		System.out.println("deleteUser");
		return sqlSession.delete("USerDAO.deleteUser", id);
	}
	@Override
	public UserVO getUser(UserVO vo) {
		System.out.println("getUser");
		return sqlSession.selectOne("UserDAO.getUser", vo);
	}
	@Override
	public List<UserVO> getUserList() {
		System.out.println("getUserList");
		return sqlSession.selectList("UserDAO.getUserList");
	}

}
