package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CrewDAO {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	//커넥션풀을 이용한 데이터베이스 연결 메소드 생성
	public void getCon() {
		
		try {
			Context initctx = new InitialContext();
			Context envctx = (Context) initctx.lookup("java:comp/env");
			DataSource ds = (DataSource) envctx.lookup("jdbc/pool");
			con = ds.getConnection();			
		} catch (Exception e) {			
			e.printStackTrace();
		}				
	}
	
	//최신순 3명의 상담원을 리턴하는 메소드
	public Vector<CrewListBean> getSelectCrew(){
		//리턴타입을 설정
		Vector<CrewListBean> v= new Vector<CrewListBean>();
		
		getCon(); //커넥션이 연결되어야 쿼리를 실행
		
		try {
			String sql = "select * from carcrew order by crno desc ";
			pstmt = con.prepareStatement(sql);
			//쿼리 실행후 결과를 result타입으로 리턴
			rs = pstmt.executeQuery();
			int count=0;
			while(rs.next()) {
				CrewListBean bean = new CrewListBean();
				bean.setCrno(rs.getInt(1));
				bean.setCrname(rs.getString(2));
				bean.setCrprice(rs.getInt(3));
				bean.setCrimg(rs.getString(4));
				bean.setCrinfo(rs.getString(5));
				
				//벡터의 빈클래스를 저장
				v.add(bean);
				count++;
				if(count >2) break; //반복문을 빠져 나가시오
				//3개만 벡터에 저장
			}
			con.close();			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return v;		
	}
	
	//카테고리별 상담원 리스트를 저장하는 메소드
	public Vector<CrewListBean> getCategoryCrew(int crcate){
		
		Vector<CrewListBean> v= new Vector<>();
		//데이터를 저장할 빈클래스 선언
		CrewListBean bean = null;
		
		getCon();
		
		try {
			String sql = "select * from carcrew where crcate=?";
			pstmt = con.prepareStatement(sql);
			//? 맵핑
			pstmt.setInt(1, crcate);
			//결과를 리턴
			rs=pstmt.executeQuery();
			//반복문을 돌려서 데이터를 저장
			while(rs.next()) {	
				//데이터를 저장할 빈클래스 생성
				bean = new CrewListBean();
				bean.setCrno(rs.getInt(1));
				bean.setCrname(rs.getString(2));
				bean.setCrprice(rs.getInt(3));
				bean.setCrimg(rs.getString(4));
				bean.setCrinfo(rs.getString(5));
				bean.setCrcate(rs.getString(6));
				//벡터의 빈클래스를 저장
				v.add(bean);
			}	
			con.close();			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	//모든 상담원을 검색하는 메소드
	public Vector<CrewListBean> getAllCrew(){
		Vector<CrewListBean> v= new Vector<>();
		//데이터를 저장할 빈클래스 선언
		CrewListBean bean = null;
		
		getCon();
		
		try {
			String sql = "select * from carcrew";
			pstmt = con.prepareStatement(sql);			
			//결과를 리턴
			rs=pstmt.executeQuery();
			//반복문을 돌려서 데이터를 저장
			while(rs.next()) {	
				//데이터를 저장할 빈클래스 생성
				bean = new CrewListBean();
				bean.setCrno(rs.getInt(1));
				bean.setCrname(rs.getString(2));
				bean.setCrprice(rs.getInt(3));
				bean.setCrimg(rs.getString(4));
				bean.setCrinfo(rs.getString(5));
				bean.setCrcate(rs.getString(6));
				//벡터의 빈클래스를 저장
				v.add(bean);
			}	
			con.close();			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return v;			
	}
	
	//하나의 상담원 정보를 리턴하는 메소드
	public CrewListBean getOneCrew(int crno) {
		//리턴타입 선언
		CrewListBean bean = new CrewListBean();
		getCon();
		
		try {
			String sql ="select * from carcrew where crno = ?";
			pstmt=con.prepareStatement(sql);
			//?값 맵핑
			pstmt.setInt(1, crno);
			//결과를 리턴
			rs=pstmt.executeQuery();
			//반복문을 돌려서 데이터를 저장
			while(rs.next()) {	
				//데이터를 저장할 빈클래스 생성
				bean.setCrno(rs.getInt(1));
				bean.setCrname(rs.getString(2));
				bean.setCrprice(rs.getInt(3));
				bean.setCrimg(rs.getString(4));
				bean.setCrinfo(rs.getString(5));
				bean.setCrcate(rs.getString(6));		
				
			}	
			con.close();			
		
		}catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
		
	}
	
	//회원 정보가 있는지를 비교
	/*
	 * public int getMember(String id, String pass) {
	 * 
	 * getCon(); int result=0;
	 * 
	 * try { String sql = "select count(*) from member1 where id=? and pass1=?";
	 * pstmt=con.prepareStatement(sql); //? pstmt.setString(1, id);
	 * pstmt.setString(2, pass); //결과 리턴 rs=pstmt.executeQuery();
	 * 
	 * if(rs.next()) { result=rs.getInt(1); //0 또는 1값이 저장 } con.close(); }catch
	 * (Exception e) { e.printStackTrace(); } return result; }
	 */
	
	//하나의 예약 정보를 저장하는 메소드
	public void setReserveCar(CarReserveBean bean) {
		
		getCon();
		
		try {
			String sql ="insert into carreserve values(reserve_seq.NEXTVAL,?,?,?,?,?,?,?,?,?)";
			pstmt =con.prepareStatement(sql);
			//?에 값을 대입
			pstmt.setInt(1, bean.getNo());
			pstmt.setString(2, bean.getId());
			pstmt.setInt(3, bean.getQty());
			pstmt.setInt(4, bean.getDday());
			pstmt.setString(5, bean.getRday());
			pstmt.setInt(6, bean.getUsein());
			pstmt.setInt(7, bean.getUsewifi());
			pstmt.setInt(8, bean.getUseseat());
			pstmt.setInt(9, bean.getUsenavi());
			
			pstmt.executeUpdate();
			con.close();			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//회원의 예약 정보를 리턴하는 메소드
	public Vector<CarViewBean> getAllReserve(String id){
		
		Vector<CarViewBean> v = new Vector<>();
		CarViewBean bean=null;
		getCon();	
		
		try {
			String sql="select * from rentcar natural join carreserve where sysdate < to_date(rday, 'YYYY-MM-DD') and id=?";
			
			pstmt = con.prepareStatement(sql);
			//?
			pstmt.setString(1, id);
			//결과 리턴
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bean = new CarViewBean();
				bean.setName(rs.getString(2));
				bean.setPrice(rs.getInt(4));
				bean.setImg(rs.getString(7));
				bean.setQty(rs.getInt(11));
				bean.setDday(rs.getInt(12));
				bean.setRday(rs.getString(13));
				bean.setUsein(rs.getInt(14));
				bean.setUsewifi(rs.getInt(15));
				bean.setUseseat(rs.getInt(16));
				bean.setUsenavi(rs.getInt(17));
				//빈클래스를 벡터에 저장
				v.add(bean);						
			}
			con.close();	
			pstmt.close();
			rs.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	//하나의 예약 삭제
	public void carRemoveReserve(String id, String rday) {
		
		getCon();
		
		try {
			//sql
			String sql = "delete from carreserve where id=? and rday=?";
			pstmt=con.prepareStatement(sql);
			//?
			pstmt.setString(1, id);
			pstmt.setString(2, rday);
			//쿼리 실행
			pstmt.executeUpdate();
			con.close();		
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
