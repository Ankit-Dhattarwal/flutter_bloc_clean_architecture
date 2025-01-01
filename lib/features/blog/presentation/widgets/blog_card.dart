import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/core/theme/appColors.dart';
import 'package:flutter_bloc_clean_architecture/core/utils/calculate_reading_tiime.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/domain/entites/blog.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16).copyWith(bottom: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: blog.topics
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(5),
                          child: Chip(
                            label: Text(e),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Text(
                blog.title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text('${calculateReadingTime(blog.content)} min'),
        ],
      ),
    );
  }
}
