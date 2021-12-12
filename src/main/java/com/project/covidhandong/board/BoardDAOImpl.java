package com.project.covidhandong.board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAOImpl implements BoardDAO{
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int insertBoard(BoardVO vo) {
		System.out.println("insertBoard");
		return sqlSession.insert("BoardDAO.insertBoard", vo);
	}
	
	@Override
	public List<BoardVO> getBoardList() {
		System.out.println("getBoardList");
		List<BoardVO> list = sqlSession.selectList("BoardDAO.getBoardList");
		
		return list;
	}

}
