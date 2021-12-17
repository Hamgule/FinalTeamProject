package com.project.covidhandong.board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAOImpl implements BoardDAO {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int insertBoard(BoardVO vo) {
		return sqlSession.insert("BoardDAO.insertBoard", vo);
	}
	@Override
	public int updateBoard(BoardVO vo) {
		return sqlSession.update("BoardDAO.updateBoard", vo);
	}
	@Override
	public int deleteBoard(int id) {
		return sqlSession.delete("BoardDAO.deleteBoard", id);
	}
	@Override
	public BoardVO getBoard(BoardVO vo) {
		return sqlSession.selectOne("UserDAO.getBoard", vo);
	}
	@Override
	public List<BoardVO> getBoardList() {
		List<BoardVO> list = sqlSession.selectList("BoardDAO.getBoardList");
		
		return list;
	}

}
