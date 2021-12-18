package com.project.covidhandong.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	@Override
	public List<BoardVO> getFoundList(String toFind) {
		Map<String, String> param = new HashMap<String, String>();
		
		param.put("toFind", toFind);
		List<BoardVO> list = sqlSession.selectList("BoardDAO.getFoundList", param);
		
		return list;
	}
	@Override
	public List<BoardVO> getOrderedList(String orderColumn) {
		Map<String, String> param = new HashMap<String, String>();
		
		param.put("orderColumn", orderColumn);
		List<BoardVO> list = sqlSession.selectList("BoardDAO.getOrderedList", param);
		
		return list;
	}

}
