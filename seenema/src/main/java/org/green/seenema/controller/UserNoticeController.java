package org.green.seenema.controller;

import java.util.List;

import org.green.seenema.mapper.UserNoticeMapper;
import org.green.seenema.vo.NoticeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/user")
@Slf4j
public class UserNoticeController {
	
	@Autowired
	private UserNoticeMapper mapper;
	
	// 공지목록
	@GetMapping("/getNoticeList.do")
	public List<NoticeVO> getNoticeList(int pageNum) {
		int count = (pageNum - 1) * 20;
		List<NoticeVO> list = mapper.getNoticeList(count);
		return list;
	}
	
	// 공지 갯수
	@GetMapping("/getNoticeCount.do")
	public int getNoticeCount() {
		int result = mapper.getNoticeCount();
		return result;
	}
	
	// 이전글
	@GetMapping("/getPrevContent")
	public NoticeVO getPrevContent(int noticeCode){
		NoticeVO notice = mapper.getPrevContent(noticeCode);
		return notice;
	}
	@GetMapping("/getNextContent")
	public NoticeVO getNextContent(int noticeCode){
		NoticeVO notice = mapper.getNextContent(noticeCode);
		return notice;
	}
}
