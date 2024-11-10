import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'blog_row.dart';

const String query = """
query   Records {
  records
  {
    talla
    peso
    cintura
    cadera
    actfisica
    actfisican
    bebidasugar
    bebidasugarn
    fecha
    postedBy {
      username
    }
  }
}
""";

class LogsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var appState = context.watch<MyAppState>();
    return  Query(
                options: QueryOptions(
                    document: gql(query),
                    variables: const <String, dynamic>{"variableName": "value"}),
                builder: (result, {fetchMore, refetch}) {
                  if (result.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  print(result);
                  if (result.data == null) {
                    return const Center(
                      child: Text("No logs found!"),
                    );
                  }
                  final posts = result.data!['records'];
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      final url = post['talla'];
                      final description = post['peso'];
                      //final user = post["postedBy"]["username"];
                      return BlogRow(
                        url: url,
                        description: description, // + " by " + user,
                      );
                    },
                  );
});
}
}
