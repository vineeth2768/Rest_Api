import 'package:api_intergration/http_helper/http_helper.dart';
import 'package:flutter/material.dart';

class PostListPage extends StatelessWidget {
  PostListPage({super.key});

  Future<List<Map>> _futurePosts = HttpHelper().fetchItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map>>(
        future: _futurePosts,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          /// Check for any errors
          if (snapshot.hasError) {
            return Center(
              child: Text("Some error occurred${snapshot.error}"),
            );
          }

          /// Has data is arrived
          if (snapshot.hasData) {
            List<Map> posts = snapshot.data;

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                Map thisItem = posts[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text("${index + 1}.${thisItem['title']}"),
                      subtitle: Text("${thisItem['body']}"),
                    ),
                  ),
                );
              },
            );
          }

          /// Dispaly Loader
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
