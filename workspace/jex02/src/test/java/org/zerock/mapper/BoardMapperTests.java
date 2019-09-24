package org.zerock.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes= {org.zerock.config.RootConfig.class})
@Log4j
public class BoardMapperTests {

	@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;
	
	//@Test
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	
	//@Test
	public void testInsert() {
		
		BoardVO board = new BoardVO();
		board.setTitle("19-09-20 제목");
		board.setContent("19-09-20 내용");
		board.setWriter("작성자: Oh ");
		mapper.insert(board);
		log.info(board);
	}
	
	//@Test
	public void testInsertSelectKey() {
		
		BoardVO board = new BoardVO();
		board.setTitle("19-09-20 제목 select key");
		board.setContent("19-09-20 내용 select key");
		board.setWriter("작성자: Oh  select key");
		mapper.insertSelectKey(board);
		log.info(board);
	}
	
	//@Test
	public void testRead() {
		// 존재하는 게시물 번호로 테스트
		BoardVO boardVO = mapper.read(5L);
		log.info(boardVO);
	}
	
	//@Test
	public void testDelete() {
		log.info("Delete count: " + mapper.delete(143L));
	}
	
	@Test
	public void testUpdate() {
		BoardVO boardVO = new BoardVO();
		// 실행전 존재하는 번호인지 확인할 것
		boardVO.setBno(145L);
		boardVO.setTitle("수정된 제목");
		boardVO.setContent("수정된 내용");
		boardVO.setWriter("userOH");
		int count = mapper.update(boardVO);
		log.info("UPDATE COUNT: " + count);
	}
}
