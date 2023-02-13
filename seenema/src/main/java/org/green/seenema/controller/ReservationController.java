package org.green.seenema.controller;

import lombok.extern.slf4j.Slf4j;
import org.green.seenema.mapper.MovieMapper;
import org.green.seenema.mapper.ReservationMapper;
import org.green.seenema.mapper.TheaterCRUDMapper;
import org.green.seenema.vo.MovieVO;
import org.green.seenema.vo.TheaterVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@Slf4j
@RequestMapping("/user")
public class ReservationController {
    @Autowired
    ReservationMapper regMapper;
    @Autowired
    MovieMapper movieMapper;

    @Autowired
    TheaterCRUDMapper tcMapper;
    @GetMapping("/reservationMain")
    public void reservation(Model model){
        List<TheaterVO> tlist = tcMapper.getListGroupByPlace();
        List<MovieVO> mlist = movieMapper.getMovieList();
        log.info(mlist.get(0).getMovieTitle());
        model.addAttribute("tlist",tlist);
        model.addAttribute("mlist",mlist);
    }

    @GetMapping("/getMovieList.do") //영화목록 불러오기
    public @ResponseBody List<MovieVO> getMovieList(){
        return movieMapper.getMovieList();
    }

    @GetMapping("/getTheaterList.do") //영화관 정보 불러오기
    public @ResponseBody List<TheaterVO> TheaterList(String place){
        return tcMapper.getListWherePlace(place);
    }
}
