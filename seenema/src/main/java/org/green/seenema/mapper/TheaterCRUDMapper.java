package org.green.seenema.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.TheaterVO;

@Mapper
public interface TheaterCRUDMapper {
	
	public int insertTheater(TheaterVO theaterVO);
	
	public ArrayList<TheaterVO> getList();
	
	public TheaterVO selectOne(int theaterCode);
	
	public int update(TheaterVO theaterVO);
	
	public int delete(int theaterCode);

	public ArrayList<TheaterVO> getListGroupByPlace();

	public ArrayList<TheaterVO> getListWherePlace(String place);
}
