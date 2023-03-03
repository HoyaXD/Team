package org.green.seenema.user.store.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import org.green.seenema.user.store.mapper.OrderMapper;
import org.green.seenema.vo.OrderVO;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

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
		if(result == 1) {
			// 제품테이블 sales 반영
			mapper.updateProductSales(order.getProductCode());
		}
		return result;
	}
	
	final DefaultMessageService messageService;
	
    public OrderController() {
        // 반드시 계정 내 등록된 유효한 API 키, API Secret Key를 입력해주셔야 합니다!
        this.messageService = NurigoApp.INSTANCE.initialize("NCS0TQ1V5STWBKVT", "KKMQT9E1WQINBFDSFZSE89QKAJ4NIW0I", "https://api.coolsms.co.kr");
    }
    
    // coolSms
	@PostMapping("/send-one")
 	public SingleMessageSentResponse sendOne(String orderNum) {
      Message message = new Message();
      // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
      message.setFrom("01025955462");
      message.setTo("01025955462");	// 고객 전화번호 필요
      message.setText("[SEENEMA]\n고객님의 기프티콘 번호는\n" + orderNum + "\n입니다.");

      SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
      //System.out.println(response);
      return response;
    }
	
	// 일괄구매
	@PostMapping("/order/buyProducts.do")
	public int buyProducts(@RequestParam("orderNum") Long orderNum
			, @RequestParam("productCodes") int[] productCodes
			, @RequestParam("prices") int[] prices
			, @RequestParam("counts") int[] counts
			, @RequestParam("id") String id
			, @RequestParam("userName") String userName
			, @RequestParam("refundCode") String refundCode) {
		int result = 0;
		for(int i = 0; i < productCodes.length; i++) {
			OrderVO order = new OrderVO();
			order.setOrderNum(orderNum + (i + 1));
			order.setProductCode(productCodes[i]);
			order.setPrice(prices[i]);
			order.setCount(counts[i]);
			order.setId(id);
			order.setUserName(userName);
			order.setRefundCode(refundCode);
			
			result = mapper.buy(order);
			if(result == 1) {
				// 제품테이블 sales 반영
				mapper.updateProductSales(order.getProductCode());
			}
		}
		return result;
	}
	
	// 결제내역 목록 가져오기
	@GetMapping("/order/getOrderList.do")
	public List<OrderVO> getOrderList(String id, int pageNum) {
		int count = (pageNum - 1) * 10;
		List<OrderVO> list = mapper.getOrderList(id, count);
		return list;
	}
	
	// 결제내역 날짜선택 조회
	@PostMapping("/order/searchGetOrderList.do")
	public List<OrderVO> getSearchOrderList(String id, String startDate, String endDate, int status, int pageNum){
		int count = (pageNum - 1) * 10;
		if(status == 0) {
			List<OrderVO> list = mapper.getOrderList(id, count);
			return list;
		}else {
			List<OrderVO> list = mapper.getSearchOrderList(id, startDate, endDate, status, count);
			return list;
		}
	}
	
	// 결제 상세페이지 정보 가져오기
	@GetMapping("/order/getDetail.do")
	public OrderVO getDetail(Long orderNum){
		OrderVO order = mapper.getOrderDetail(orderNum);
		return order;
	}
	// 토큰
	public String getToken() {
		String accessToken = null;
		try {
            URL url = new URL("https://api.iamport.kr/users/getToken");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            String data = "{\"imp_key\":\"7535084063571635\", \"imp_secret\":\"Eg7VY4XzIifAIozHhwg4X8HYlUONAzTTXG72Vr5ngfDzDptJlQmMloOiwFfDz4LnGXUm63swSGcX5ryE\"}";

            OutputStream os = conn.getOutputStream();
            os.write(data.getBytes("UTF-8"));
            os.flush();
            os.close();

            BufferedReader in = new BufferedReader(
                new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode rootNode = objectMapper.readTree(response.toString());
            accessToken = rootNode.get("response").get("access_token").asText();
            System.out.println("Access token: " + accessToken);
        } catch (Exception e) {
            e.printStackTrace();
        }
		return accessToken;
	}
	
	// 결제 취소
	@PostMapping("/order/refund.do")
	public int refund(String refundCode) {
		String token = getToken();
		try {
	        URL url = new URL("https://api.iamport.kr/payments/" + refundCode + "/cancel");
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Content-Type", "application/json");
	        conn.setRequestProperty("Authorization", token);
	        conn.setDoOutput(true);

	        JSONObject json = new JSONObject();
	        json.put("reason", "고객요청");

	        OutputStream os = conn.getOutputStream();
	        os.write(json.toString().getBytes("UTF-8"));
	        os.flush();
	        os.close();

	        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        String inputLine;
	        StringBuffer response = new StringBuffer();
	        while ((inputLine = in.readLine()) != null) {
	            response.append(inputLine);
	        }
	        in.close();

	        int statusCode = conn.getResponseCode();
	        if (statusCode == 200) {
	            return 1;
	        } else {
	            return -1;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return 0;
	}
	
	// 결제 취소 상태 변경
	@PostMapping("/order/changeStatus.do")
	public int changeStatus(Long orderNum) {
		int result = mapper.refund(orderNum);
		return result;
	}
	// 페이징
	@GetMapping("/order/getOrderCount.do")
	public int getOrderCount(String id, int status) {
		if(status == 0) {
			// 전체조회 행 갯수
			int result = mapper.getOrderCount(id);
			return result;
		}else {	
			// 만약 결제취소나 결제완료를 선택했을 경우 행 갯수
			int result = mapper.getSearchOrderCount(id, status);
			return result;
		}
	}
}