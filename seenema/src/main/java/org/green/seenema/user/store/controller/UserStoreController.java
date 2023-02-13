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
	public void storeView() {}
	
	// 내 장바구니로 이동
	@GetMapping("/myCart")
	public void myCart(String id, Model model) {
		ArrayList<CartVO> list = mapper.getCartList(id);
		model.addAttribute("list", list);
	}
	
	// 제품 상세보기 이동
	@GetMapping("/productDetailView")
	public void productDetailView(int productCode, Model model) {
		ProductVO product = mapper.getProductInfo(productCode);
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
	
	
	// 장바구니 개별삭제
	@PostMapping("/deleteProduct.do")
	@ResponseBody
	public int deleteUser(@RequestParam int productCode, @RequestParam String id) {
		//log.info(productCode + ", " + id);
		int result = mapper.deleteProduct(productCode, id);
		return result;
	}
	
	// 장바구니 선택삭제
	@PostMapping("/selectDelete.do")
	@ResponseBody
	public int selectDelete(@RequestParam("productCodes") int[] productCodes, String id) {
		int result = 0;
		for(int i = 0; i < productCodes.length; i++) {
			result = mapper.deleteProduct(productCodes[i], id);
		}
		return result;
	}
	
	@PostMapping("/updateProductCount.do")
	@ResponseBody
	public int updateProductCount(@RequestParam int productCode, @RequestParam String id, @RequestParam("count") int productCount) {
		int result = mapper.updateProductCount(productCode, id, productCount);
		return result;
	}
}
