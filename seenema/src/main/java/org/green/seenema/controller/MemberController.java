package org.green.seenema.controller;

import lombok.extern.slf4j.Slf4j;
import org.green.seenema.mapper.MemberMapper;
import org.green.seenema.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
@Slf4j
public class MemberController {
    @Autowired
    MemberMapper mapper;

    @GetMapping("/loginForm")  //로그인폼으로 가기
    public void loginFomr(){}
    @PostMapping("/login.do")  //로그인 확인
    public String login(MemberVO stu, HttpSession session, Model model) {
        int n = mapper.loginCheck(stu);
        if(n == 1) {
            session.setAttribute("logid", stu.getId());
            model.addAttribute("msg", stu.getId()+"님 로그인완료");
            model.addAttribute("url", "index");

        }else {
            model.addAttribute("msg", "아이디와 비밀번호를 다시 확인해주세요");
            model.addAttribute("url", "loginForm");
        }
        return "user/alert";
    }

    @GetMapping("/logout") //로그아웃
    public String logout(HttpSession session) {
        session.invalidate();

        return "user/main";
    }

    @GetMapping("/idcheck.do") //아이디 중복확인
    public @ResponseBody String idcheck(String id, Model model) {
        String msg = null;
        int n = mapper.idCheck(id);
        if(n == 1) {
            msg = "<span style = 'color : red';>사용불가</span>";
            model.addAttribute("msg", "<span style = 'color : red';>사용불가</span>");
        }else {
            msg = "<span style = 'color : green';>사용가능</span>";
            model.addAttribute("msg","<span style = 'color : green';>사용가능</span>");
        }

        return msg;
    }

    @GetMapping("/regMemberForm")
    public void regMemberForm(){}

    @PostMapping("/reg.do")
    public String regdo(MemberVO member){
        mapper.regMember(member);

        return "index";
    }


}
