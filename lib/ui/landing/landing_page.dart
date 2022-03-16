import 'package:blog_post/models/_index.dart';
import 'package:blog_post/ui/landing/cubit/fetch_blog_cubit.dart';
import 'package:blog_post/utils/_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogCubit>().fetchBlogPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BlOg PoSt'),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<BlogCubit, BlogState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(
              child: Text('Please wait...'),
            ),
            loading: buildLoadingPage,
            loaded: (posts) => buildLoadedPosts(posts, context),
            error: (error) => Center(
              child: Text(error),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, BlogRouter.uploadRoute);
          // showDialog<void>(
          //   context: context,
          //   builder: (_) => buidModalScreen(context),
          // );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: const Icon(Icons.post_add),
      ),
    );
  }

  // Loading page widget
  Widget buildLoadingPage() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  // Loaded page widget
  Widget buildLoadedPosts(List<BlogData> posts, BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 5,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) => Stack(
        children: [
          Positioned(
            child: Container(
              width: double.infinity,
              height: size.height / 5,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(posts[index].image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.black54, Color.fromARGB(0, 56, 47, 47)],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        posts[index].title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: size.width / 2,
                        // ignore: lines_longer_than_80_chars
                        child: Text(
                          posts[index].details,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget buildTextFormField(String placeHolder) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8),
  //     child: TextFormField(
  //       decoration: InputDecoration(
  //         hintText: placeHolder,
  //         filled: true,
  //         border: const OutlineInputBorder(
  //           borderSide: BorderSide.none,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Pop up screen
  // Widget buidModalScreen(BuildContext context) {
  //   return SimpleDialog(
  //     children: [
  //       buildTextFormField('Enter title'),
  //       buildTextFormField('Enter description'),
  //       buildTextFormField('Enter image url'),
  //       const Padding(
  //         padding: EdgeInsets.all(8),
  //         child: ElevatedButton(onPressed: null, child: Text('Save')),
  //       )
  //     ],
  //   );
  // }
}
