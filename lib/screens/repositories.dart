import 'package:a3_test/models/github_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 12.0,
                      ),
                      title: Text(repository['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            repository['description'] ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.star_outline),
                                  Text(repository['stargazers_count'].toString()),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.language_outlined),
                                  Text(repository['language'] ?? 'Unknow'),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.calendar_month_outlined),
                                  Text(
                                    DateFormat.yMMMd().format(
                                      DateTime.parse(repository['created_at']),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
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
