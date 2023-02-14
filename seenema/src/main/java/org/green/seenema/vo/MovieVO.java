package org.green.seenema.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MovieVO {
	private int movieCode;  //영화코드
	private String movieTitle;  //영화제목
	private String genre;  //장르
	private String plot;  //줄거리 
	private String director;  //감독
	private String actors;  //배우
	private int viewAge;  //관람연령
	private Date releaseDate; //개봉일
	private int runningTime;  //러닝타임
	private String postFileName;  //파일이름
	private String previewURL;  //예고편URL
	private int hit; //영화 예매율
}
