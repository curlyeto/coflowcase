



class User {

  final int id;
  final String name;
  final String username;
  final String password;

	User.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		username = map["username"],
		password = map["password"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['username'] = username;
		data['password'] = password;
		return data;
	}
}
