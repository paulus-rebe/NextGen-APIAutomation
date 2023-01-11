package utility;

import net.andreinc.mockneat.MockNeat;
import net.andreinc.mockneat.types.enums.RandomType;

public class Utilities {
	
	public String createRandomEmail() {
		MockNeat mock = new MockNeat(RandomType.SECURE);
//		String email = mock.emails().val();
		// To generate random email
		String corpEmail = mock.emails().domain("gmail.com").val();
		// To generate domain specific email
		return corpEmail;
	}

}
