

import 'dart:io';

import 'package:flutter_bloc_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/data/model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
});
}

class BlogRemoteDataSourceImpl extends BlogRemoteDataSource{
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async{
    try{
      final blogData = await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    }catch(e){
      throw ServerExpection(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({required File image, required BlogModel blog,}) async{
    try{
      print('ankit -${blog.id}');
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    }catch(e){
      throw ServerExpection(e.toString());
    }
  }

}