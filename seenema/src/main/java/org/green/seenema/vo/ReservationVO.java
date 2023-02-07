package org.green.seenema.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class ReservationVO {
	private String id;
	private int ticketCode;
	private int movieCode;
	private String movieTitle;
	private String theaterPlace;
	private String theater;
	private int ticketPrice;
	private Timestamp reservationDate;
	private int reservateTime;
	private String seats;
	private int visitors;
}
