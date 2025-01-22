package omok;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberVO {
	private String id;
	private String pwd;
	private String nickname;
	private int winCnt;
	private int lossCnt;
}
