
import 'package:flutter_bloc_clean_architecture/features/blog/data/model/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource{
  void uploadLocalBlogs({
    required List<BlogModel> blogs
});

  List<BlogModel> loadBlogs();
}


class BlogLocalDataSourceImpl implements BlogLocalDataSource{
  final Box box;
  BlogLocalDataSourceImpl(this.box);

  @override
  List<BlogModel> loadBlogs() {
    return box.toMap().values.map((blogJson) {
      return BlogModel.fromJson(Map<String, dynamic>.from(blogJson));
    }).toList();
  }


  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();

    final Map<String,Map<String, dynamic>> blogMap = {
      for (int i = 0; i < blogs.length; i++) i.toString(): blogs[i].toJson()
    };
    box.putAll(blogMap);
  }


}