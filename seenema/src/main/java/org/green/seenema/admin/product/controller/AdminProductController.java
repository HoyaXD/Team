package org.green.seenema.admin.product.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.green.seenema.mapper.ProductCRUDMapper;
import org.green.seenema.vo.ProductVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
public class AdminProductController {
	@Autowired
	ProductCRUDMapper mapper;
	
	@GetMapping("/productReg")
	public void regProduct() {
		//상품등록페이지
	}
	
	@PostMapping("/productReg.do")
	public String regProductDo(ProductVO product, @RequestParam("photoFileName") MultipartFile file, HttpServletRequest request, RedirectAttributes rs) {
		//상품등록실행
		String fileName = file.getOriginalFilename();
		
		product.setProductImage(fileName);
		
		ServletContext ctx = request.getServletContext();
		String uploadPath = "resources/imgs";
		String path = ctx.getRealPath(uploadPath);
		
		File saveFile = new File(path, file.getOriginalFilename());
		
		try {
			file.transferTo(saveFile);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int result = mapper.insert(product);
		rs.addAttribute("insert_result", result);
		
		return "redirect:productList";
	}
	
	@GetMapping("/productList")
	public void productList(Model model) {
		//상품조회페이지
		ArrayList<ProductVO> plist = mapper.getList();
		model.addAttribute("plist", plist);
	}
	
	@GetMapping("/productUpdate")
	public void productUpdate(int productCode, Model model) {
		//상품정보수정페이지
		ProductVO product = mapper.selectOne(productCode);
		model.addAttribute("p", product);
	}
	
	@PostMapping("/productUpdate.do")
	public String productUpdateDo(ProductVO product, @RequestParam("photoFileName") MultipartFile file, HttpServletRequest request, RedirectAttributes rs) {
		//상품정보 수정 실행

		String fileName = file.getOriginalFilename();
		
		int update_result = -1;
		
		if(fileName.equals("")) {
			update_result = mapper.update(product);
			rs.addAttribute("update_result", update_result);
			
			return "redirect:productList";
			
		}else {
			
			product.setProductImage(fileName);
			
			ServletContext ctx = request.getServletContext();
			String uploadPath = "resources/imgs";
			String path = ctx.getRealPath(uploadPath);
			
			File saveFile = new File(path, file.getOriginalFilename());
			
			try {
				file.transferTo(saveFile);
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			update_result = mapper.update(product);
			rs.addAttribute("update_result", update_result);
			
			return "redirect:productList";
		}
	}
	@GetMapping("/productDelete.do")
	public String productDeleteDo(int productCode, RedirectAttributes rs) {
		//상품정보 삭제
		int result = mapper.delete(productCode);
		rs.addAttribute("del_result", result);
		
		return "redirect:productList";
	}
	
	@GetMapping("/products_delete.do")
	public @ResponseBody int products_deleteDo(int[] productCodes) {
		//상품 선택 삭제 실행
		int del_result = 0;
		for(int i = 0; i < productCodes.length; i++) {
			del_result = mapper.delete(productCodes[i]);
		}
		return del_result;
	}
	
	@GetMapping("/getListByName.do")
	public @ResponseBody ArrayList<ProductVO> getListByName(String productName){
		//이름으로 상품 조회
		String _productName = "%" + productName + "%";
		ArrayList<ProductVO> listByName = mapper.getListByName(_productName);
		
		return listByName;
	}
	
	@GetMapping("/getListByPrice.do")
	public @ResponseBody ArrayList<ProductVO> getListByPrice(int price){
		//가격으로 상품 조회
		String _price = "%" + price + "%";
		ArrayList<ProductVO> listByPrice = mapper.getListByPrice(_price);
		
		return listByPrice;
	}
}
