package com.jhm.plather.service.impl;

import org.springframework.stereotype.Service;

import com.jhm.plather.model.PageDTO;
import com.jhm.plather.service.PageService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PageServiceImplV1 implements PageService {

	@Override
	public PageDTO makePagination(int totalList, int currentPage) {
		int listPerPage = 10;
		int navPerPage = 5;
		
		if(totalList < 1 ) return null;
		
		// 전체데이터가 1이상일때
		int totalPages = totalList/10;
		totalPages = totalList%10 == 0 ? totalPages : totalPages+1;
		int startPage = currentPage - (navPerPage/2);
		startPage = startPage <1 ? 1 : startPage;
		int endPage = startPage + navPerPage - 1;
		endPage = endPage > totalPages ? totalPages : endPage;
		int offset = (currentPage-1)* listPerPage;
		int limit = offset + listPerPage ;
		limit = limit > totalList ? totalList : limit;
		
		
		PageDTO pageDTO = PageDTO.builder().totalPages(totalPages)
				.startPage(startPage).endPage(endPage).offset(offset).limit(limit)
				.build();
		log.debug("PAGEDTO : {}",pageDTO);
		return pageDTO;
	}

}
