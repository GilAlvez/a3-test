import 'package:a3_test/models/github_favorite_repositories.dart';
import 'package:a3_test/models/github_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RepositoriesScreen extends StatefulWidget {
  const RepositoriesScreen(this.username, {super.key});

  final String? username;

  @override
  State<RepositoriesScreen> createState() => _RepositoriesScreenState();
}

class _RepositoriesScreenState extends State<RepositoriesScreen> {
  List<Favorite> _repositories = [];

  @override
  void initState() {
    super.initState();
    _loadRepositories();
  }

  Future<void> _loadRepositories() async {
    final repositories = await GitHubFavoriteRepository().getFavoriteRepositories();
    setState(() {
      _repositories = repositories;
    });
  }

  void _toggleRepository(int id, String name, String url) {
    final index = _repositories.indexWhere((repo) => repo.id == id);

    if (index >= 0) {
      setState(() {
        _repositories.removeAt(index);
      });
      GitHubFavoriteRepository().removeFavoriteRepository(id);
    } else {
      setState(() {
        _repositories.add(Favorite(id: id, name: name, url: url));
      });
      GitHubFavoriteRepository().addFavoriteRepository(id, name, url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final route = GoRouter.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.username}'),
        actions: [
          IconButton(
            onPressed: () => route.push('/favorites'),
            icon: const Icon(Icons.favorite_border),
            splashRadius: 24,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
          future: GithubRepository().getRepositoriesFromUser(widget.username!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final repositories = snapshot.data!;
              return ListView.separated(
                itemCount: repositories.length,
                separatorBuilder: (context, index) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final repository = repositories[index];
                  final isFavorite = _repositories.any((repo) => repo.id == repository['id']);

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
                            maxLines: 1,
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
                                  const SizedBox(width: 4),
                                  Text(repository['stargazers_count'].toString()),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.code),
                                  const SizedBox(width: 4),
                                  Text(repository['language'] ?? 'Unknow'),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.calendar_month_outlined),
                                  const SizedBox(width: 4),
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
                        onPressed: () => _toggleRepository(
                          repository['id'],
                          repository['name'],
                          repository['html_url'],
                        ),
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red.shade400 : Colors.grey,
                        ),
                        splashColor: isFavorite ? Colors.grey.shade50 : Colors.red.shade50,
                        splashRadius: 24,
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
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
                      'An error occurred, maybe the repository does not exist or multiple request i\'ve made, please try again later',
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
