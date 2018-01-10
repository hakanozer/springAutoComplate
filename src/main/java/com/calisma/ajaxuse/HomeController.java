package com.calisma.ajaxuse;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@Controller
public class HomeController {
	
	DB db = new DB();
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		return "home";
	}
	
	
	@RequestMapping(value={"/ajaxAra"},method=RequestMethod.GET,headers="Accept=*/*",produces = "application/json")  
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public  Map<String, List<Kullanici>> getTagList(@RequestParam("term") String ara) {
		Map<String, List<Kullanici>> hm = new HashMap<String, List<Kullanici>>();
        List<Kullanici> data = new ArrayList<Kullanici>();
        try {
        		String q = "select * from kullanici where  kadi like '%"+ara+"%' ";
			ResultSet rs = db.baglan().executeQuery(q);
			while(rs.next()) {
				Kullanici kl = new Kullanici();
				kl.setId(rs.getInt("kid"));
				kl.setAdi(rs.getString("kadi"));
				kl.setSoyadi(rs.getString("ksoyadi"));
				data.add(kl);
			}
		} catch (Exception e) {
			System.err.println("Data Arama Hatasi : " + e);
		}finally {
			db.kapat();
		}
        
        hm.put("key", data);
        return hm;
    }
	
	@RequestMapping(value = "/git/{id}", method = RequestMethod.GET)
	public String git(@PathVariable String id, Model model) {
		model.addAttribute("id", id);
		return "git";
	}
	
	
}