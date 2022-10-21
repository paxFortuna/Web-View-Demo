package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import java.util.concurrent.ExecutionException;

import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;

//����Ŭ ������ ���̽��� �����ϰ� select, insert, update, delete�۾��� �������ִ� Ŭ�����Դϴ�.
public class MemberDAO {
	
	//����Ŭ�� �����ϴ� �ҽ��� �ۼ�
	  /*String url="jdbc:oracle:thin:@localhost:1521:orcl"; //���� url
	  String id="scott"; //���� ���̵�
	  String pass="tiger";*/
	  
	  Connection con; //�����ͺ��̽��� ������ �� �ֵ��� ����
	  PreparedStatement pstmt; //������ ���̽����� ������ ��������ִ� ��ü
	  ResultSet rs; //������ ���̽��� ���̺��� ����� ���Ϲ޾� �ڹٿ� �������ִ� ��ü
	  
	//������ ���̽��� ������ �� �ֵ��� �����ִ� �޼ҵ�
	public void getCon() {
		
		//Ŀ�ؼ� Ǯ�� �̿��Ͽ� ������ ���̽��� ����
		try {
			//�ܺο��� �����͸� �о�鿩�� �ϱ⿡ 
			Context initctx=new InitialContext();
		
			//���� ������ ������ ��� ���� ������ �̵�
			Context envctx = (Context) initctx.lookup("java:comp/env");
		
			//������ �ҽ� ��ü�� ����
			DataSource ds = (DataSource) envctx.lookup("jdbc/pool");
			//������ �ҽ��� �������� Ŀ�ؼ��� �������ֽÿ�
			
			con=ds.getConnection();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		/*try {
			//1.�ش� ������ ���̽��� ����Ѵٰ� ����(Ŭ������ ���=����Ŭ���� ���)
			  Class.forName("oracle.jdbc.driver.OracleDriver");
			  //DriverManager.registerDriver(new OracleDriver());
			  //2.�ش� ������ ���̽��� ����
			  con=DriverManager.getConnection(url, id, pass);
		}catch(Exception e) {
			e.printStackTrace();
		}*/
	}
	
	public int login(String id, String pass1) {
		getCon();
		
		String SQL = "SELECT pass1 FROM member1 where id = ?";
		try {
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(pass1)){
					return 1; //�α��� ����
				}
				else
					return 0; //��й�ȣ ����ġ
			}
			return -1;  //���̵� ����
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -2;//�����ͺ��̽� ����
	}
	
	//������ ���̽��� �ѻ���� ȸ�� ������ �������ִ� �޼ҵ�
	public void insertMember(MemberBean mbean) {
		try{			
			  getCon(); 
			  //������ ���� �غ��Ͽ� 
			  String sql="insert into member1 values(?,?,?,?,?,?,?,?)";
			  //������ ����ϵ��� ����
			  PreparedStatement pstmt = con.prepareStatement(sql);
			  //?�� �°� �����͸� ����
			  pstmt.setString(1, mbean.getId());
			  pstmt.setString(2, mbean.getPass1());
			  pstmt.setString(3, mbean.getEmail());
			  pstmt.setString(4, mbean.getTel());
			  pstmt.setString(5, mbean.getHobby());
			  pstmt.setString(6, mbean.getJob());
			  pstmt.setString(7, mbean.getAge());
			  pstmt.setString(8, mbean.getInfo());
				//4.����Ŭ���� ������ �����Ͻÿ�.
			  pstmt.executeUpdate();  
			  
			  //5.�ڿ� �ݳ�
			 	con.close();		    
		  }catch(Exception e){
			  e.printStackTrace();
		  }	  
	}
	
	//��� ȸ���� ������ �������ִ� �޼ҵ�
	public Vector<MemberBean> allSelectMember(){
		//���� ���̷� �����͸� ��������
		Vector<MemberBean> v = new Vector<>();
		
		//������ ������ ���̽��� ����ó���� �ݵ�� �ؾ� ��.
		try {
			//Ŀ�ؼ� ����
			getCon();
			//���� �غ�
			String sql = "select * from member1";
			//���� ��������ִ� ��ü ����
			pstmt=con.prepareStatement(sql);
			//������ �����Ų ����� �����ؼ� �޾���. ����Ŭ ���̺��� �˻��� ����� �ڹٰ�ü�� ��������
			rs=pstmt.executeQuery();
			//�ݺ����� ����ؼ� rs�� ����� �����͸� �����س��ƾ� ��
			while(rs.next()) { //����� ������ ��ŭ���� �ݺ����� �����ڴٴ� ����.
				MemberBean bean=new MemberBean(); //�÷����� �������� �����͸� ��Ŭ������ ����
				bean.setId(rs.getString(1));
				bean.setPass1(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setTel(rs.getString(4));
				bean.setHobby(rs.getString(5));
				bean.setJob(rs.getString(6));
				bean.setAge(rs.getString(7));
				bean.setInfo(rs.getString(8));
				
				//��Ű���� memberbeanŬ������ ���Ϳ� ������
				v.add(bean); //0�������� ���������� �����Ͱ� �����.				
			}
			//�ڿ� �ݳ�
			con.close();
			
		}catch(Exception e) {
			
		}
		//�� ����� ���͸� ����
		return v;
	}
	
	//�� ����� ���� ������ �����ϴ� �޼ҵ� �ۼ�
	public MemberBean oneSelectMember(String id) {
		//�ѻ���� ���� ������ �����ϱ⿡ �� Ŭ���� ��ü ����
		MemberBean bean = new MemberBean();
		
		try {
			//Ŀ�ؼ� ����
			getCon();
			
			//���� �غ�
			String sql="select * from member1 where id=?";
			pstmt = con.prepareStatement(sql);
			//?�� ���� ����
			pstmt.setString(1, id);
			//���� ����
			rs=pstmt.executeQuery();
			if(rs.next()) { //���ڵ尡 �ִٸ�
				bean.setId(rs.getString(1));
				bean.setPass1(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setTel(rs.getString(4));
				bean.setHobby(rs.getString(5));
				bean.setJob(rs.getString(6));
				bean.setAge(rs.getString(7));
				bean.setInfo(rs.getString(8));
			}
			//�ڿ��ݳ�
			con.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		//����
		return bean;
	}
	
	//�� ȸ���� �н����� ���� �����ϴ� �޼ҵ� �ۼ�
	public String getPass(String id) {
		//��Ʈ������ ������ �ؾ��ϱ⿡ ��Ʈ�� ���� ����
		String pass= "";
		try {
			getCon();
			//���� �غ�
			String sql="select pass1 from member1 where id=?";
			pstmt = con.prepareStatement(sql);
			//?�� ���� ����
			pstmt.setString(1, id);
			//���� ����
			rs=pstmt.executeQuery();
			if(rs.next()) {
				pass=rs.getString(1); //�н����� ���� ����� �÷� �ε���
			}
			//�ڿ� �ݳ�
			con.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		//����� ����
		return pass;
	}
	
	//�� ȸ���� ������ �����ϴ� �޼ҵ�
	public void updateMember(MemberBean bean) {
		
		getCon();
		try {
			//���� �غ�
			String sql = "update member1 set email=?, tel=? where id=?";
			//���� ���� ��ü ����
			pstmt=con.prepareStatement(sql);
			//?�� ���� ����(�������)
			pstmt.setString(1, bean.getEmail());
			pstmt.setString(2, bean.getTel());
			pstmt.setString(3, bean.getId());
			//���� ����
			pstmt.executeUpdate();
			//�ڿ� �ݳ�
			con.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//�� ȸ���� �����ϴ� �޼ҵ� �ۼ�
	public void deleteMember(String id) {
		
		getCon();
		
		try {
			//���� �غ�
			String sql = "delete from member1 where id=?";
			//���� ���� ��ü ����
			pstmt=con.prepareStatement(sql);
			//?�� ���� ����(�������)
			pstmt.setString(1, id);
			//���� ����
			pstmt.executeUpdate();
			//�ڿ� �ݳ�
			con.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
		
}
