package org.green.seenema.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.TheaterVO;

@Mapper
public interface TheaterCRUDMapper {
	//등록
	public int insertTheater(TheaterVO theaterVO);
	
	//조회
	public ArrayList<TheaterVO> getList();
	
	//코드로 조회
	public TheaterVO selectOne(int theaterCode);
	
	//이름으로 조회
	public ArrayList<TheaterVO> getListByName(String theaterName);
	
	//지역으로 조회
	public ArrayList<TheaterVO> getListByPlace(String theaterPlace);
	
	//연락처로 조회
	public ArrayList<TheaterVO> getListByTel(String theaterTel);
	
	//수정
	public int update(TheaterVO theaterVO);
	
	//삭제
	public int delete(int theaterCode);

	public ArrayList<TheaterVO> getListGroupByPlace();

	public ArrayList<TheaterVO> getListWherePlace(String place);
}
