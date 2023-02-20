package org.green.seenema.user.store.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.green.seenema.user.store.mapper.OrderMapper;
import org.green.seenema.user.store.mapper.StoreMapper;
import org.green.seenema.vo.CartVO;
import org.green.seenema.vo.OrderVO;
import org.green.seenema.vo.ProductVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/user")
@Slf4j
public class UserStoreController {
	
	@Autowired
	private StoreMapper mapper;
	
	// 스토어 페이지 이동
	@GetMapping("/storeView")
	public void storeView(Model model) {
		List<ProductVO> list = mapper.getProductList();
		model.addAttribute("list", list);
	}
	
	// 제품 상세보기 이동
	@GetMapping("/productDetailView")
	public void productDetailView(int productCode, Model model) {
		ProductVO product = mapper.getProductInfo(productCode);
		//log.info("컨트롤러 : " + product.toString());
		model.addAttribute("product", product);
	}
	
	// 내 장바구니로 이동
	@GetMapping("/myCart")
	public void myCart(String id, Model model) {
		List<CartVO> list = mapper.getCartList(id);
		model.addAttribute("list", list);
	}
	
	// 내 결제내역 이동
	@GetMapping("/myOrderList")
	public void myOrderList() {}
	
	// 결제내역 상세페이지
	@GetMapping("/orderDetailView")
	public void orderDetailView(Long orderNum, Model model) {
		model.addAttribute("orderNum", orderNum);
	}
}
