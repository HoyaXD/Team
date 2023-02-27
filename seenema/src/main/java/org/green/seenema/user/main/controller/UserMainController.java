package org.green.seenema.user.main.controller;

import java.util.List;

import org.green.seenema.user.main.mapper.UserMainMapper;
import org.green.seenema.vo.MovieVO;
import org.green.seenema.vo.NoticeVO;
import org.green.seenema.vo.ProductVO;
import org.springframework.beans.factory.annotation.Autowired;
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
	public List<MovieVO> getMainMoiveList(){
		List<MovieVO> mainList = mapper.getMainMovieList();
		return mainList;
	}
	
	@GetMapping("/main/getStoreList.do")
	public List<ProductVO> getStoreList(){
		List<ProductVO> productList = mapper.getStoreList();
		return productList;
	}
	
	@GetMapping("/main/getMainNoticeList.do")
	public List<NoticeVO> getMainNoticeList(){
		List<NoticeVO> noticeList = mapper.getMainNoticeList();
		return noticeList;
	}
}
