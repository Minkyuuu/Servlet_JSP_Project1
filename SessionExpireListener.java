package omok;

import java.lang.reflect.Member;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

public class SessionExpireListener implements HttpSessionAttributeListener {
	
	MemberDAO dao = new MemberDAO();
	
	@Override
    public void attributeAdded(HttpSessionBindingEvent event) {
        if ("login.id".equals(event.getName())) {
            // id 속성이 세션에 추가될 때
            String userId = (String)event.getValue();
            LoginMember.getLoginMemberMap().put(userId,dao.getMemberById(userId));
        }
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent event) {
        if ("login.id".equals(event.getName())) {
            // id 속성이 세션에서 제거될 때
            String userId = (String) event.getValue();
            LoginMember.getLoginMemberMap().remove(userId);
        }
    }
}
