package org.green.seenema.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.green.seenema.vo.CartVO;
import org.green.seenema.vo.ProductVO;

@Mapper
public interface StoreMapper {
	public ProductVO getProductInfo(int productCode);
	public int addCart(@Param("cart") CartVO cart);
	public int checkCart(@Param("id") String id, @Param("productCode") int productCode);
	public ArrayList<CartVO> getCartList(String id);
}
