<?php

	class Pagination {
		
		protected currentPage
		protected totalPage
		protected leftNumberPages //NUMBER OF PAGES DISPLAYING ON THE LEFT SIDE OF THE CURRENT PAGE
		protected rightNumberPages //NUMBER OF PAGES DISPLAYING ON THE RIGHT SIDE OF THE CURRENT PAGE
		protected totalDisplayedPages
		protected firstPage
		protected defaultTag //PAGINATION HTML TAG
		protected pageGetName //GET QUERY PAGE NAME

		//CONSTRUCTOR : SET DEFAULT VALUE
		function __construct() {
		     	$this->leftNumberPages = 2;
		     	$this->rightNumberPages = 2;
		     	$this->totalDisplayedPages = leftNumberPages + rightNumberPages + 1; //CURRENT PAGE
		     	$this->firstPage = 1;
		     	$this->defaultTag = '<span>INDICE</span>';
		     	$this->pageGetName = 'page';
		}

		//SETTER
		//SET NUMBER TOTAL OF PAGES (REQUIRED)
		public function setTotalPage ( $arg ) {
			$this->totalPage = $arg;
		}	   

		//SET NUMBER OF PAGES DISPLAYING ON THE LEFT SIDE OF THE CURRENT PAGE
		//DEFAULT 2
		// 2 => X X CURRENTPAGE
		// 4 => X X X X CURRENTPAGE
		public function setLeftNumberPage ( $arg ) {
			$this->leftNumberPages = $arg;
		}
		
		//SET NUMBER OF PAGES DISPLAYING ON THE RIGHT SIDE OF THE CURRENT PAGE
		//DEFAULT 2
		// 2 => CURRENTPAGE X X
		// 4 => CURRENTPAGE X X X X
		public function setRightNumberPage ( $arg ) {
			$this->rightNumberPages = $arg;
		}
		
		//SET FIRST PAGE NUMBER
		//DEFAULT 1
		//EXAMPLE 0
		public function setFirstPage ( $arg ) {
			$this->firstPage = $arg;
		}
		
		//SET PAGINATION TAG
		//DEFAULT <span>INDICE</span>
		//INDICE REPLACED BY PAGE NUMBER (CURRENT PAGE = 5 => <span>5</span>
		//EXAMPLE : <b>INDICE</b>
		//EXAMPLE : <span class="myPageClass">INDICE</span>
		public function setDefaultTag ( $arg ) {
			$this->defaultTag = $arg;
		}
		
		//SET GET QUERY PAGE PARAMETER NAME
		//DEFAULT page
		//EXAMPLE : page_id, page_no ...
		public function setPageGetName ( $arg ) {
			$this->pageGetName = $arg;
		}

		//GET CURRENT PAGE FROM GET QUERY OR DEFAULT TO FIRST PAGE
		protected function GetCurrentPage ( ) {
			if ( ( isset($_GET[$this->pageGetName]) ) && ( !empty($_GET[$this->pageGetName]) ) ) { 
				$this->currentPage = (Int)$_GET[$this->pageGetName]; 
			} else { 
				$this->currentPage = $this->firstPage; 
			}
		}

		//SET PAGE URL WITH GET QUERY STRING
		protected function setUrl ( $pageIndice ) {

			$url = '?'; 

			if ( ( isset($_GET[$this->pageGetName]) ) && ( !empty($_GET[$this->pageGetName]) ) ) { 
				$url = $url . str_replace($this->pageGetName . '=' . $this->currentPage, $this->pageGetName . '=' . $pageIndice, $_SERVER['QUERY_STRING'], 1);
			} else {
				$url = $url . $this->pageGetName . '=' . $this->pageIndice . '&' . Request.ServerVariables("QUERY_STRING")
			}

			return $url; 

		}

		public function GetPaging ( ) { 
	
			$pagingText = '';
			$getParams = $_SERVER{'QUERY_STRING'};

			//CURRENT PAGE
			GetCurrentPage();
	
			//FIRST PAGE
			if ( $this->currentPage > $this->firstPage ) AND ( $this->totalPage > $this->firstPage ) { 
				$pagingText = $pagingText . str_replace('INDICE', '<a href="' . setUrl($this->firstPage) . '"> &lt;&lt; FIRST </a>', $this->defaultTag);
			}

			//PREVIOUS PAGE
			if ( $this->currentPage > $this->firstPage ) { 
				$pagingText = $pagingText . str_replace('INDICE', '<a href="' . setUrl($this->currentPage - 1) . '"> &lt; PREVIOUS </a>', $this->defaultTag);
			}
	
			//START PAGE
			if ( ( $this->currentPage - $this->leftNumberPages ) > $this->firstPage ) { 
				$this->pageStart = $this->currentPage - $this->leftNumberPages;
			} else { 
				$this->pageStart = $this->firstPage;
			} 
	
			//END PAGE
			if ( ( $this->currentPage + $this->rightNumberPages ) < $this->totalPage ) { 
				$this->pageEnd = $this->currentPage + $this->rightNumberPages;
			} else { 
				$this->pageEnd = $this->totalPage;
			}
	
			for ( $i = $this->pageStart ; $i < $this->pageEnd ; $i++ ) { 
				if ( $i == $this->currentPage ) { 
					$pagingText = $pagingText . str_replace('INDICE', ' ' . $i . ' ', $this->defaultTag);
				} else { 
					$pagingText = $pagingText . str_replace('INDICE', '<a href="' . setUrl($i) . '"> ' . $i . ' </a>', $this->defaultTag);
				}
			}

			//NEXT PAGE
			if ( $this->currentPage < $this->totalPage ) { 
				$pagingText = $pagingText . str_replace('INDICE', '<a href="' . setUrl($this->currentPage + 1) . '"> NEXT &gt; </a>', $this->defaultTag);
			}
	
			//LAST PAGE
			if ( $this->currentPage <> $this->totalPage ) {
				$pagingText = $pagingText . str_replace('INDICE', '<a href="' . setUrl($this->totalPage) . '"> LAST &gt;&gt; </a>', $this->defaultTag);
			}
	
			return $pagingText;	
	
		}

		//DESTRUCTOR
		function __destruct() {
		}
		
	}

?>
