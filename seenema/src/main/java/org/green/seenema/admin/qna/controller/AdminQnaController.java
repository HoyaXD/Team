package org.green.seenema.admin.qna.controller;

import java.util.List;

import org.green.seenema.mapper.AdminQnaMapper;
import org.green.seenema.vo.QnaVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/admin")
@Controller
public class AdminQnaController {

	@Autowired
	AdminQnaMapper adMapper;

	@GetMapping("/qnaView")
	public void qnaView() {
	}

	// 문의글 호출
	@GetMapping("/qnaList")
	public @ResponseBody List<QnaVO> getQnaList() {
		return adMapper.qnaListView();
	}

	// 선택한 문의글 호출
	@GetMapping("/qnaOneList")
	public @ResponseBody QnaVO oneQnaList(int qcode) {
		QnaVO qv = adMapper.qnaOneList(qcode);
		return qv;
	}

}
