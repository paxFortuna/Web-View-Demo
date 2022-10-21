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
	
	//Ŀ�ؼ�Ǯ�� �̿��� �����ͺ��̽� ���� �޼ҵ� ����
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
	
	//�ֽż� 3���� ������ �����ϴ� �޼ҵ�
	public Vector<CrewListBean> getSelectCrew(){
		//����Ÿ���� ����
		Vector<CrewListBean> v= new Vector<CrewListBean>();
		
		getCon(); //Ŀ�ؼ��� ����Ǿ�� ������ ����
		
		try {
			String sql = "select * from carcrew order by crno desc ";
			pstmt = con.prepareStatement(sql);
			//���� ������ ����� resultŸ������ ����
			rs = pstmt.executeQuery();
			int count=0;
			while(rs.next()) {
				CrewListBean bean = new CrewListBean();
				bean.setCrno(rs.getInt(1));
				bean.setCrname(rs.getString(2));
				bean.setCrprice(rs.getInt(3));
				bean.setCrimg(rs.getString(4));
				bean.setCrinfo(rs.getString(5));
				
				//������ ��Ŭ������ ����
				v.add(bean);
				count++;
				if(count >2) break; //�ݺ����� ���� �����ÿ�
				//3���� ���Ϳ� ����
			}
			con.close();			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return v;		
	}
	
	//ī�װ��� ���� ����Ʈ�� �����ϴ� �޼ҵ�
	public Vector<CrewListBean> getCategoryCrew(int crcate){
		
		Vector<CrewListBean> v= new Vector<>();
		//�����͸� ������ ��Ŭ���� ����
		CrewListBean bean = null;
		
		getCon();
		
		try {
			String sql = "select * from carcrew where crcate=?";
			pstmt = con.prepareStatement(sql);
			//? ����
			pstmt.setInt(1, crcate);
			//����� ����
			rs=pstmt.executeQuery();
			//�ݺ����� ������ �����͸� ����
			while(rs.next()) {	
				//�����͸� ������ ��Ŭ���� ����
				bean = new CrewListBean();
				bean.setCrno(rs.getInt(1));
				bean.setCrname(rs.getString(2));
				bean.setCrprice(rs.getInt(3));
				bean.setCrimg(rs.getString(4));
				bean.setCrinfo(rs.getString(5));
				bean.setCrcate(rs.getString(6));
				//������ ��Ŭ������ ����
				v.add(bean);
			}	
			con.close();			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	//��� ������ �˻��ϴ� �޼ҵ�
	public Vector<CrewListBean> getAllCrew(){
		Vector<CrewListBean> v= new Vector<>();
		//�����͸� ������ ��Ŭ���� ����
		CrewListBean bean = null;
		
		getCon();
		
		try {
			String sql = "select * from carcrew";
			pstmt = con.prepareStatement(sql);			
			//����� ����
			rs=pstmt.executeQuery();
			//�ݺ����� ������ �����͸� ����
			while(rs.next()) {	
				//�����͸� ������ ��Ŭ���� ����
				bean = new CrewListBean();
				bean.setCrno(rs.getInt(1));
				bean.setCrname(rs.getString(2));
				bean.setCrprice(rs.getInt(3));
				bean.setCrimg(rs.getString(4));
				bean.setCrinfo(rs.getString(5));
				bean.setCrcate(rs.getString(6));
				//������ ��Ŭ������ ����
				v.add(bean);
			}	
			con.close();			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return v;			
	}
	
	//�ϳ��� ���� ������ �����ϴ� �޼ҵ�
	public CrewListBean getOneCrew(int crno) {
		//����Ÿ�� ����
		CrewListBean bean = new CrewListBean();
		getCon();
		
		try {
			String sql ="select * from carcrew where crno = ?";
			pstmt=con.prepareStatement(sql);
			//?�� ����
			pstmt.setInt(1, crno);
			//����� ����
			rs=pstmt.executeQuery();
			//�ݺ����� ������ �����͸� ����
			while(rs.next()) {	
				//�����͸� ������ ��Ŭ���� ����
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
	
	//ȸ�� ������ �ִ����� ��
	/*
	 * public int getMember(String id, String pass) {
	 * 
	 * getCon(); int result=0;
	 * 
	 * try { String sql = "select count(*) from member1 where id=? and pass1=?";
	 * pstmt=con.prepareStatement(sql); //? pstmt.setString(1, id);
	 * pstmt.setString(2, pass); //��� ���� rs=pstmt.executeQuery();
	 * 
	 * if(rs.next()) { result=rs.getInt(1); //0 �Ǵ� 1���� ���� } con.close(); }catch
	 * (Exception e) { e.printStackTrace(); } return result; }
	 */
	
	//�ϳ��� ���� ������ �����ϴ� �޼ҵ�
	public void setReserveCar(CarReserveBean bean) {
		
		getCon();
		
		try {
			String sql ="insert into carreserve values(reserve_seq.NEXTVAL,?,?,?,?,?,?,?,?,?)";
			pstmt =con.prepareStatement(sql);
			//?�� ���� ����
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
	
	//ȸ���� ���� ������ �����ϴ� �޼ҵ�
	public Vector<CarViewBean> getAllReserve(String id){
		
		Vector<CarViewBean> v = new Vector<>();
		CarViewBean bean=null;
		getCon();	
		
		try {
			String sql="select * from rentcar natural join carreserve where sysdate < to_date(rday, 'YYYY-MM-DD') and id=?";
			
			pstmt = con.prepareStatement(sql);
			//?
			pstmt.setString(1, id);
			//��� ����
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
				//��Ŭ������ ���Ϳ� ����
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
	
	//�ϳ��� ���� ����
	public void carRemoveReserve(String id, String rday) {
		
		getCon();
		
		try {
			//sql
			String sql = "delete from carreserve where id=? and rday=?";
			pstmt=con.prepareStatement(sql);
			//?
			pstmt.setString(1, id);
			pstmt.setString(2, rday);
			//���� ����
			pstmt.executeUpdate();
			con.close();		
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
