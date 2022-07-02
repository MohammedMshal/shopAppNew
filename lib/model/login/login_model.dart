class LoginModel {
	bool? status;
	String? message;
	Data? data;
    LoginModel({
		this.status,
		this.message,
		this.data,});  
    LoginModel.fromJson(Map<String, dynamic> json) {
		status = json['status'];
		message = json['message'];
		data = json['data'] != null ? Data.fromJson(json['data']) : null;
	}


}

class Data {
	int? id;
	String? name;
	String? email;
	String? phone;
	String? image;
	int? points;
	int? credit;
	String? token;
    Data({
		this.id,
		this.name,
		this.email,
		this.phone,
		this.image,
		this.points,
		this.credit,
		this.token,});  
    Data.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		email = json['email'];
		phone = json['phone'];
		image = json['image'];
		points = json['points'];
		credit = json['credit'];
		token = json['token'];
	}

    Map<String, dynamic> toJson(){
		final Map<String, dynamic> data = <String, dynamic>{};
		data["id"] = id;
		data["name"] = name;
		data["email"] = email;
		data["phone"] = phone;
		data["image"] = image;
		data["points"] = points;
		data["credit"] = credit;
		data["token"] = token;
		return data;
	}
}