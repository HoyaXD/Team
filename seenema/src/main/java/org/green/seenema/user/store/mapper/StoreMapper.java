package org.green.seenema.user.store.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.green.seenema.vo.CartVO;
import org.green.seenema.vo.ProductVO;

@Mapper
public interface StoreMapper {
	public ProductVO getProductInfo(int productCode);
	public int addCart(@Param("cart") CartVO cart);
	public int checkCart(@Param("id") String id, @Param("productCode") int productCode);
	public List<CartVO> getCartList(String id);
	public int deleteProduct(@Param("productCode") int productCodes, @Param("id")String id);
	public int updateProductCount(@Param("productCode") int productCode, @Param("id")String id, @Param("productCount") int count);
	
	public List<ProductVO> getProductList();
}
