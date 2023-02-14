package org.green.seenema.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.MovieVO;
import org.green.seenema.vo.ProductVO;

@Mapper
public interface SalesMapper {
	public ArrayList<MovieVO> getMovieSales();
	
	public ArrayList<ProductVO> getProductSales();
	
	public ArrayList<MovieVO> getMovieTopfive();
	
	public ArrayList<ProductVO> getProductTopfive();
}
