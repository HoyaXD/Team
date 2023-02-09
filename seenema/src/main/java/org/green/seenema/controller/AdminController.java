package org.green.seenema.controller;

import java.util.List;

import org.green.seenema.mapper.MgmtMapper;
import org.green.seenema.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequestMapping("/admin")
@Controller
public class AdminController {
   
   @Autowired
   MgmtMapper mgmt;
   
   @GetMapping("/MemberMGMT")
   public void memberMGMTViewGo() {
      
   }
   
   //영화관 회원 목록 출력
   @GetMapping("/MemberListView")
   public @ResponseBody List<MemberVO> memberView() {
      return mgmt.memberView();
   }
   
   //영화관 회원 목록 삭제
   @GetMapping("/MemberDel")
   public void memberDel(String id) {
      mgmt.memberDel(id);
   }
   
   //영화관 회원 수정창
   @GetMapping("/memEditPop")
   public List<MemberVO> memEditViewGo(String id,Model model){
      log.info("수정창으로 ㄱㄱ");
      //id를 받음
      log.info("id를 받은 값 : " + id);
      log.info("투스트링 : "+mgmt.oneMemList(id).toString());
      List<MemberVO> list = mgmt.oneMemList(id);
      model.addAttribute("list", list);
      return list;
   }
   //수정창
   @ResponseBody
   @PostMapping("/editInfo")
   public int memberEdit(MemberVO m) {
      log.info("수정버튼누름 : " + m.toString());
      mgmt.editInfo(m);
   return 0;
   }
   
   
   
   
   
   
}