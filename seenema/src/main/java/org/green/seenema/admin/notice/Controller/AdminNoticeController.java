package org.green.seenema.admin.notice.Controller;

import java.util.List;

import org.green.seenema.mapper.AdminNoticeMapper;
import org.green.seenema.vo.NoticeVO;
import org.green.seenema.vo.QnaVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/admin")
@Controller
public class AdminNoticeController {
	
	@Autowired
	AdminNoticeMapper anMapper;

	//관리자가 공지글 목록 jsp로 
	@GetMapping("/adNoticeView")
	public void noticeView() {}
	
	//관리자 공지게시판에 목록 출력
	@GetMapping("/adNoticeList")
	public @ResponseBody List<NoticeVO> getNoticeList(){
		
		return anMapper.noticeView();
	}
	
	//공지글 수정을 위한 목록 선택
	@GetMapping("/selectNotice")
	public @ResponseBody List<NoticeVO> getQnaList(int noticeCode) {
		return anMapper.noticeOneList(noticeCode);
	}
	
	//공지글 삭제
	@GetMapping("noticeDel")
	public @ResponseBody void noticeDel(int noticeCode) {
		anMapper.noticeDel(noticeCode);
	}
	
	//공지글 수정
	@PostMapping("editNotice")
	public void editNotice(NoticeVO v) {
		anMapper.noticeEdit(v);
	}
	
	//공지글 등록
	@PostMapping("regiNotice")
	public void noticeRegi(NoticeVO v) {
		anMapper.noticeRegi(v);
	}
	
	
}
