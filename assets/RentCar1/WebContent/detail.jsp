<%@page import="db.CarViewBean"%>
<%@page import="java.util.Vector"%>
<%@page import="db.RentcarDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>

<head>
    <title>HERMES Rent Car</title>
    <meta charset="UTF-8">
    <title>공지사항목록</title>
    
    <link href="/css/customer/layout.css" type="text/css" rel="stylesheet" />
 <style>
    
        #visual .content-container{	
            height:inherit;
            display:flex; 
            align-items: center;
            
            background: url("../../images/customer/visual.png") no-repeat center;
        }
     
   
    
/* 요소(element) 여백 초기화  */
html, body,
div, span,
dl, dt, dd, ul, ol, li,
h1, h2, h3, h4, h5, h6,
blockquote, p, address, pre, cite,
form, fieldset, input, textarea, select,
table, th, td {
	margin:0;
	padding:0;
	}

/* 제목요소 */
h1, h2, h3, h4, h5, h6 {  
	font-size:inherit;   
	font-weight:inherit;   
	} 

/* 테두리 없애기 */
fieldset, img, abbr,acronym { border:0 none; } 

/* 목록 */
ol, ul { list-style:none; margin: 0; padding: 0;}

/* 테이블 - 마크업에 'cellspacing="0"' 지정 함께 필요 */
table {
	border-collapse: separate;
	border-spacing:0;
	border:0 none;
	}
caption, th, td {
	text-align:left;
	font-weight: normal;
}

/* 텍스트 관련 요소 초기화 */
address, caption, strong, em, cite {
	font-weight:normal;
	font-style:normal;
	}
ins { text-decoration:none; }
del { text-decoration:line-through; }

/* 인용문 */
blockquote:before, blockquote:after, q:before, q:after { content:""; }
blockquote,q { quotes:"" ""; }

/* 수평선*/
hr { display:none; }

blockquote {
    margin: 0 0 1rem;
}

/* 하이퍼링크*/
a{
	text-decoration: none;
	color:inherit;
}
a:hover{
	text-decoration: underline;
}


/*--- reset style -----------------------------------------------------------*/
body{
	margin:0px;
}

h1{
	margin:0px;
}

ul{
	padding:0px;	
	margin:0px;
}

li{
	display: block;
}

a{
	text-decoration: none;
	color:inherit;
}

table{
	border-spacing: 0px;
	table-layout: fixed;
}


/*--- -------------- -----------------------------------------------------------*/

.h-60px{
	height: 60px;
}



/* 구조변경에 용이한 선택자 */
.content-container{	
	height: 100%;
	width: 960px;
	margin:auto;
	/* margin-left:auto;
	margin-right: auto; */
}
/* ----------<level 3>------------------------------ */

#body{	
	min-height: 300px;
	border-top:5px solid #8CBA34;
	margin-top:1px;
}

#body > .content-container{ 
	background:url("../images/bg-body.png") repeat-y center;
	position: relative;
	padding-bottom:30px;
	/*clearfix*/
	overflow: auto;
  	zoom: 1;
}

main {
	box-sizing:border-box;
	min-height: inherit;
	width: calc(100% - 205px);/* 755px; */	
	float:left;
}



/* === <Component Style For All Media>=================================================== */

/* ----#main-menu--------------------------------------- */

#main-menu{		
	display: inline-block;	
}

#main-menu a {
	font-family: "맑은 고딕";
	font-weight: bold;
	font-size: 15px;
	
	color: #000;
	text-decoration: none;
}

#main-menu a:hover {
	color: #ff6a00;	
}

#main-menu > h1{
	display: none;
}

#main-menu > ul{	
	overflow: auto;
}

#main-menu > ul > li{
	float: left;	
	padding-left: 24px;
	background: url("../images/bg-main-menu-vsp.png") no-repeat 13px center;	
}

#main-menu > ul > li:first-child{		
	padding-left: 0px;
	background: none;	
}

	/* -----#search-form-------------------------------------- */
	#search-form{
		border:5px solid #8cba34;
		display: inline-block;
		overflow: auto;
	}
	
	#search-form h1,
	#search-form legend{
		display: none;
	}
	
	#search-form label{	
		height: 25px;	
		line-height:25px;
		display: block;	
		float:left;
		
		font-family: "돋움", Arial, sans-serif;
		font-size: 11px;
		font-weight:bold;
		color:#979797;
		
		background: #ffffff;
		padding-left:5px;
		padding-right:5px;
	}
	
	#search-form input[type="text"]{
		width:222px;
		height: 25px;
		border:0px;	
		display: block;
		float:left;
		text-indent: 5px;
	}
	
	#search-form input[type=submit]{
		background: url("../images/btn-zoom.png") no-repeat center;
		width:31px;
		height: 25px;
		border: 0px;
		vertical-align: middle;
		display: block;	
		float:left;
		border-left:1px solid #8cba34;
		
		text-indent: -999px;
	}


/* === <Desktop Only> ===================================================================== */

/* @media all and (min-width:961px){	 */
		
	#header {
		position: static;
		display: block;
		height: 70px;
		padding: 0px;
		border-bottom: 3px solid #8CBA34;
	}
	
	#header .content-container {
		display: block;
		width: 960px;
		box-sizing: border-box;
		position: relative;
		margin-left: auto;
		margin-right: auto;
	}
	
	#header .hamburger-button {
		display: none;
	}
	#header .search-button {
		display: none;
	}
	#header .content-container {
		text-align: unset;
		position: relative;
		margin-left: auto;
		margin-right: auto;
		height: inherit;
	}
	#header .content-container .logo {
		display: inline-block;
		position: absolute;
		left: 0px;
		top: 23px;
	}
	#header .content-container .main-menu {
		
	}
	.sub-menu.top h1 {
		
	}
	
	
	#header .content-container{
		position: relative;
		align-items: center;
	}
	
	.hamburger-button,
	.search-button,
	.more-vert-button
	{
		display: none;
	}
	
	#logo{	
		position: absolute;
		left:0px;
		top:23px;
	}
	
	/* ----#main-menu--------------------------------------- */
	
	#main-menu{			
		position: absolute;
		left:200px;
		top:27px;
	}
	
	/* -----#search-form----------------------------- */
	#search-form{
		position: absolute;
		left:468px;
		top:21px;
	}
	
	/* -----#acount-menu------------------------------- */
	#acount-menu{
				
		position: absolute;
		right:0px;
		top:20px;
	}
	
	#acount-menu a{
		
		display: inline-block;
		font-family: "맑은 고딕", "고딕", sans-serif;
		font-size: 10px;
		font-weight: bold;	
		
		color:#979797;
		text-decoration: none;
	}
	
	#acount-menu a:hover{
		text-decoration:underline;
	}
	
	#acount-menu > ul{	
		overflow: auto;
	}
	
	#acount-menu > ul > li{
		float:left;
		padding-left: 9px;
		background: url("../images/bg-member-menu-sp.png") no-repeat 5px center; 
	}
	
	#acount-menu > ul > li:first-child{	
		padding-left: 0px;
		background: none; 
	}
	
	/* ------#member-menu-------------------------------- */
	
	#member-menu{
		position: absolute;
		right:0px;
		top:40px;
	}

/* } */



#footer{
	background: #313131;	
	height: 100px;
	padding:20px;	
}

#footer .content-container{
	display: flex;
	flex-flow:row wrap;
	flex:1;
}

#footer-logo{
	width:205px;
}

#company-info{
	width:755px;
	display: flex;
	flex-flow:column;
}

#company-info dl{
	display: flex;
	flex-flow:row wrap;	
}

#company-info dl dd{
	margin-right:50px;
}


/* --- mobile ----------------------------------------------------- */
 #footer {
    height: 50px;
    line-height: 50px;
    background: #313131;
    color: #fff;
    font-size: 13px;
    text-align: center;
} 


.aside {
	min-height: inherit;
	width: 205px;
	float: left;
	background: url("../images/bg-aside-title.png") no-repeat;
}

.aside .margin-top{
	margin-top: 45px;
}

.aside > h1 {
	font-family: 맑은 고딕, 고딕, sans-serif;
	font-size: 24px;
	font-weight: bold;
	color: #000;
	margin-top: 43px;
}

.aside .menu.text-menu {
	margin-top: 20px;
	width: 180px;
}

.aside .menu.text-menu > h1 {
	font-family: 맑은 고딕, 고딕, sans-serif;
	font-size: 13px;
	font-weight: bold;
	color: #000;
	padding-left: 26px;
	background: url(../images/icon-recommend.png) no-repeat left center;
}

.aside .menu.text-menu li {
	background: url("../images/bg-aside-menu-hsp.png") repeat-x left bottom;
	height: 26px;
	line-height: 26px;
}

.aside .menu.text-menu li:last-child {
	border-bottom: 1px solid #d9d9d9;
	background: none;
}

.aside .menu.text-menu li .current {
    background: url(../images/icon-current.png) no-repeat 15px center;
}

.aside .menu.text-menu li a {
	font-family: 맑은 고딕, 고딕, sans-serif;
	font-weight: bold;
	color: #808080;
	padding-left: 26px;
	text-decoration: none;
}

.aside .menu.text-menu a:hover, .aside-menu .active {
	background: url("../images/icon-current.png") no-repeat 15px center;
}

.aside .menu.first {
	margin-top: 45px;	
}

.aside .menu.first > h1 {
	color: #ffffff;
	height: 27px;
	line-height: 27px;
	padding-left: 10px;
	font-size: 12px;
	font-weight: bold;
	text-shadow: 0.5px 0.5px 1px #000000;
	background: url(../images/bg-aside-sub-title.png) no-repeat 0px 0px;
}

.aside .menu.text-menu.first ul,
.aside .menu.text-menu.first .list {
	border-top: none;
	margin-top: 0px;
}

.aside .menu {
	margin-top: 20px;
}

.aside .menu > h1 {
	font-family: 맑은 고딕, 고딕, sans-serif;
	font-size: 13px;
	font-weight: bold;
	color: #000;
	padding-left: 26px;
	background: url("../images/icon-recommend.png") no-repeat left center;
}

.aside .menu > ul {
	margin-top: 10px;
}

/* ==== Desktop만을 위한 Style -- 너비 960px 이상 =========================================================== */
@media all and (min-width:960px) {
}

/* ==== 테블릿 이하에서 달라질 공통 Style 오버라이드-- 너비 959px 이하 =========================================================== */
@media all and (max-width:959px) {
	#aside {		
		position: fixed;
		top: 0px;
		left: -205px;
		height: 100%;
		background: #ffffff;
		z-index: 101;
	}
}

/* ==== 중간 크기 장치만을 위한 Style -- 너비 640px~ 959px=========================================================== */
@media all and (min-width:640px) and (max-width:959px) {
		#aside {		
		position: fixed;
		top: 0px;
		left: -205px;
		height: 100%;
		background: #ffffff;
		z-index: 101;
	}
}

/* ==== 스마트 폰처럼 작은 크기 장치만을 위한 Style -- 너비 639px 이하=========================================================== */
@media all and (max-width:639px) {
}

main {
	position: relative;
	min-height: inherit;
	width: 755px;
	padding-left: 35px;
	padding-top: 45px;
	padding-bottom:80px;
	float: left;
	display: flex;
	flex-direction: column;
}

main .stretch-child{
	display: flex;	
	align-items: stretch;
	align-content: stretch;	
}

main .stretch-child textarea{
	align-self: stretch;
}

main .h300{
	height: 300px;
}

main .width-match{
	width:100%;
}

main .bg-wood {
	background: url("../images/course/bg-wood.png");
}

main .border-bottom {
	border-bottom: 1px solid #e9e9e9;
}

main .border-hard{	    
    border: 5px solid #8CBA34;    
    text-align: center;
}

main .align-left {
	align-self: flex-start;
}

main .align-center {
	align-self: center;
}

main .align-right {
	align-self: flex-end;
}

main .valign-middle {
	vertical-align: middle;
}

main .title {
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

main .title.main {
	font-family: 맑은 고딕, 고딕, sans-serif;
	font-size: 21px;
	font-weight: bold;
	color: #646464;
	padding-left: 25px;
	background: url("../images/icon-main-title.png") no-repeat left center;
}

main .title.sub {
	font-family: 맑은 고딕;
	font-size: 14px;
	font-weight: bold;
	color: #191919;
	height: 30px;
	line-height: 30px;
	padding-left: 20px;
	background: url("../images/icon-sub-title.png") no-repeat 0px 10px;
}

main .margin-top {
	margin-top: 10px;
}

main .margin-top-20 {
	margin-top: 20px;
}

main .margin-bottom {
	margin-bottom: 10px;
}

main .padding-bottom {
	padding-bottom: 10px;
}

main .margin-top.first {
	margin-top: 49px;
}

/* --- border style------------------------------------------------------------------------- */
main .border-dashed{
	border : 2px dashed #e9e9e9;
}

/* --- breadcrumb ----------------------------------------------------------------------------- */
main .breadcrumb {
	position: absolute;
	right: 0px;
	top: 57px;
}

main .breadcrumb .list, main .breadcrumb ul {
	overflow: auto;
}

main .breadcrumb .item, main .breadcrumb li {
	float: left;
	padding-left: 10px;
	background: url("../images/icon-path.png") no-repeat left center;
}

main .breadcrumb .item:first-child, main .breadcrumb li:first-child {
	padding-left: 20px;
	background: url("../images/icon-home.png") no-repeat left center;
}

/* --- search-form ----------------------------------------------------------------------------------------- */
main .search-form, main .search-form form {
	display: inline-block;
}

main .search-form form fieldset>* {
	vertical-align: middle;
}

main .search-form select {
	height: 20px;
	border: 1px solid #8CBA34;
}

main .search-form input[type="text"] {
	width: 150px;
	height: 20px;
	border: 1px solid #8CBA34;
}

/*---< pager style >-----------------------------------------------------------------------------*/

.pager
{
    display:inline-block;
}

.pager-list,
.pager > ul
{
    float:left;
}

.pager-item,
.pager > div
{
    float:left;
    width:15px;
    height:15px;
    line-height:15px;
    text-align:center;
}

.pager li{
	width:15px;
	height: 15px;
	line-height: 15px;
	text-align: center;
	vertical-align: middle;
}

.pager-item:hover,
.pager > div:hover
{
    text-decoration:underline;
}

.pager-item .btn-prev,
.pager > div:first-child a,
.pager > div:first-child span
{
	width:15px;
	height:15px;
	background: url("../images/btn-prev.png") no-repeat center;
}

.pager-item .btn-prev,
.pager > div:last-child a,
.pager > div:last-child span
{
	width:15px;
	height:15px;
	background: url("../images/btn-next.png") no-repeat center;
}

/* --- table style ----------------------------------------------------------------------- */
main .table {
	display: table;
	table-layout: fixed;
	width: 100%;
	border-top: 2px solid #8cba35;
}

main .table input[type=text],
main .table input[type=password],
main .table input[type=email],
main .table input[type=date],
main .table input[type=number],
main .table select
{
	width:90%;
	vertical-align: middle;
	height: 24px;
	line-height: 24px;
	text-indent: 5px;
	border:1px solid #e9e9e9;
	border-radius: 5px; 
}

main .table input[type=text].width-auto,
main .table input[type=password].width-auto,
main .table input[type=number].width-auto,
main .table select.width-auto{
	width: auto;
}

main .table input[type=text].width-half,
main .table input[type=password].width-half,
main .table input[type=email].width-half,
main .table input[type=date].width-half,
main .table select.width-half{
	width: 200px;
}

main .table input[type=text].width-small,
main .table input[type=password].width-small,
main .table select.width-small{
	width: 50px;
}

main .table input[type=text].width-small,
main .table input[type=password].width-small,
main .table select.width-auto{
	width: auto;
}

main .table textarea,
main .table .textarea{
	/* border:1px solid #e9e9e9;
	border-radius: 10px; */
	
	padding: 5px;
	width:100%;
	min-height:400px;
	
	line-height: 24px; 
	/* text-align: center; */
}

main .table.border-top-default {
	border-top: 1px solid #e9e9e9;
}

main .table.border{
	border-left:1px solid #e9e9e9;
	border-right:1px solid #e9e9e9;	
}

main .table.border-top-none{
	border-top:0px solid #fff;
}


main .table.h50 th,
main .table.h50 td
{
	height: 50px;
}

main .table tr, main .table .tr {
	display: table-row;
	height: 30px;
}

main .table tr.content, main .table .tr.conent {
	display: table-row;
	height:auto;
	min-height: 200px;	
	line-height: 1.5em;
	color: #393939;	
}

main .table tr.hover:hover{
	background: #d6f4c1;
	cursor:pointer;
}

/* --- 셀의 모양 -------------------------- */

main .table td, 
main .table th, 
main .table .td,
main .table .th {
	display: table-cell;
	text-align: center;
	border-bottom: 1px solid #e9e9e9;
}

main .table.dashed td, 
main .table.dashed th, 
main .table.dashed .td,
main .table.dashed .th {	
	border-bottom: 1px dashed #b0b0b0;
}

main .table th, main .table .th {
	background: #f5f5f5 url("../images/bg-title-sp.png") no-repeat left
		center;
}

main .table th:first-child, main .table .th:first-child {
	background: #f5f5f5;
}

main .table th.w40, main .table td.w40, main .table .th.w40, main .table .td.w40
{
	width: 40px;
}

main .table th.w60, main .table td.w60, main .table .th.w60, main .table .td.w60
{
	width: 60px;
}

main .table th.w100, main .table td.w100, main .table .th.w100, main .table .td.w100
{
	width: 100px;
}

main .table th.w150, main .table td.w150, main .table .th.w150, main .table .td.w150
{
	width: 150px;
}

main .table th.w180, main .table td.w180, main .table .th.w180, main .table .td.w180
{
	width: 180px;
}

main .table tr.content td,
main .table .tr.conent td{
	text-align: left;
	padding: 10px;
}

main .table tr.hidden,
main .table .tr.hidden{
	display: none;
}


main .table td.title, 
main .table .td.title {
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

main .table td.indent {
	padding-left:10px;
}

main .table td.indent.inner {
	padding-left:30px;
}

main .table td .re{
	padding-left: 20px;
    background: url(../images/icon-re.png) no-repeat left -5px;
}

main .table td.text-align-left{
	text-align: left;
}

main .table td.text-align-center{
	text-align: center;
}

main .table td.text-align-right{
	text-align: right;
}

/* --- to override ----------------------------------------------------------------------------------------- */

main .hidden{
	display: none;
}

/* --- new style ---------------------------------------------------------------------------- */
main .table td.-text-.indent{
	indent: 10px;
}

main .table td .-margin-.left{
	margin-left: 10px;
}

main .table td .-margin-.left.l5{
	margin-left: 5px;
}

main .table td .width.auto{
	width:auto;
}

main .table td.-text-.left{
	text-align: left;
}

main .table td.-text-.right{
	text-align: right;
}

/* td 태그 안에 있는 모든 img, label, input을 한번에 수직 가운데 정렬 하는 스타일 */
main .table td.-text-.vertical.center > img,
main .table td.-text-.vertical.center > label,
main .table td.-text-.vertical.center > input{
	vertical-align: middle;
}

/* td 태그 안에 있는 모든 img, label, input에 각각 수직 가운데 정렬을 지정하는 스타일 */
main .table td input.-text-.vertical.center,
main .table td img.-text-.vertical.center,
main .table td label.-text-.vertical.center{
	vertical-align: middle;
}



/* ----- player ------------------------------------------------------------------------ */
main .player{
	display:inline-block;
	cursor: pointer;
    width: 181px;
    height: 40px;
    line-height: 40px;
    text-align: center;
    border: 1px solid #ff7e00;
    border-radius: 10px;
    background: radial-gradient(ellipse at center, #ffd3a9 0%,#ff7e00 100%);
}

main .player > a,
main .tools > a
 {
    color: #fff;
    font-size: 14px;
    font-family: "맑은고딕", "고딕", sans-serif;
    font-weight: bold;
}

main .tools{
	display:inline-block;
	cursor: pointer;
    width: 181px;
    height: 40px;
    line-height: 40px;
    text-align: center;
    border: 1px solid #76973e;
    border-radius: 10px;
    background: radial-gradient(ellipse at center, #8cb34a 0%,#76973e 100%);
}

/* === Main Component ===================================================== */
/* --- pager style -------------------------------------- */
.-pager-{
	
}


/* ==== Desktop만을 위한 Style -- 너비 960px 이상 =========================================================== */
/* @media all and (min-width:960px) {
} */

/* ==== 테블릿 이하에서 달라질 공통 Style 오버라이드-- 너비 959px 이하 =========================================================== */
@media all and (max-width:959px) {
	main {
		visual을 없애면서 마진을 주게 됨.
		margin-top: 50px;
		width: 100%;
		padding: 0px;
	}
	main .breadcrumb {
		display: none;
	}
	main .main.title {
		display: none;
	}
}

/* ==== 중간 크기 장치만을 위한 Style -- 너비 640px~ 959px=========================================================== */
 @media all and (min-width:640px) and (max-width:959px) {
} 

/* ==== 스마트 폰처럼 작은 크기 장치만을 위한 Style -- 너비 639px 이하=========================================================== */
 @media all and (max-width:639px) {
} 

#visual{
	background: #313131 url("../images/bg-visual.png") no-repeat center;	
	height: 171px;
}

    
        #visual .content-container{	
            height:inherit;
            display:flex; 
            align-items: center;
            
            background: url("../../images/customer/visual.png") no-repeat center;
        }
    </style>   

</head>

<body>
<%
  String id = (String)session.getAttribute("id");

  if(id==null){
%>
  <script>
    alert("로그인을 먼저 해주세요");
    location.href='RentMain.jsp?center=MemberLogin.jsp';  
  </script>
<%
  }
  //로그인 되어 있는 아이디를 읽어 옴
  RentcarDAO rdao = new RentcarDAO();
  Vector<CarViewBean> v= rdao.getAllReserve(id);
  //DAO클래스에서 벡터에 담은 내용을 화면에 뿌려주면 됨  
%>  

    <!-- header 부분 -->

	<!-- <header id="header"> -->
        
       <!--  <div class="content-container"> -->
            <!-- ---------------------------<header>--------------------------------------- -->

            <!-- <section>
                <h1 class="hidden">헤더</h1><br><br><br><br>
            <h3 >
                <a href="RentMain.jsp"> <img src="img/LOGO.PNG" alt="HERMES Rent Car" /></a>
            </h3> -->
               <!--  <nav id="main-menu">
                    <h1>메인메뉴</h1>
                    <ul>
                        <li><a href="/guide">가이드</a></li>

                        <li><a href="/course">선택</a></li>
                        <li><a href="/answeris/index">AnswerIs</a></li>
                    </ul>
                </nav> -->

                <!-- <div class="sub-menu">

                    <section id="search-form">
                        <h1>강좌검색 폼</h1>
                        <form action="/course">
                            <fieldset>
                                <legend>과정검색필드</legend>
                                <label>과정검색</label>
                                <input type="text" name="q" value="" />
                                <input type="submit" value="검색" />
                            </fieldset>
                        </form>
                    </section>
 -->
                    <!-- <nav id="acount-menu">
                        <h1 class="hidden">회원메뉴</h1>
                        <ul>
                            <li><a href="RentMain.jsp">HOME</a></li>
                            <li><a href="RentMain.jsp?center=MemberLogin.jsp">로그인</a></li>
                            <li><a href="RentMain.jsp?center=MemberJoin.jsp">회원가입</a></li>
                        </ul>
                    </nav> -->

                    <!-- <nav id="member-menu" >
                        <h1 class="hidden">고객메뉴</h1>
                        <ul >
                            <li><a href="/RentMain.jsp"><img src="/images/txt-mypage.png" alt="마이페이지" /></a></li>
                            <li><a href="/notice/list.html"><img src="/images/txt-customer.png" alt="고객센터" /></a></li>
                        </ul>
                    </nav> -->

               <!--  </div>
            </section>

        </div> -->
        
<!--     </header> -->

	<!-- --------------------------- <visual> --------------------------------------- -->
	<!-- visual 부분 -->
	
	<!-- <div id="visual">
		<div class="content-container"></div>
	</div>
	--------------------------- <body> ---------------------------------------
	<div id="body">
		<div class="content-container clearfix">
 -->
			<!-- --------------------------- aside --------------------------------------- -->
			<!-- aside 부분 -->


			<aside class="aside">
				<h1>고객센터</h1>

				<nav class="menu text-menu first margin-top">
					<h1>고객센터메뉴</h1>
					<ul>
						<li><a class="current"  href="/customer/notice">공지사항</a></li>
						<li><a class=""  href="/customer/faq">자주하는 질문</a></li>
						<li><a class="" href="/customer/question">수강문의</a></li>
						<li><a class="" href="/customer/event">이벤트</a></li>
						
					</ul>
				</nav>


	<nav class="menu">
		<h1>협력업체</h1>
		<ul>
			<li><a target="_blank" href="http://www.notepubs.com"><img src="/images/notepubs.png" alt="노트펍스" /></a></li>
			<li><a target="_blank" href="http://www.namoolab.com"><img src="/images/namoolab.png" alt="나무랩연구소" /></a></li>
						
		</ul>
	</nav>
					
			</aside>
			<!-- --------------------------- main --------------------------------------- -->

			


			<main>
				<h2 class="main title">공지사항</h2>
				
				<div class="breadcrumb">
					<h3 class="hidden">breadlet</h3>
					<ul>
						<li>home</li>
						<li>고객센터</li>
						<li>공지사항</li>
					</ul>
				</div>
				
				
				<div class="margin-top first">
						<h3 class="hidden">공지사항 내용</h3>
						<table class="table">
							<tbody>
								<tr>
									<th>제목</th>
									<td class="text-align-left text-indent text-strong text-orange" colspan="3">${n.title}</td>
								</tr>
								<tr>
									<th>작성일</th>
									<td class="text-align-left text-indent" colspan="3"><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${n.regdate}"/></td>
								</tr>
								<tr>
									<th>작성자</th>
									<td>${n.writerId }</td>
									<th>조회수</th>
									<td><fmt:formatNumber type="number" pattern="##,###" value= "${n.hit}"/></td>
								</tr>
								<tr>
									<th>첨부파일</th>
									<td colspan="3" style="text-align:left; text-indent:10px;">
									<c:forTokens var="fileName" items="${n.files}" delims="," varStatus="st">
									
										<c:set var="style" value=""/>
										<c:if test="${fn:endsWith(fileName, '.zip')}">
											<c:set var="style" value="font-weight:bold; color:red;"/>
										</c:if>
									
									<a href="${fileName}" style="${style}">${fn:toUpperCase(fileName)}</a>	
									<c:if test="${!st.last}">
									/
									</c:if>								
									</c:forTokens>
									</td>
								</tr>
								<tr class="content">
									<td colspan="4">${n.content}</td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<div class="margin-top text-align-center" align="center">
						<a class="btn btn-list" href="RentMain.jsp">
						<input type="button" name="list" value= "목록"></a>
					</div>
					
					<div class="margin-top">
						<table class="table border-top-default">
							<tbody>
								 
								<tr>
									<th>다음글</th>
									<td colspan="3"  class="text-align-left text-indent">다음글이 없습니다.</td>
								</tr>			
								
								
								<tr>
									<th>이전글</th>
									<td colspan="3"  class="text-align-left text-indent"><a class="text-blue text-strong" href="">스프링 DI 예제 코드</a></td>
								</tr>
								
								
							</tbody>
						</table>
					</div>			
					
			</main>		
			
		</div>
	</div>

    <!-- ------------------- <footer> --------------------------------------- -->



        <footer id="footer">
            
        <table>
          <tr height="100" align="center">
            <td >
              <hr color="red" sizw="3"> 이용약관 | 이메일 무단 수집 거부 | 개인정보 취급(처리)방침 | 윤리경영 | 보안신고 | Contact Us | 사이트맵<br> 
              (주)HERMES RentCar 사업자 정보 | ()주)크크 | 서울시 서초구 율곡로 111, 3층  | 대표 :아이유  | 개인정보보호책임 :아이린<br> 
                          사업자등록번호 : 613-81-65333 통신판매업신고 : 2021-서울강남-01555호 | tel 1555-5555 | h55p@google.com | 호스팅 사업자: Amazon Web Service(AWS)
              <hr>
            </td>
          </tr>
        </table>
    </div>
          
        </footer>
    </body>
    
    </html>
    