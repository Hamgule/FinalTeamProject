package com.project.covidhandong.board;

import java.util.List;

public interface BoardDAO {
	public int insertBoard(BoardVO vo);
	public List<BoardVO> getBoardList();
}
