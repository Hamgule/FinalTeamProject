package com.project.covidhandong.board;

import java.util.List;

public interface BoardDAO {
	public int insertBoard(BoardVO vo);
	public int updateBoard(BoardVO vo);
	public int deleteBoard(int id);
	public BoardVO getBoard(BoardVO vo);
	public List<BoardVO> getBoardList();
	public List<BoardVO> getFoundList(String toFind);
	public List<BoardVO> getOrderedList(String orderColumn, String orderDir);
}
