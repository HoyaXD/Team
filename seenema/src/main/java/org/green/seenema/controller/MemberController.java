package org.green.seenema.controller;

import lombok.extern.slf4j.Slf4j;
import org.green.seenema.mapper.MemberMapper;
import org.green.seenema.mapper.ReservationMapper;
import org.green.seenema.vo.MemberVO;
import org.green.seenema.vo.ReservationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user")
@Slf4j
public class MemberController {
    @Autowired
    MemberMapper mapper;

    @Autowired
    ReservationMapper reservationMapper;

    @GetMapping("/loginForm")  //로그인폼으로 가기
    public void loginForm(){}

@PostMapping("/login.do")  //로그인 확인
public String login(MemberVO stu, HttpSession session, Model model, HttpServletRequest request) {
    MemberVO member = mapper.loginCheck(stu);
    String msg;
    if(member == null) {
        model.addAttribute("msg", "아이디와 비밀번호를 다시 확인해주세요");
        model.addAttribute("url", "loginForm");
        return "user/alert";

    } else if(member.getGrade().equals("admin")){
        session.setAttribute("logid", stu.getId());
        msg ="admin/adminPage";
    }else {
        session.setAttribute("logid", stu.getId());
        model.addAttribute("msg", stu.getId()+"님 환영합니다!");
        model.addAttribute("url", "main");
//        // 세션에 이전 페이지 URL 저장
//        String referer = request.getHeader("Referer");
//        String prevPage = (String) session.getAttribute("prevPage");
//        session.setAttribute("prevPage", referer);
//
//        // 2번째 전의 페이지로 이동
//        return "redirect:" + prevPage;
        return "user/alert";
    }
    return msg;
}

    @GetMapping("/logout") //로그아웃
    public String logout(HttpSession session, HttpServletRequest request) {
        String referer = request.getHeader("Referer");
        session.setAttribute("prevPage", referer);

        session.removeAttribute("logid"); // 로그인 아이디 세션 삭제

        return "redirect:" + referer;
    }

    @GetMapping("/idcheck.do") //아이디 중복확인
    public @ResponseBody String idcheck(String id, Model model) {
        String msg = null;
        int n = mapper.idCheck(id);
        if(n == 1) {
            msg = "<span style = 'color : red';>이미 사용 중인 아이디입니다.</span>";
        }else {
            msg = "<span style = 'color : green';>사용가능</span>";
        }
        return msg;
    }

    @GetMapping("/regMemberForm")
    public void regMemberForm(){}

    @PostMapping("/reg.do")
    public String regdo(MemberVO member){
        mapper.regMember(member);

        return "user/regMemberComplete";
    }

    @GetMapping("/myPage")
    public void mypage(Model model, HttpSession session){
        model.addAttribute("member", mapper.selectMember((String) session.getAttribute("logid")));
    }


    @GetMapping("/reservationHistory")
    public void reservationHistory(Model model, HttpSession session){
        List<ReservationVO> list =  reservationMapper.searchReservation((String) session.getAttribute("logid"));
        model.addAttribute("list", list);
    }
    @GetMapping("/myReservation")
    public void myReservation(Model model, HttpSession session){
        model.addAttribute("member", mapper.selectMember((String) session.getAttribute("logid")));
    }
    @GetMapping("/myUpdate")
    public void myUpdate(Model model, HttpSession session){
        model.addAttribute("member", mapper.selectMember((String) session.getAttribute("logid")));
    }

    @PostMapping("update.do")
    public String updatedo(Model model, MemberVO member){
        mapper.updateMember(member);
        model.addAttribute("msg", "회원정보 수정이 완료되었습니다!");
        model.addAttribute("url", "myUpdate");
        return "user/alert";
    }

    @GetMapping("regMemberComplete")
    public void regMemberComplete(){}


}
