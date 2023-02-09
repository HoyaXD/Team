package org.green.seenema.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.MovieVO;

//영화 등록/삭제/조회/수정 interface

@Mapper
public interface MovieCRUDMapper {
	public int insertMovie(MovieVO movieVO);
	
	public ArrayList<MovieVO> getList();
	
	public MovieVO selectOne(int movieCode);
	
	public int update(MovieVO movieVO);
	
	public int delete(int movieCode);
}
