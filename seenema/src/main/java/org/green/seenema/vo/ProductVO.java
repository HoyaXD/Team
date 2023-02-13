package org.green.seenema.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class ProductVO {
	private int productCode;
	private String productName;
	private String productInfo;
	private int price;
	private String productImage;
	private int productSales;
	private String category;
}
