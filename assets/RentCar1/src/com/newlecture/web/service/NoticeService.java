package com.newlecture.web.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.newlecture.web.entity.Notice;
import com.newlecture.web.entity.NoticeView;

//메소드 모음 클래스
public class NoticeService {
	
	public List<NoticeView> getNoticeList(){
		
		return getNoticeList("title", "", 1);
	}
	
	public List<NoticeView> getNoticeList(int page){
		
		return getNoticeList("title", "", page);
	}

	public List<NoticeView> getNoticeList(String field/*TITLE, WRITER_ID*/, String query/*%A%*/, int page){	
			
		List<NoticeView> list = new ArrayList<>();	
		
		/* DB에서 JOIN 활용한 VIEW 생성
		CREATE VIEW NOTICE_VIEW AS
		select N.ID, N.TITLE, N.WRITER_ID, N.REGDATE, N.HIT, N.FILES , COUNT(C.ID) CMT_COUNT
		from notice N 
		LEFT JOIN "COMMENT" C ON N.ID = C.NOTICE_ID
		GROUP BY N.ID, N.TITLE, N.WRITER_ID, N.REGDATE, N.HIT, N.FILES;
		--ORDER BY N.REGDATE DESC;
		
		/*JOIN 활용한 VIEW 생성 후 List 호출 
		SELECT * FROM(  
		SELECT ROWNUM NUM, N.* 
		FROM (SELECT * FROM NOTICE_VIEW WHERE TITLE LIKE '%%' ORDER BY REGDATE DESC)N)
		WHERE NUM BETWEEN 1 AND 10
		*/		
		String sql= "SELECT * FROM(" + 
				"   SELECT ROWNUM NUM, N.* " + 
				" 	FROM (SELECT * FROM NOTICE_VIEW WHERE "+field+" LIKE ? ORDER BY REGDATE DESC)N)" + 
				"   WHERE NUM BETWEEN ? AND ?";	
		
		//1,11,21,21==> an= 1+(page-1)*10
		//10,20,30.40==> page*10
		
		String url="jdbc:oracle:thin:@localhost:1521:orcl";
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection(url, "scott", "tiger");
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, "%" +query + "%");
			st.setInt(2,  1+(page-1)*10);
			st.setInt(3, page*10);
			ResultSet rs = st.executeQuery();
					
			
			while(rs.next()){
				int id =rs.getInt("ID");
				String title =rs.getString("TITLE");
				String writerId =rs.getString("WRITER_ID");
				Date regdate =rs.getDate("REGDATE"); 	
				String hit =rs.getString("HIT");
				String files = rs.getString("Files");
				//String content = rs.getString("CONTENT");
				int cmtCount=rs.getInt("CMT_COUNT");
				
				NoticeView notice = new NoticeView(
						id, 
						title, 
						writerId, 
						regdate, 
						hit, 
						files, 
						//content,
						cmtCount
					);	
				list.add(notice);
			}
		    con.close();
		    st.close();
		    rs.close();    
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;		
	}


	
	public int getNoticeCoutnt() {
		
		return getNoticeCoutnt("title", "");
	}
	
	public int getNoticeCoutnt(String field, String query) {
		
		int count=0;
		
		String sql= "SELECT COUNT(ID) COUNT FROM(" + 
				"   SELECT ROWNUM NUM, N.* " + 
				" 	FROM (SELECT * FROM NOTICE WHERE "+field+" LIKE ? ORDER BY REGDATE DESC)N " +
				")"; 
		
			String url="jdbc:oracle:thin:@localhost:1521:orcl";
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection(url, "scott", "tiger");
			PreparedStatement st = con.prepareStatement(sql);
			
			st.setString(1, "%"+query+"%");
						
			ResultSet rs = st.executeQuery();
			
			if(rs.next()) { 
			count = rs.getInt("count");
			}
			rs.close();
			st.close();
			con.close();			
		}catch (Exception e) {
				e.printStackTrace();
		}		
		return count;
	}
	
	
	public Notice getNotice(int id) {
		
		Notice notice=null;
		String sql= "SELECT * FROM NOTICE WHERE ID=?";
		
		String url="jdbc:oracle:thin:@localhost:1521:orcl";
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection(url, "scott", "tiger");
			PreparedStatement st = con.prepareStatement(sql);
			st.setInt(1, id);
			
			ResultSet rs = st.executeQuery();
					
			
			if(rs.next()){
				int nid =rs.getInt("ID");
				String title =rs.getString("TITLE");
				String writerId =rs.getString("WRITER_ID");
				Date regdate =rs.getDate("REGDATE"); 	
				String hit =rs.getString("HIT");
				String files = rs.getString("Files");
				String content = rs.getString("CONTENT");
				
				notice = new Notice(
						nid, 
						title, 
						writerId, 
						regdate, 
						hit, 
						files, 
						content); 
				
			}
		    con.close();
		    st.close();
		    rs.close();    
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return notice;
	}

	public Notice getNextNoticeCount(int id) {
		
		Notice notice=null;
		String sql= "SELECT ID FROM NOTICE (SELECT * NOTICE ORDER BY REGDATE DESC) " +
					" WHERE REGDATE < (SELECT REGDATE FROM NOTICE WHERE ID=? AND ROWNUM = 1)";

		
		String url="jdbc:oracle:thin:@localhost:1521:orcl";
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection(url, "scott", "tiger");
			PreparedStatement st = con.prepareStatement(sql);
			st.setInt(1, id);
			
			ResultSet rs = st.executeQuery();
					
			
			if(rs.next()){
				int nid =rs.getInt("ID");
				String title =rs.getString("TITLE");
				String writerId =rs.getString("WRITER_ID");
				Date regdate =rs.getDate("REGDATE"); 	
				String hit =rs.getString("HIT");
				String files = rs.getString("Files");
				String content = rs.getString("CONTENT");
				
				notice = new Notice(
						nid, 
						title, 
						writerId, 
						regdate, 
						hit, 
						files, 
						content); 
				
			}
		    con.close();
		    st.close();
		    rs.close();    
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return notice;
	}
	
	public Notice getPrevNoticeCount(int id) {
		Notice notice=null;
		String sql= "SELECT ID FROM (SELECT * FROM NOTICE ORDER BY REGDATE DESC)" +
				" WHERE REGDATE < (SELECT REGDATE FROM NOTICE WHERE ID=? AND ROWNUM = 1)";	

		
		String url="jdbc:oracle:thin:@localhost:1521:orcl";
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection(url, "scott", "tiger");
			PreparedStatement st = con.prepareStatement(sql);
			st.setInt(1, id);
			
			ResultSet rs = st.executeQuery();					
			
			if(rs.next()){
				int nid =rs.getInt("ID");
				String title =rs.getString("TITLE");
				String writerId =rs.getString("WRITER_ID");
				Date regdate =rs.getDate("REGDATE"); 	
				String hit =rs.getString("HIT");
				String files = rs.getString("Files");
				String content = rs.getString("CONTENT");
				
				notice = new Notice(
						nid, 
						title, 
						writerId, 
						regdate, 
						hit, 
						files, 
						content); 
				
			}
		    con.close();
		    st.close();
		    rs.close();    
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return notice;
	}
}
