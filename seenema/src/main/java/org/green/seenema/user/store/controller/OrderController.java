package org.green.seenema.user.store.controller;

import java.util.List;

import org.green.seenema.mapper.OrderMapper;
import org.green.seenema.vo.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/user")
@Slf4j
public class OrderController {
	@Autowired
	private OrderMapper mapper;
	
	@PostMapping("/store/buy.do")
	@ResponseBody
	public int buy(OrderVO order) {
		int result = mapper.buy(order);
		return result;
	}
	
	@PostMapping("/store/buyProducts.do")
	@ResponseBody
	public int buyProducts(@RequestParam("orderNum") String orderNum
			, @RequestParam("productCodes") int[] productCodes
			, @RequestParam("prices") int[] prices
			, @RequestParam("counts") int[] counts, String id) {
		int result = 0;
		for(int i = 0; i < productCodes.length; i++) {
			OrderVO order = new OrderVO();
			order.setOrderNum(orderNum + (i + 1));
			order.setProductCode(productCodes[i]);
			order.setPrice(prices[i]);
			order.setCount(counts[i]);
			order.setId(id);
			
			result = mapper.buy(order);
		}
		return result;
	}
	
	// 내 결제내역 이동
	@GetMapping("/myOrderList")
	public void myOrderList(String id, Model model) {
		List<OrderVO> list = mapper.getOrderList(id);
	}
}
