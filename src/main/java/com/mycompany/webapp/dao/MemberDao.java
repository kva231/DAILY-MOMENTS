package com.mycompany.webapp.dao;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mycompany.webapp.dto.Member;

@Repository
public class MemberDao {
	
	@Resource
	private SqlSessionTemplate sst;

	public int insert(Member member) {
		int row = sst.insert("mybatis.mapper.member.insert",member);
		return row;
	}
	
	public Member selectMember(String mid) {
		Member member = sst.selectOne("mybatis.mapper.member.selectMember", mid);
		return member;
	}
	
	public String selectMid(String searchedId) {
		String compareMid = sst.selectOne("mybatis.mapper.member.compareMid", searchedId);
		return compareMid;
	}
	
	public int updateMember(Member member) {
		int rows = sst.update("mybatis.mapper.member.updateMember", member);
		return rows;
	}
}
