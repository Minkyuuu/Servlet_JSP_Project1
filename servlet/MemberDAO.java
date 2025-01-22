package omok;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import omok.MemberVO;

public class MemberDAO {
	private PreparedStatement pstmt;
	private Connection con;
	private DataSource dataFactory;
	
	public MemberDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context)ctx.lookup("java:/comp/env");
			dataFactory = (DataSource)envContext.lookup("jdbc/oracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void signUpMember(MemberVO memberVO) {
		try {
			con = dataFactory.getConnection();
			String id = memberVO.getId();
			String pwd = memberVO.getPwd();
			String nickname = memberVO.getNickname();
			
			String query = "insert into member";
			query += "(id,pwd,nickname)";
			query += " values(?,?,?)";
			System.out.println("prepareStatement: "+query);
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			pstmt.setString(3, nickname);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void unregisterMember(String id) {
		try {
			con = dataFactory.getConnection();
			
			String query = "delete from member" + " where id=?";
			System.out.println("prepareStatement:" + query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean isExisted(MemberVO memberVO) {
		boolean result = false;
		String id = memberVO.getId();
		String pwd = memberVO.getPwd();
		try {
			con = dataFactory.getConnection();
			String query = "SELECT * FROM member WHERE id=? AND pwd=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public void updateWin(String id) {
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberById(id);
		
		try {
			con = dataFactory.getConnection();
			String query = "update member set wincnt = wincnt + 1" + " where id =?";
			System.out.println("prepareStatement:" + query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateLoss(String id) {
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberById(id);
		
		try {
			con = dataFactory.getConnection();
			String query = "update member set losscnt = losscnt + 1" + " where id =?";
			System.out.println("prepareStatement:" + query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public MemberVO getMemberById(String id) {
		MemberVO vo = new MemberVO();
		try {
			con = dataFactory.getConnection();
			String query = "SELECT * FROM member WHERE id=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				vo = new MemberVO();
				
				vo = new MemberVO();
	            vo.setId(rs.getString("id"));
	            vo.setPwd(rs.getString("pwd"));
	            vo.setNickname(rs.getString("nickname"));
	            vo.setWinCnt(rs.getInt("winCnt"));
	            vo.setLossCnt(rs.getInt("lossCnt"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
}
