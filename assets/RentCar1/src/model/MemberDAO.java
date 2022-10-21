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

//오라클 데이터 베이스에 연결하고 select, insert, update, delete작업을 실행해주는 클래스입니다.
public class MemberDAO {
	
	//오라클에 접속하는 소스를 작성
	  /*String url="jdbc:oracle:thin:@localhost:1521:orcl"; //접속 url
	  String id="scott"; //접속 아이디
	  String pass="tiger";*/
	  
	  Connection con; //데이터베이스에 접근할 수 있도록 설정
	  PreparedStatement pstmt; //데이터 베이스에서 쿼리를 실행시켜주는 객체
	  ResultSet rs; //데이터 베이스의 테이블의 결과를 리턴받아 자바에 저장해주는 객체
	  
	//데이터 베이스에 접근할 수 있도록 도와주는 메소드
	public void getCon() {
		
		//커넥션 풀을 이용하여 데이터 베이스에 접근
		try {
			//외부에서 데이터를 읽어들여야 하기에 
			Context initctx=new InitialContext();
		
			//톰켓 서버에 정보를 담아 놓은 곳으로 이동
			Context envctx = (Context) initctx.lookup("java:comp/env");
		
			//데이터 소스 객체를 선언
			DataSource ds = (DataSource) envctx.lookup("jdbc/pool");
			//데이터 소스를 기준으로 커넥션을 연결해주시오
			
			con=ds.getConnection();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		/*try {
			//1.해당 데이터 베이스를 사용한다고 선언(클래스를 등록=오라클용을 사용)
			  Class.forName("oracle.jdbc.driver.OracleDriver");
			  //DriverManager.registerDriver(new OracleDriver());
			  //2.해당 데이터 베이스에 접속
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
					return 1; //로그인 성공
				}
				else
					return 0; //비밀번호 불일치
			}
			return -1;  //아이디가 없음
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -2;//데이터베이스 오류
	}
	
	//데이터 베이스에 한사람의 회원 정보를 저장해주는 메소드
	public void insertMember(MemberBean mbean) {
		try{			
			  getCon(); 
			  //접속후 쿼리 준비하여 
			  String sql="insert into member1 values(?,?,?,?,?,?,?,?)";
			  //쿼리를 사용하도록 설정
			  PreparedStatement pstmt = con.prepareStatement(sql);
			  //?에 맞게 데이터를 맵핑
			  pstmt.setString(1, mbean.getId());
			  pstmt.setString(2, mbean.getPass1());
			  pstmt.setString(3, mbean.getEmail());
			  pstmt.setString(4, mbean.getTel());
			  pstmt.setString(5, mbean.getHobby());
			  pstmt.setString(6, mbean.getJob());
			  pstmt.setString(7, mbean.getAge());
			  pstmt.setString(8, mbean.getInfo());
				//4.오라클에서 쿼리를 실행하시오.
			  pstmt.executeUpdate();  
			  
			  //5.자원 반납
			 	con.close();		    
		  }catch(Exception e){
			  e.printStackTrace();
		  }	  
	}
	
	//모든 회원의 정보를 리턴해주는 메소드
	public Vector<MemberBean> allSelectMember(){
		//가변 길이로 데이터를 저장해줌
		Vector<MemberBean> v = new Vector<>();
		
		//무조건 데이터 베이스는 예외처리를 반드시 해야 함.
		try {
			//커넥션 연결
			getCon();
			//쿼리 준비
			String sql = "select * from member1";
			//쿼리 실행시켜주는 객체 생성
			pstmt=con.prepareStatement(sql);
			//쿼리를 실행시킨 결과를 리턴해서 받아줌. 오라클 테이블의 검색된 결과를 자바객체에 저장해줌
			rs=pstmt.executeQuery();
			//반복문을 사용해서 rs에 저장된 데이터를 추출해놓아야 함
			while(rs.next()) { //저장된 데이터 만큼까지 반복문을 돌리겠다는 뜻임.
				MemberBean bean=new MemberBean(); //컬럼으로 나뉘어진 데이터를 빈클래스에 저장
				bean.setId(rs.getString(1));
				bean.setPass1(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setTel(rs.getString(4));
				bean.setHobby(rs.getString(5));
				bean.setJob(rs.getString(6));
				bean.setAge(rs.getString(7));
				bean.setInfo(rs.getString(8));
				
				//패키딩된 memberbean클래스를 벡터에 저장함
				v.add(bean); //0번지부터 순서적으로 데이터가 저장됨.				
			}
			//자원 반납
			con.close();
			
		}catch(Exception e) {
			
		}
		//다 저장된 벡터를 리턴
		return v;
	}
	
	//한 사람에 대한 정보를 리턴하는 메소드 작성
	public MemberBean oneSelectMember(String id) {
		//한사람에 대한 벙보만 리턴하기에 빈 클래스 객체 생성
		MemberBean bean = new MemberBean();
		
		try {
			//커넥션 연결
			getCon();
			
			//쿼리 준비
			String sql="select * from member1 where id=?";
			pstmt = con.prepareStatement(sql);
			//?의 값을 맵핑
			pstmt.setString(1, id);
			//쿼리 실행
			rs=pstmt.executeQuery();
			if(rs.next()) { //레코드가 있다면
				bean.setId(rs.getString(1));
				bean.setPass1(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setTel(rs.getString(4));
				bean.setHobby(rs.getString(5));
				bean.setJob(rs.getString(6));
				bean.setAge(rs.getString(7));
				bean.setInfo(rs.getString(8));
			}
			//자원반납
			con.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		//리턴
		return bean;
	}
	
	//한 회원의 패스워드 값을 리턴하는 메소드 작성
	public String getPass(String id) {
		//스트링으로 리턴을 해야하기에 스트링 변수 선언
		String pass= "";
		try {
			getCon();
			//쿼리 준비
			String sql="select pass1 from member1 where id=?";
			pstmt = con.prepareStatement(sql);
			//?의 값을 맵핑
			pstmt.setString(1, id);
			//쿼리 실행
			rs=pstmt.executeQuery();
			if(rs.next()) {
				pass=rs.getString(1); //패스워드 값이 저장된 컬럼 인덱스
			}
			//자원 반납
			con.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		//결과를 리턴
		return pass;
	}
	
	//한 회원의 정보를 수정하는 메소드
	public void updateMember(MemberBean bean) {
		
		getCon();
		try {
			//쿼리 준비
			String sql = "update member1 set email=?, tel=? where id=?";
			//쿼리 실행 객체 선언
			pstmt=con.prepareStatement(sql);
			//?에 값을 맵핑(순서대로)
			pstmt.setString(1, bean.getEmail());
			pstmt.setString(2, bean.getTel());
			pstmt.setString(3, bean.getId());
			//쿼리 실행
			pstmt.executeUpdate();
			//자원 반납
			con.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//한 회원을 삭제하는 메소드 작성
	public void deleteMember(String id) {
		
		getCon();
		
		try {
			//쿼리 준비
			String sql = "delete from member1 where id=?";
			//쿼리 실행 객체 선언
			pstmt=con.prepareStatement(sql);
			//?에 값을 맵핑(순서대로)
			pstmt.setString(1, id);
			//쿼리 실행
			pstmt.executeUpdate();
			//자원 반납
			con.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
		
}
