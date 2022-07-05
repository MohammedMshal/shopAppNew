class CategoryModel {
	bool? status;
	dynamic message;
	Data? data;
    CategoryModel({
		this.status,
		this.message,
		this.data,});  
    CategoryModel.fromJson(Map<String, dynamic> json) {
		status = json['status'];
		message = json['message'];
		data = json['data'] != null ? Data.fromJson(json['data']) : null;
	}

}

class Data {
	/// JSONField(name: "current_page")
	int? currentPage;
	List<CategoryList>? data;
    Data.fromJson(Map<String, dynamic> json) {
		currentPage = json['current_page'];
		if (json['data'] != null){
				data = <CategoryList>[];
				json['data'].forEach((v) {
						data!.add(CategoryList.fromJson(v));
				});
		}
	}


}

class CategoryList {
	int? id;
	String? name;
	String? image;
	CategoryList({
		this.id,
		this.name,
		this.image,});
	CategoryList.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		image = json['image'];
	}
}