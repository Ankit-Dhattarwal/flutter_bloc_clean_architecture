import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/ankit-test/counter/counter_page.dart';
import 'package:flutter_bloc_clean_architecture/core/common/widgets/loader.dart';
import 'package:flutter_bloc_clean_architecture/core/theme/appColors.dart';
import 'package:flutter_bloc_clean_architecture/core/utils/show_snackbar.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/presentation/widgets/blog_card.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlogPage.route());
            },
            icon: const Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state){
          if(state is BlogFailure){
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if(state is BlogLoading){
            return const Loader();
          }
          if(state is BlogDisplaySuccess){
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCard(blog: blog, color: AppColors.gradient1,);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}