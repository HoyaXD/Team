package org.green.seenema.user.main.controller;

import java.util.List;

import org.green.seenema.user.main.mapper.UserMainMapper;
import org.green.seenema.vo.MovieVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/user")
@Slf4j
public class UserMainController {
	
	@Autowired
	private UserMainMapper mapper;
	
	@GetMapping("/main/getMainMoiveList.do")
	public List<MovieVO> getMainMoiveList(Model model){
		List<MovieVO> mainList = mapper.getMainMovieList();
//		log.info("===========================================");
//		for(MovieVO movie : mainList) {
//			log.info(movie.toString());
//			System.out.println();
//		}
//		log.info("===========================================");
		return mainList;
	}
}
