package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	//������ ���̽��� Ŀ�ؼ�Ǯ�� ����ϵ��� �����ϴ� �޼ҵ�
	public void getCon() {
		
		try {
			Context initctx = new InitialContext();
			Context envctx = (Context) initctx.lookup("java:comp/env");
			DataSource ds = (DataSource) envctx.lookup("jdbc/pool");
			conn = ds.getConnection(); //Ŀ�ؼ� Ǯ ��� ���� ���� ����			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//�ϳ��� ���ο� �Խñ��� �Ѿ�ͼ� ����Ǵ� �޼ҵ�
	public void insertBoard(BoardBean bean) {
		
		getCon();
		//��Ŭ������ �ѿ��� �ʾҴ� �����͵��� �ʱ�ȭ ���־�� �Ѵ�.
		int ref=0; //�� �׷��� �ǹ� = ������ ������Ѽ� ���� ū ref���� ������ �� +1�� ���ָ� ��
		int re_step=1; //�����̱⿡ =�θ���̱⿡
		int re_level=1; 
		
		try {
			//���� ū ref���� ��������  ���� �غ�
			String refsql="select max(ref) from board1";
			//���� ���� ��ü
			pstmt=conn.prepareStatement(refsql);
			//���� ������ ����� ����
			rs=pstmt.executeQuery();
			if(rs.next()) {//��� ���� �ִٸ� �����ؾ� ��
				ref = rs.getInt(1)+1; //�ִ밪�� +1�ؼ� �� �׷��� ����
			}
			//������ �Խñ� ��ü���� ���̺� ����
			String sql = "insert into board1 values(board_vk.NEXTVAL,?,?,?,?,sysdate,?,?,?,0,?)";

			pstmt = conn.prepareStatement(sql);
					
			//?�� ���� ����
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			pstmt.setString(8, bean.getContent());
			//������ �����Ͻÿ�
			pstmt.executeUpdate();
			//�ڿ� �ݳ�
			conn.close();	
			pstmt.close();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}		
	}
	
	//10���� �Խñ��� �������ִ� �޼ҵ� �ۼ�
	public Vector<BoardBean> getAllBoard(int start, int end){ 
	
			//������ ��ü ����
		Vector<BoardBean> v = new Vector<>();
		getCon();
		
		try {
			//���� �غ�
			String sql="select * from (select A.*, Rownum Rnum from (select * from board1 order by ref desc ,re_step asc)A)"
					+ "where Rnum >= ? and Rnum <=?";
			//���� ������ ��ü ����
			pstmt =conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			//���� ���� ��� ����
			rs=pstmt.executeQuery();
			//������ ������ ����� �𸣱⿡ �ݺ����� �̿��Ͽ� �����͸� ����
			while(rs.next()) {
				//�����͸� ��Ű¡(����=BoardBeanŬ������ �̿�)����
				BoardBean bean = new BoardBean();
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
				//��Ű¡�� �����͸� ���Ϳ� ����
				v.add(bean);				
			}
			conn.close();	
			pstmt.close();
			rs.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return v;
	}	
	
	//BoardInfo : �ϳ��� �Խñ��� �����ϴ� �޼ҵ�
	public BoardBean getOneBoard(int num) {
		//����Ÿ�� ����
		BoardBean bean = new BoardBean();		
		getCon();
		
		
		try {
			//��ȸ�� ���� ����
			String readsql = "update board1 set readcount = readcount+1 where num=?";
			pstmt=conn.prepareStatement(readsql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
					
			//���� �غ�
			String sql="select * from board1 where num=?";
			//���� ���ఴü
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			//���� ���� �� ����� ����
			rs = pstmt.executeQuery();
			if(rs.next()) {
				//bean�� �����͸� ���� ��Ŵ (beanŬ������ ��ƿ�)
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));				
			}
			conn.close();
			pstmt.close();
			rs.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return bean;
				
	}
	
	//�亯 ���� ����Ǵ� �޼ҵ�
	public void reWriteBoard(BoardBean bean) {
		//�θ�۱׷�� �� ���� �� ������ �о����
		int ref = bean.getRef();
		int re_step = bean.getRe_step();
		int re_level = bean.getRe_level();
		
		getCon();
		
		try {
			////////�ٽ� �ڵ�//////////
			//�θ� �ۺ��� ū re_level�� ���� ���� 1�� ������Ŵ
			String levelsql = "update board1 set re_level=re_level+1 where ref=? and re_level > ?";
			//�������ఴü ����
			pstmt=conn.prepareStatement(levelsql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_level);
			//���� ����
			pstmt.executeUpdate();
			
			//�亯�� �����͸� ����
			String sql = "insert into board1 values (board_vk.NEXTVAL,?,?,?,?,sysdate,?,?,?,0,?)";
			pstmt=conn.prepareStatement(sql);
			//?���� ����
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref); //�θ��� ref ���� �־���
			pstmt.setInt(6, re_step+1); //����̱⿡ �θ�� re_step�� 1�� ���ص�
			pstmt.setInt(7, re_level+1);				
			pstmt.setString(8, bean.getContent());			
			pstmt.executeUpdate();
			
			conn.close();
			pstmt.close();
			rs.close();
		}catch (Exception e) {
			e.printStackTrace();
		}		
	}
	
	//boardupdate�� delete�� �ϳ��� �Խñ��� ����
	public BoardBean getOneUpdateBoard(int num) {
		//����Ÿ�� ����
		BoardBean bean = new BoardBean();		
		getCon();		
		
		try {
			//��ȸ�� ���� ������ boardinfo������ ����ϸ� ��
			//String readsql = "update board1 set readcount = readcount+1 where num=?";
			//pstmt=con.prepareStatement(readsql);
			//pstmt.setInt(1, num);
			//pstmt.executeUpdate();
					
			//���� �غ�
			String sql="select * from board1 where num=?";
			//���� ���ఴü
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			//���� ���� �� ����� ����
			rs = pstmt.executeQuery();
			if(rs.next()) {
				//bean�� �����͸� ���� ��Ŵ (beanŬ������ ��ƿ�)
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));				
			}
			conn.close();
			pstmt.close();
			rs.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return bean;
				
	}
	
	//update�� delete�� �ʿ��� �н����� ���� �������ִ� �޼ҵ�
	public String getPass(int num) {
		//������ ���� ��ü ����
		String pass="";
		getCon();
		
		try {
			//�����غ�
			String sql= "select password from board1 where num=?";
			//���� ������ ��ü ����
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			//�н����尪�� ����
			if(rs.next()) {
				pass=rs.getString(1);				
			}
			//�ڿ��ݳ�
			conn.close();
			pstmt.close();
			rs.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return pass;
		
	}
	
	//�ϳ��� �Խñ��� �����ϴ� �޼ҵ�
	public void updateBoard(BoardBean bean) {
		
		getCon();
		
		try {
			//���� �غ�
			String sql = "update board1 set subject= ?, content=? where num=?";
			pstmt=conn.prepareStatement(sql);
			//?���� ����
			pstmt.setString(1, bean.getSubject());
			pstmt.setString(2, bean.getContent());
			pstmt.setInt(3, bean.getNum());			
			pstmt.executeUpdate();
			conn.close();
			pstmt.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//�ϳ��� �Խñ��� �����ϴ� �޼ҵ�
	public void deleteBoard(int num) {
		getCon();
		
		try {
			//���� �غ�
			String sql= "delete from board1 where num=?";
			pstmt=conn.prepareStatement(sql);
			//? ����
			pstmt.setInt(1, num);
			//���� ����
			pstmt.executeUpdate();
			conn.close();
			pstmt.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//��ü ���� ������ �����ϴ� �޼ҵ�
	public int getAllCount() {
	
		getCon();		
		//�Խñ� ��ü���� �����ϴ� ����
		int count =0;
		
		try {
			//���� �غ�
			String sql="select count(*) from board1";
			//������ ������ ��ü ����
			pstmt=conn.prepareStatement(sql);
			//���� ������ ����� ����
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt(1); //��ü�Խñۼ�				
			}
			conn.close();
			pstmt.close();
			rs.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
}
