import 'package:a3_test/app/repositories/widgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:intl/intl.dart';

import 'package:a3_test/app/repositories/repositories_controller.dart';
import 'package:a3_test/app/repositories/repositories_model.dart';

class RepositoriesList extends StatefulWidget {
  const RepositoriesList({super.key});

  @override
  State<RepositoriesList> createState() => _RepositoriesListState();
}

class _RepositoriesListState extends State<RepositoriesList> {
  late List<Repository> repositories;

  @override
  void initState() {
    super.initState();
    loadRepositories().then((value) {
      setState(() {
        repositories = value;
      });
    });
  }

  Future<List<Repository>> loadRepositories() async {
    return await RepositoriesController().getFlutterRepositories();
  }

  Future<void> _refresh() async {
    final updatedRepos = await loadRepositories();
    setState(() {
      repositories = updatedRepos;
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);

    return FutureBuilder(
      future: loadRepositories(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Repository> repos = snapshot.data ?? [];

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              itemCount: repos.length,
              separatorBuilder: (context, index) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final repository = repos[index];

                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12.0,
                    ),
                    title: Text(repository.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          repository.description,
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
                                Text(repository.stars.toString()),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.code),
                                const SizedBox(width: 4),
                                Text(repository.language),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.calendar_month_outlined),
                                const SizedBox(width: 4),
                                Text(
                                  DateFormat.yMMMd().format(
                                    DateTime.parse(repository.createdAt),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: FavoriteButton(repository: repository),
                  ),
                );
              },
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${snapshot.error}',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => router.pushReplacement('/'),
                  child: const Text('Refresh'),
                ),
              ],
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
