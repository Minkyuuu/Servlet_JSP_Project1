package omok;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginMember {
	private static final Map<String, MemberVO> loginMemberMap = new ConcurrentHashMap<>();
	
	// Getter 메서드
    public static Map<String, MemberVO> getLoginMemberMap() {
        return loginMemberMap;
    }	
}
