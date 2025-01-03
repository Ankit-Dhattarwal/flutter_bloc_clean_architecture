import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/domain/entites/blog.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/domain/usecases/get_all_brands.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUploadEvent>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onFetchAllBlogs);
  }

  void _onBlogUpload(
    BlogUploadEvent event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _uploadBlog(
      UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );

    res.fold((l) {
      print(l.message);
      emit(BlogFailure(l.message));
    },
        (r) => emit(
              BlogUploadSuccess(),
            ));
  }

  void _onFetchAllBlogs(
      BlogFetchAllBlogs event,
      Emitter<BlogState> emit,
      ) async{
    final res = await _getAllBlogs(NoParams());
    
    res.fold((l) => emit(BlogFailure(l.message)), (r) => emit(BlogDisplaySuccess(r)));
  }
}
