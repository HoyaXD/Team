package org.green.seenema.admin.theater.controller;

import java.util.ArrayList;

import org.green.seenema.mapper.TheaterCRUDMapper;
import org.green.seenema.vo.TheaterVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin")
public class AdminTheaterController {
	
	@Autowired
	TheaterCRUDMapper tmapper;
	
	@GetMapping("/theaterShcByName.do")
	public @ResponseBody ArrayList<TheaterVO> theaterSerchByNameDo(String name) {
		String _name = "%" + name + "%";
		ArrayList<TheaterVO> list = tmapper.getListByName(_name);
		
		return list;
	}
	
	@GetMapping("/theaterShcByPlace.do")
	public @ResponseBody ArrayList<TheaterVO> theaterShcByPlaceDo(String place){
		String _place = "%" + place + "%";
		ArrayList<TheaterVO> list = tmapper.getListByPlace(_place);
		
		return list;
	}
	
	@GetMapping("/theaterShcByTel.do")
	public @ResponseBody ArrayList<TheaterVO> theaterShcByTelDo(String tel){
		
		String _tel = "%" + tel + "%";
		ArrayList<TheaterVO> list = tmapper.getListByTel(_tel);
		
		return list;
	}
}
