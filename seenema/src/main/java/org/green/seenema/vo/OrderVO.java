package org.green.seenema.vo;

import lombok.Data;

@Data
public class OrderVO {
	private Long orderNum;
	private	int productCode;
	private int price;
	private int count;
	private String id;
	private String orderDate;
	//======= 결제목록 ======//
	private String productName;
	private String productInfo;
	private int totalPrice;
	private int status;
	private String searchDate;
	private String productImage;
}
