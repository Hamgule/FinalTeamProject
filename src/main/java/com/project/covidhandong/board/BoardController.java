package com.project.covidhandong.board;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.covidhandong.user.UserService;
import com.project.covidhandong.user.UserVO;

@Controller
@RequestMapping(value = "/board")
public class BoardController {
	@Autowired
	BoardService boardService;
	UserService userService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String boardlist(Model model, HttpSession session, UserVO vo) {
		model.addAttribute("list", boardService.getBoardList());
		model.addAttribute("user", session.getAttribute("login"));
		return "board/posts";
	}
	
	@RequestMapping(value = "/addok", method = RequestMethod.POST)
	public String addPostOK(BoardVO vo) {
		int i = boardService.insertBoard(vo);
		
		if (i == 0) System.out.println("[ERROR] Create Failed");
		else System.out.println("[INFO] '" + vo.getWriter() + "' created a new post");
		return "redirect:list";
	}
	
	@RequestMapping(value = "/editok/{id}", method = RequestMethod.POST)
	public String editPostOK(@PathVariable("id") int id, BoardVO bvo) {
		bvo.setId(id);
		String numEnds = "th";
		
		if ((int) (id / 10) != 10) {
			if (id % 10 == 1) numEnds = "st";
			if (id % 10 == 2) numEnds = "nd";
			if (id % 10 == 3) numEnds = "rd";
		}
		
		int i = boardService.updateBoard(bvo);
		if (i == 0) System.out.println("[ERROR] Edit Failed");
		else System.out.println("[INFO] " + id + numEnds + " post edited");
		return "redirect:../list";
	}
	
	@RequestMapping(value = "/deleteok/{id}", method = RequestMethod.GET)
	public String deletePost(@PathVariable("id") int id) {
		int i = boardService.deleteBoard(id);
		String numEnds = "th";
		
		if ((int) (id / 10) != 10) {
			if (id % 10 == 1) numEnds = "st";
			if (id % 10 == 2) numEnds = "nd";
			if (id % 10 == 3) numEnds = "rd";
		}
		if (i == 0) System.out.println("[ERROR] Delete Failed");
		else System.out.println("[INFO] " + id + numEnds + " post deleted");
		return "redirect:../list";
	}
}
