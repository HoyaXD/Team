package org.green.seenema.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MovieVO {
	private int movieCode;
	private String movieTitle;
	private String genre;
	private String plot;
	private String director;
	private String actors;
	private int viewAge;
	private Timestamp releaseDate;
	private int runningTime;
	private String postFileName;
	private String previewURL;
}
