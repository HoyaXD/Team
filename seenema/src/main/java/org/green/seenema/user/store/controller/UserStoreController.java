package org.green.seenema.user.store.controller;

import java.util.ArrayList;

import org.green.seenema.mapper.StoreMapper;
import org.green.seenema.vo.CartVO;
import org.green.seenema.vo.ProductVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/user")
@Slf4j
public class UserStoreController {
	
	@Autowired
	private StoreMapper mapper;
	
	// 스토어 페이지 이동
	@GetMapping("/storeView")
	public void storeView() {}
	
	// 내 장바구니로 이동
	@GetMapping("/myCart")
	public void myCart(String id, Model model) {
		ArrayList<CartVO> list = mapper.getCartList(id);
		model.addAttribute("list", list);
	}
	
	// 제품 상세보기 이동
	@GetMapping("/productDetailView")
	public void productDetailView(int pCode, Model model) {
		ProductVO product = mapper.getProductInfo(pCode);
		//log.info("컨트롤러 : " + product.toString());
		model.addAttribute("product", product);
	}
	
	// 카트에 상품 추가
	@PostMapping("/addCart.do")
	@ResponseBody
	public int addCart(CartVO cart) {
		int checkResult = mapper.checkCart(cart.getId(), cart.getProductCode());
		if(checkResult == 1) {
			// 이미 상품이 존재하면 -1 리턴
			return -1;
		}else {
			// 상품이 존재하지 않으면 1 리턴
			int result = mapper.addCart(cart);
			return result;
		}
	}
}
