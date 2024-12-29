import 'dart:io';

import 'package:flutter_bloc_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_bloc_clean_architecture/core/error/failure.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/data/model/blog_model.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/domain/entites/blog.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  BlogRepositoryImpl(this.blogRemoteDataSource);
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: '',
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

    final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

    blogModel = blogModel.copyWith(imageUrl: imageUrl);

   final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
     return right(uploadedBlog);
    } on ServerExpection catch (e) {
      return left(Failure(e.message));
    }
  }
}
