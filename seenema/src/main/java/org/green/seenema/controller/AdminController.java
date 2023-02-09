package org.green.seenema.controller;



import java.io.File;
import java.io.IOException;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.green.seenema.mapper.MovieCRUDMapper;
import org.green.seenema.mapper.TheaterCRUDMapper;
import org.green.seenema.vo.MovieVO;
import org.green.seenema.vo.TheaterVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
@RequestMapping("/admin")
@Controller
public class AdminController {
	@Autowired
	MovieCRUDMapper mapper;
	
	//--------------------영화 등록/수정/삭제
	@GetMapping("/movieReg")
	public void regMovie() {
		//영화 등록 페이지
	}
	
	@PostMapping("/movieUplode.do")
	public String uploadMovieDo(MovieVO movieVO, @RequestParam("photoFileName") MultipartFile file, HttpServletRequest request, RedirectAttributes rs) {
		//영화등록실행
		String fileName = file.getOriginalFilename();
		
		movieVO.setPostFileName(fileName);
		
		ServletContext ctx = request.getServletContext();
		String uploadPath = "resources/imgs";
		String path = ctx.getRealPath(uploadPath);
		
		File saveFile = new File(path, file.getOriginalFilename());
		
		try {
			file.transferTo(saveFile);
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int result = mapper.insertMovie(movieVO);
		
		rs.addAttribute("insert_result", result);
		
		return "redirect:movieList";
	}
	
	@GetMapping("/movieList")
	public void movieList(Model model) {
		//등록된 영화 목록 페이지
		
		ArrayList<MovieVO> mList = mapper.getList();
		model.addAttribute("mList", mList);	
	}
	
	@GetMapping("/movieUpdate")
	public void movieUpdate(int movieCode, Model model) {
		//영화 정보 수정 페이지
		
		MovieVO movie = mapper.selectOne(movieCode);
		model.addAttribute("movie", movie);
	}
	
	@PostMapping("/movieUpdate.do")
	public String movieUpdateDo(MovieVO movieVO, @RequestParam("photoFileName") MultipartFile file, HttpServletRequest request, RedirectAttributes rs) {
		//영화정보 수정 실행
		
		String fileName = file.getOriginalFilename();
		
		int update_result = -1;
		
		if(fileName.equals("")) {
			
			update_result = mapper.update(movieVO);
			rs.addAttribute("update_result", update_result);
			
			return "redirect:movieList";
			
		}else {
			
			movieVO.setPostFileName(fileName);
			ServletContext ctx = request.getServletContext();
			String uploadPath = "resources/imgs";
			String path = ctx.getRealPath(uploadPath);
			
			File saveFile = new File(path, file.getOriginalFilename());
			
			try {
				file.transferTo(saveFile);
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			update_result = mapper.update(movieVO);
			rs.addAttribute("update_result", update_result);
			
			return "redirect:movieList";
		}
	}
	@GetMapping("/movieDelete.do")
	public String moviedeleteDo(int movieCode, RedirectAttributes rs) {
		//영화 삭제 실행
		int del_result = mapper.delete(movieCode);
		rs.addAttribute("del_result", del_result);
		
		return "redirect:movieList";
	}
	
	@GetMapping("/movies_delete.do")
	public @ResponseBody int movies_deleteDo(int[] movieCodes) {
		//영화 선택 삭제 실행
		int del_result = 0;
		for(int i = 0; i < movieCodes.length; i++) {
			del_result = mapper.delete(movieCodes[i]);
		}
		return del_result;
	}
	
	//--------------------영화관 등록/수정/삭제/조회
	@Autowired
	TheaterCRUDMapper tmapper; 
	
	@GetMapping("/theaterReg")
	public void theaterReg() {
		//영화관 등록페이지
	}
	
	@PostMapping("/theaterReg.do")
	public String theaterRegDo(TheaterVO theaterVO, RedirectAttributes rs) {
		//영화관 등록실행
		int insert_result = tmapper.insertTheater(theaterVO);
		rs.addAttribute("insert_result", insert_result);
		
		return "redirect:theaterList";
	}
	
	@GetMapping("/theaterList")
	public void theaterList(Model model) {
		//영화관 조회페이지

		ArrayList<TheaterVO> tList = tmapper.getList();
		model.addAttribute("tList", tList);	
	}
	
	@GetMapping("/theaterUpdate")
	public void theaterUpdate(int theaterCode, Model model) {
		//영화관 정보 수정 페이지
		
		TheaterVO theater = tmapper.selectOne(theaterCode);
		model.addAttribute("theater", theater);
		
	}
	@PostMapping("/theaterUpdate.do")
	public String theaterUpdateDo(TheaterVO theaterVO, RedirectAttributes rs) {
		//영화관 정보 수정 실행
		int update_result = tmapper.update(theaterVO);
		rs.addAttribute("update_result", update_result);
		
		return "redirect:theaterList";
	}
	@GetMapping("/theaterDelete.do")
	public String theaterDeleteDo(int theaterCode, RedirectAttributes rs) {
		//영화관 삭제 실행
		int del_result = tmapper.delete(theaterCode);
		rs.addAttribute("del_result", del_result);
		
		return "redirect:theaterList";
	}
	
	@GetMapping("/test2")
	public void test() {
		
	}
}
