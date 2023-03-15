import 'package:a3_test/models/github_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RepositoriesScreen extends StatelessWidget {
  const RepositoriesScreen(this.username, {super.key});

  final String? username;

  @override
  Widget build(BuildContext context) {
    final route = GoRouter.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('$username'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
            splashRadius: 24,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
          future: GithubRepository().getRepositoriesFromUser(username!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final repositories = snapshot.data!;
              return ListView.separated(
                itemCount: repositories.length,
                separatorBuilder: (context, index) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final repository = repositories[index];
                  return Card(
                    child: ListTile(
                      title: Text(repository['name']),
                      subtitle: Text(
                        repository['description'] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                        splashRadius: 24,
                      ),
                    ),
                  );
                },
              );
            }

            if (snapshot.hasError) {
              // print(snapshot.error);
              return SizedBox.expand(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'An error occurred, maybe the repository does not exist, please try again later',
                      style: theme.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => route.go('/'),
                      child: const Text('Back to home'),
                    ),
                  ],
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
