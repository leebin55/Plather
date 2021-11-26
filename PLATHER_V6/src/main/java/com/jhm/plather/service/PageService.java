package com.jhm.plather.service;

import com.jhm.plather.model.PageDTO;

public interface PageService {

	public PageDTO makePagination(int totalList, int currentPage);
}
