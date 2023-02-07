package org.green.seenema.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TheaterVO {
   private int theaterCode;         //영화관코드
   private String theaterPlace;      //영화관지역
   private String theaterName;         //상영관
   private String theaterAddress;      //영화관주소
   private String theaterTel;         //영화관연락처
   private int theaterSeats;         //상영관좌석수
}
