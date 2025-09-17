import 'package:flutter_api_lab/controllers/post_controller.dart' as post_controller;
import 'package:flutter_api_lab/models/post_model.dart' as post_model;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API',
      home: const PostList(),
    );
  }
}


class PostList extends StatefulWidget {
  const PostList({super.key});
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  late Future<List<post_model.Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = post_controller.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Data')),
      body: FutureBuilder<List<post_model.Post>>(
          future: futurePosts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Failed to load data.'),
                      Text('Error: ${snapshot.error}'),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              futurePosts = post_controller.fetchPosts();
                        });
                      }, child: Text('retry')
                      )
                    ],
                  )
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].title),
                    subtitle: Text(snapshot.data![index].body),
                  );
                },
              );
            } else {
              return const Center(child: Text('No data avaialable'));
            }
          }
      ),
    );
  }

}