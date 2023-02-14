package org.green.seenema.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.ProductVO;

@Mapper
public interface ProductCRUDMapper {
	//상품등록
	public int insert(ProductVO product);
	
	//상품조회
	public ArrayList<ProductVO> getList();
	
	//상품코드로 상품조회하기
	public ProductVO selectOne(int productCode);
	
	//상품삭제
	public int delete(int productCode);
	
	//상품수정
	public int update(ProductVO product);
	
	//상품명으로 상품조회
	public ArrayList<ProductVO> getListByName(String productName);
}
