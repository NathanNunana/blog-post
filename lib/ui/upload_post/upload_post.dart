import 'package:blog_post/models/_index.dart';
import 'package:blog_post/ui/upload_post/cubit/upload_blog_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class UploadPost extends StatefulWidget {
  const UploadPost({Key? key}) : super(key: key);

  @override
  State<UploadPost> createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _imgUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void submitData() {
      if (_titleController.text.isNotEmpty &&
          _descController.text.isNotEmpty &&
          _imgUrlController.text.isNotEmpty) {
        final json = {
          'title': _titleController.text,
          'details': _descController.text,
          'image': _imgUrlController.text,
        };
        final blogPost = BlogDataDTO.fromJson(json);
        context.read<UploadCubit>().uploadPost(blogPost: blogPost);
      } else {
        Logger().d('Fill out the input fields!');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload'),
      ),
      body: BlocBuilder<UploadCubit, UploadState>(
        builder: (context, state) {
          return state.when(
            initial: () => Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildTextFormField('Enter title', _titleController),
                  buildTextFormField('Enter description', _descController),
                  buildTextFormField('Enter image url', _imgUrlController),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: submitData,
                      child: const Text('Upload'),
                    ),
                  )
                ],
              ),
            ),
            uploading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            uploaded: () => const Center(
              child: Text('uploaded'),
            ),
            error: (error) => Center(
              child: Text('Error: $error'),
            ),
          );
        },
      ),
    );
  }

  Widget buildTextFormField(
    String placeHolder,
    TextEditingController _controller,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: placeHolder,
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
