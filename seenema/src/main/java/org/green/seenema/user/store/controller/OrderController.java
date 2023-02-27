package org.green.seenema.user.store.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.green.seenema.user.store.mapper.OrderMapper;
import org.green.seenema.vo.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/user")
@Slf4j
public class OrderController {
	@Autowired
	private OrderMapper mapper;

	// 개별구매
	@PostMapping("/order/buy.do")
	public int buy(OrderVO order) {
		int result = mapper.buy(order);
		return result;
	}
	
	// 일괄구매
	@PostMapping("/order/buyProducts.do")
	public int buyProducts(@RequestParam("orderNum") Long orderNum
			, @RequestParam("productCodes") int[] productCodes
			, @RequestParam("prices") int[] prices
			, @RequestParam("counts") int[] counts
			, @RequestParam("id") String id
			, @RequestParam("userName") String userName) {
		int result = 0;
		for(int i = 0; i < productCodes.length; i++) {
			OrderVO order = new OrderVO();
			order.setOrderNum(orderNum + (i + 1));
			order.setProductCode(productCodes[i]);
			order.setPrice(prices[i]);
			order.setCount(counts[i]);
			order.setId(id);
			order.setUserName(userName);
			
			result = mapper.buy(order);
		}
		return result;
	}
	
	// 결제내역 목록 가져오기
	@GetMapping("/order/getOrderList.do")
	public List<OrderVO> getOrderList(String id) {
		List<OrderVO> list = mapper.getOrderList(id);
		return list;
	}
	
	// 결제내역 날짜선택 조회
	@PostMapping("/order/searchGetOrderList.do")
	public List<OrderVO> getSearchOrderList(String id, String startDate, String endDate, int status){
		List<OrderVO> list = mapper.getSearchOrderList(id, startDate, endDate, status);
		return list;
	}
	
	// 결제 상세페이지 정보 가져오기
	@GetMapping("/order/getDetail.do")
	public OrderVO getDetail(Long orderNum){
		OrderVO order = mapper.getOrderDetail(orderNum);
		return order;
	}
	
	// 결제 취소
	@PostMapping("/order/refund.do")
	public int refund(Long orderNum) {
		int result = mapper.refund(orderNum);
		return result;
	}
}
