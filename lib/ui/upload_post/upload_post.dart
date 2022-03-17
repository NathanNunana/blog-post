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

  void submitData() {
    if (_titleController.text.isNotEmpty &&
        _descController.text.isNotEmpty &&
        _imgUrlController.text.isNotEmpty) {
      context.read<UploadCubit>().uploadPost(
            title: _titleController.text,
            details: _descController.text,
            imageUrl: _imgUrlController.text,
          );
    } else {
      Logger().d('Fill out the input fields!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ),
      body: BlocBuilder<UploadCubit, UploadState>(
        builder: (context, state) {
          return state.when(
            initial: () => Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextFormField(
                    controller: _titleController,
                    placeHolder: 'Enter title',
                  ),
                  MyTextFormField(
                    controller: _descController,
                    placeHolder: 'Enter description',
                  ),
                  MyTextFormField(
                    controller: _imgUrlController,
                    placeHolder: 'Enter image url',
                  ),
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
}

class MyTextFormField extends StatelessWidget {
  const MyTextFormField(
      {Key? key, required this.controller, required this.placeHolder})
      : super(key: key);
  final TextEditingController controller;
  final String placeHolder;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
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
