package compte;

public class User {
	int id;
	String firstName;
	String lastName;
	String email;
	String password;
	String location;
	String phoneNumber;
	String refreshToken;
	
	public User(int id, String firstName, String lastName, String email, String password, String location,
			String phoneNumber, String refreshToken) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.password = password;
		this.location = location;
		this.phoneNumber = phoneNumber;
		this.refreshToken = refreshToken;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getRefreshToker() {
		return refreshToken;
	}

	public void setRefreshToker(String refreshToken) {
		this.refreshToken = refreshToken;
	}
	
}
