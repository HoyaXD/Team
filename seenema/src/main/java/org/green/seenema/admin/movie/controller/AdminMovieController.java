package org.green.seenema.admin.movie.controller;

import java.util.ArrayList;

import org.green.seenema.mapper.MovieCRUDMapper;
import org.green.seenema.vo.MovieVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin")
public class AdminMovieController {
	
	@Autowired
	MovieCRUDMapper mapper;
	
	@GetMapping("/serchMvByTitle.do")
	public @ResponseBody ArrayList<MovieVO> serchByNameDo(String movieTitle) {
		//영화제목으로 조회
		String _movieTitle = "%" + movieTitle + "%";
		ArrayList<MovieVO> list = mapper.getListByTitle(_movieTitle);
		
		return list;
	}
	
	@GetMapping("/serchMvByDate.do")
	public @ResponseBody ArrayList<MovieVO> serchByDateDo(String startDate, String endDate) {
		//영화 개봉일로 조회 
		ArrayList<MovieVO> list = mapper.getListByreleaseDate(startDate, endDate);
		
		return list;
	}
	
	@GetMapping("/serchMvByTitleDate.do")
	public @ResponseBody ArrayList<MovieVO> serchByNameDateDo(String movieTitle, String startDate, String endDate) {
		//영화 제목 + 개봉일로 조회
		String _movieTitle = "%" + movieTitle + "%";
		ArrayList<MovieVO> list = mapper.getListByTitleDate(_movieTitle, startDate, endDate);
		
		return list;
	}
	
	@GetMapping("/delMoviesByCodes.do")
	public @ResponseBody int delMoviesByCodesDo(int[] movieCodes) {
		int del_result = 0;
		for(int i = 0; i < movieCodes.length; i++) {
			del_result = mapper.delete(movieCodes[i]);
		}
		System.out.println(del_result);
		return del_result;
	}
}
