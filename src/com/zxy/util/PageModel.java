package com.zxy.util;

import java.util.List;

public class PageModel {
	private int curPage;
	private int pageSize;
	private List<?> list;
	private int totalRecords;
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public List<?> getList() {
		return list;
	}
	public void setList(List<?> list) {
		this.list = list;
	}
	public int getTotalRecords() {
		return totalRecords;
	}
	public void setTotalRecords(int totalRecords) {
		this.totalRecords = totalRecords;
	}
	
	//获取最大页面
	public int getTotalPage(){
		return (totalRecords+pageSize-1)/pageSize;
	}
	
	//取第一页
	public int getFirstPage(){
		return 1;
	}
	
	//取最后一页
	public int getLastPage(){
		return getTotalPage()<=0?1:getTotalPage();
	}
	
	//取上一页
	public int getPreviousPage(){
		
		if(curPage<=1){
			return 1;
		}
		return curPage-1;
	}
	
	//取下一页
	public int getNextPage(){
		if(curPage>=getTotalPage()){
			return getLastPage();
		}
		return curPage+1;
	}
}
