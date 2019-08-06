package util;

public class PageNavigator {

	/**
	 * 페이징 네비게이터를 만들어주는 함수
	 * @param pageName		- 링크 페이지명
	 * @param totalCount	- 총수
	 * @param listCount		- 노출될 목록 게시물 수
	 * @param pagePerBlock	- 노출될 블록 수
	 * @param pageNum		- 페이지 번호
	 * @param addParam		- 추가 파라미터
	 * @return
	 */

	public String getPageNavigator(String pageName, int totalCount, int listCount, int pagePerBlock, int pageNum, String addParam) {
		
		StringBuffer sb = new StringBuffer();
		if(totalCount > 0) {
			int totalNumOfPage = (totalCount % listCount == 0) ? 
					totalCount / listCount :
					totalCount / listCount + 1;
			
			int totalNumOfBlock = (totalNumOfPage % pagePerBlock == 0) ?
					totalNumOfPage / pagePerBlock :
					totalNumOfPage / pagePerBlock + 1;
			
			int currentBlock = (pageNum % pagePerBlock == 0) ? 
					pageNum / pagePerBlock :
					pageNum / pagePerBlock + 1;
			
			int startPage = (currentBlock - 1) * pagePerBlock + 1;
			int endPage = startPage + pagePerBlock - 1;
			
			if(endPage > totalNumOfPage)
				endPage = totalNumOfPage;
			boolean isNext = false;
			boolean isPrev = false;
			if(currentBlock < totalNumOfBlock)
				isNext = true;
			if(currentBlock > 1)
				isPrev = true;
			if(totalNumOfBlock == 1){
				isNext = false;
				isPrev = false;
			}
			
			sb.append("<div class='aelf-nav-wrap'>");
			sb.append("<ul class='aelf-nav'>");
			
			if(pageNum > 1){
				sb.append("<li><a href=\"").append(pageName+"?pageNum=1"+addParam);
				sb.append("\" title=\"<<\"><<</a></li>");
			}
			if (isPrev) {
				int goPrevPage = startPage - pagePerBlock;			
				sb.append("<li><a href=\"").append(pageName+"?pageNum="+goPrevPage+addParam);
				sb.append("\" title=\"<\"><</a></li>");
			} else {
				
			}
			for (int i = startPage; i <= endPage; i++) {
				if (i == pageNum) {
					sb.append("<li class='active'><a href=\"#\" style='color: white !important;'>").append(i).append("</a></li>");
				} else {
					sb.append("<li><a href=\"").append(pageName+"?pageNum="+i+addParam);
					sb.append("\" title=\""+i+"\">").append(i).append("</a></li>");
				}
			}
			if (isNext) {
				int goNextPage = startPage + pagePerBlock;
	
				sb.append("<li><a href=\"").append(pageName+"?pageNum="+goNextPage+addParam);
				sb.append("\" title=\">\">></a></li>");
			} else {
				
			}
			if(totalNumOfPage > pageNum){
				sb.append("<li><a href=\"").append(pageName+"?pageNum="+totalNumOfPage+addParam);
				sb.append("\" title=\">>\">>></a></li>");
			}
			
			sb.append("</ul>");
			sb.append("</div>");
			
		}
		return sb.toString();
	}
	
	
	public String getPageNavigatorMobile(String pageName, int totalCount, int listCount, int pagePerBlock, int pageNum, String addParam) {
		
		StringBuffer sb = new StringBuffer();
		if(totalCount > 0) {
			int totalNumOfPage = (totalCount % listCount == 0) ? 
					totalCount / listCount :
					totalCount / listCount + 1;
			
			int totalNumOfBlock = (totalNumOfPage % pagePerBlock == 0) ?
					totalNumOfPage / pagePerBlock :
					totalNumOfPage / pagePerBlock + 1;
			
			int currentBlock = (pageNum % pagePerBlock == 0) ? 
					pageNum / pagePerBlock :
					pageNum / pagePerBlock + 1;
			
			int startPage = (currentBlock - 1) * pagePerBlock + 1;
			int endPage = startPage + pagePerBlock - 1;
			
			if(endPage > totalNumOfPage)
				endPage = totalNumOfPage;
			boolean isNext = false;
			boolean isPrev = false;
			if(currentBlock < totalNumOfBlock)
				isNext = true;
			if(currentBlock > 1)
				isPrev = true;
			if(totalNumOfBlock == 1){
				isNext = false;
				isPrev = false;
			}
			
			sb.append("<div class='aelf-nav-wrap'>");
			sb.append("<ul class='aelf-nav'>");
			
			if(pageNum > 1){
				sb.append("<li><a href=\"").append(pageName+"?pageNum=1"+addParam);
				sb.append("\" title=\"<<\" style=\"display: block;\"><<</a></li>");
			}
			if (isPrev) {
				int goPrevPage = startPage - pagePerBlock;			
				sb.append("<li><a href=\"").append(pageName+"?pageNum="+goPrevPage+addParam);
				sb.append("\" title=\"<\" style=\"display: block;\"><</a></li>");
			} else {
				
			}
			for (int i = startPage; i <= endPage; i++) {
				if (i == pageNum) {
					sb.append("<li class='active'>").append(i).append("</li>");
				} else {
					sb.append("<li><a href=\"").append(pageName+"?pageNum="+i+addParam);
					sb.append("\" title=\""+i+"\" style=\"display: block;\">").append(i).append("</a></li>");
				}
			}
			if (isNext) {
				int goNextPage = startPage + pagePerBlock;
	
				sb.append("<li><a href=\"").append(pageName+"?pageNum="+goNextPage+addParam);
				sb.append("\" title=\">\" style=\"display: block;\">></a></li>");
			} else {
				
			}
			if(totalNumOfPage > pageNum){
				sb.append("<li><a href=\"").append(pageName+"?pageNum="+totalNumOfPage+addParam);
				sb.append("\" title=\">>\" style=\"display: block;\">>></a></li>");
			}
			
			sb.append("</ul>");
			sb.append("</div>");
			
		}
		return sb.toString();
	}
	
}
