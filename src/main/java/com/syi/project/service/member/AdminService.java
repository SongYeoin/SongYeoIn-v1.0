package com.syi.project.service.member;

import java.util.List;

import com.syi.project.model.Criteria;
import com.syi.project.model.EnrollVO;
import com.syi.project.model.member.MemberVO;
import com.syi.project.model.syclass.SyclassVO;

public interface AdminService {

	// 로그인
	MemberVO selectLoginAdmin(MemberVO member) throws Exception;

	// 수강생 리스트 조회
	List<MemberVO> selectMemberList(Criteria cri) throws Exception;

	// 회원 총 수
	int selectTotalCount(Criteria cri);

	// 승인 처리
	int updateStatusY(int memberNo);

	// 미승인 처리
	int updateStatusN(int memberNo);

	// 회원 상세 조회
	MemberVO selectMemberDetail(int memberNo);

	// 반 조회
	List<SyclassVO> selectClassList();

	// 수강 신청
	int insertEnroll(EnrollVO enroll);
}
