package model2.qnaboard;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import common.JDBConnect;

public class MVCBoardDAO extends JDBConnect {
    public MVCBoardDAO() {
        super();
    }

    // 검색 조건에 맞는 게시물의 개수를 반환합니다.
    public int selectCount(Map<String, Object> map) {
        int totalCount = 0;
        String query = "SELECT COUNT(*) FROM qnaboard";
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " "
                   + " LIKE '%" + map.get("searchWord") + "%'";
        }
        try {
            stmt = con.createStatement();
            rs = stmt.executeQuery(query);
            rs.next();
            totalCount = rs.getInt(1);
        }
        catch (Exception e) {
            System.out.println("게시물 카운트 중 예외 발생");
            e.printStackTrace();
        }

        return totalCount;
    }

    
    
    public List<MVCBoardDTO> selectListPage(
    		Map<String,Object> map) {
        List<MVCBoardDTO> board = new Vector<MVCBoardDTO>();
        String query = 
                 " SELECT * FROM ( "
               + "  SELECT Tb.*, ROWNUM rNum FROM ( "
               + "    SELECT * FROM qnaboard ";
        if (map.get("searchWord") != null) {
            query +=" WHERE " + map.get("searchField")
                  + " LIKE '%" + map.get("searchWord") + "%'";
        }
        query += "     ORDER BY idx DESC "
               + "   ) Tb "
               + " ) "
               + " WHERE rNum BETWEEN ? AND ?";

        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, map.get("start").toString());
            psmt.setString(2, map.get("end").toString());
            rs = psmt.executeQuery();

            while (rs.next()) {
                MVCBoardDTO dto = new MVCBoardDTO();

                dto.setIdx(rs.getString(1));
                dto.setId(rs.getString(2));
                dto.setTitle(rs.getString(3));
                dto.setContent(rs.getString(4));
                dto.setPostdate(rs.getDate(5));
                dto.setVisitcount(rs.getInt(6));

                board.add(dto);
            }
        }
        catch (Exception e) {
            System.out.println("게시물 조회 중 예외 발생");
            e.printStackTrace();
        }
        return board;
    }

    // 게시글 데이터를 받아 DB에 추가합니다(파일 업로드 지원).
    public int insertWrite(MVCBoardDTO dto) {
        int result = 0;
        try {
            String query = "INSERT INTO qnaboard ( "
                         + " idx, user_id, title, content) "
                         + " VALUES ( "
                         + " seq_board_num.NEXTVAL, ?, ?, ?)";
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getId());
            psmt.setString(2, dto.getTitle());
            psmt.setString(3, dto.getContent());
            result = psmt.executeUpdate();
        }
        catch (Exception e) {
            System.out.println("게시물 입력 중 예외 발생");
            e.printStackTrace();
        }
        return result;
    }

    // 주어진 일련번호에 해당하는 게시물을 DTO에 담아 반환합니다.
    public MVCBoardDTO selectView(String idx) {
        MVCBoardDTO dto = new MVCBoardDTO();  // DTO 객체 생성
        String query = "SELECT Bo.*, Me.user_name FROM qnaboard Bo "
        		+ " INNER JOIN member Me ON Bo.user_id=Me.user_id"
        		+ " WHERE idx=?";  // 쿼리문 템플릿 준비
        try {
            psmt = con.prepareStatement(query);  // 쿼리문 준비
            psmt.setString(1, idx);  // 인파라미터 설정
            rs = psmt.executeQuery();  // 쿼리문 실행

            if (rs.next()) {  // 결과를 DTO 객체에 저장
                dto.setIdx(rs.getString(1));
                dto.setId(rs.getString(2));
                dto.setTitle(rs.getString(3));
                dto.setContent(rs.getString(4));
                dto.setPostdate(rs.getDate(5));
                dto.setVisitcount(rs.getInt(6));
                dto.setName(rs.getString(7));
            }
        }
        catch (Exception e) {
            System.out.println("게시물 상세보기 중 예외 발생");
            e.printStackTrace();
        }
        return dto;  // 결과 반환
    }

    // 주어진 일련번호에 해당하는 게시물의 조회수를 1 증가시킵니다.
    public void updateVisitCount(String idx) {
        String query = "UPDATE qnaboard SET "
                     + " visitcount=visitcount+1 "
                     + " WHERE idx=?"; 
        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, idx);
            psmt.executeQuery();
        }
        catch (Exception e) {
            System.out.println("게시물 조회수 증가 중 예외 발생");
            e.printStackTrace();
        }
    }
    /*
    // 다운로드 횟수를 1 증가시킵니다.
    public void downCountPlus(String idx) {
        String sql = "UPDATE freeboard SET "
                + " downcount=downcount+1 "
                + " WHERE idx=? "; 
        try {
            psmt = con.prepareStatement(sql);
            psmt.setString(1, idx);
            psmt.executeUpdate();
        }
        catch (Exception e) {}
    }
    */
    // 지정한 일련번호의 게시물을 삭제합니다.
    public int deletePost(String idx) {
        int result = 0;
        try {
            String query = "DELETE FROM qnaboard WHERE idx=?";
            psmt = con.prepareStatement(query);
            psmt.setString(1, idx);
            result = psmt.executeUpdate();
        }
        catch (Exception e) {
            System.out.println("게시물 삭제 중 예외 발생");
            e.printStackTrace();
        }
        return result;
    }

    // 게시글 데이터를 받아 DB에 저장되어 있던 내용을 갱신합니다(파일 업로드 지원).
    public int updatePost(MVCBoardDTO dto) {
        int result = 0;
        try {
            // 쿼리문 템플릿 준비
            String query = "UPDATE qnaboard "
                         + " SET title=?, content=? "
                         + " WHERE idx=? and user_id=?";

            // 쿼리문 준비
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getContent());
            psmt.setString(3, dto.getIdx());
            psmt.setString(4, dto.getId());

            // 쿼리문 실행
            result = psmt.executeUpdate();
        }
        catch (Exception e) {
            System.out.println("게시물 수정 중 예외 발생");
            e.printStackTrace();
        }
        return result;
    }
    public List<CommentDTO> getCommentsByBoardId(int boardId) {
        List<CommentDTO> comments = new ArrayList<>();
        String sql = "SELECT comment_id, user_id, content, postdate "
        		+ " FROM qnacomment WHERE idx = ? "
        		+ " ORDER BY postdate ASC";
        
        try {
            psmt = con.prepareStatement(sql);
            psmt.setInt(1, boardId);  // boardId를 쿼리에 바인딩
            rs = psmt.executeQuery();  // 쿼리 실행

            while (rs.next()) {  // 결과 처리
                CommentDTO comment = new CommentDTO();
                comment.setCommentId(rs.getInt("comment_id"));
                comment.setUserId(rs.getString("user_id"));
                comment.setContent(rs.getString("content"));
                comment.setPostdate(rs.getDate("postdate"));

                comments.add(comment);  // 리스트에 추가
            }
        } catch (SQLException e) {
            System.out.println("댓글 조회 중 예외 발생");
            e.printStackTrace();
        }
        
        return comments;  // 조회된 댓글 리스트 반환
    }
    // 댓글 ID로 댓글 조회 메서드
    public CommentDTO getCommentById(int commentId) {
        CommentDTO comment = null;
        String sql = "SELECT comment_id, user_id, content, postdate "
                   + " FROM qnacomment WHERE comment_id = ?";

        try {
            psmt = con.prepareStatement(sql);
            psmt.setInt(1, commentId);  // 댓글 ID를 쿼리에 바인딩
            rs = psmt.executeQuery();  // 쿼리 실행

            if (rs.next()) {  // 결과가 있다면 댓글 정보를 DTO에 담음
                comment = new CommentDTO();
                comment.setCommentId(rs.getInt("comment_id"));
                comment.setUserId(rs.getString("user_id"));
                comment.setContent(rs.getString("content"));
                comment.setPostdate(rs.getDate("postdate"));
            }
        } catch (SQLException e) {
            System.out.println("댓글 조회 중 예외 발생");
            e.printStackTrace();
        }

        return comment;  // 조회된 댓글 반환
    }

    // 댓글 추가 메서드
    public int insertComment(int boardId, String userId, String content) {
        int result = 0;
        String sql = "INSERT INTO qnacomment (comment_id, idx, user_id, content, postdate) "
                   + "VALUES (seq_qnacomment_num.NEXTVAL, ?, ?, ?, SYSDATE)";
        
        try {
            psmt = con.prepareStatement(sql);
            psmt.setInt(1, boardId);
            psmt.setString(2, userId);
            psmt.setString(3, content);
            
            result = psmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("댓글 삽입 중 예외 발생");
            e.printStackTrace();
        }

        return result;  // 댓글 삽입 결과 반환
    }
    // 댓글 수정 메서드
    // MVCBoardDAO.java 내의 댓글 수정 메서드
    public int updateComment(int commentId, String content) {
        int result = 0;
        String sql = "UPDATE qnacomment SET content = ? WHERE comment_id = ?";

        try {
            psmt = con.prepareStatement(sql);
            psmt.setString(1, content);  // 수정할 내용
            psmt.setInt(2, commentId);   // 수정할 댓글의 ID

            result = psmt.executeUpdate();  // 쿼리 실행
        } catch (SQLException e) {
            System.out.println("댓글 수정 중 예외 발생");
            e.printStackTrace();
        }

        return result;  // 수정 결과 반환 (성공하면 1, 실패하면 0)
    }

    // 댓글 삭제 메서드
    public int deleteComment(int commentId) {
        int result = 0;
        String sql = "DELETE FROM qnacomment WHERE comment_id = ?";
        
        try {
            psmt = con.prepareStatement(sql);
            psmt.setInt(1, commentId);
            result = psmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("댓글 삭제 중 예외 발생");
            e.printStackTrace();
        }

        return result;  // 댓글 삭제 결과 반환
    }
}
