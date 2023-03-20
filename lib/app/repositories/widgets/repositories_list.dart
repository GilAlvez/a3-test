import 'package:a3_test/app/repositories/widgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:intl/intl.dart';

import 'package:a3_test/app/repositories/repositories_controller.dart';
import 'package:a3_test/app/repositories/repositories_model.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoriesList extends StatefulWidget {
  const RepositoriesList({super.key});

  @override
  State<RepositoriesList> createState() => _RepositoriesListState();
}

class _RepositoriesListState extends State<RepositoriesList> {
  late List<Repository> repositories;
  final controller = RepositoriesController();

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
    return await controller.getRepositoriesByUsername('flutter');
  }

  Future<void> _refresh() async {
    final updatedRepos = await loadRepositories();
    setState(() {
      repositories = updatedRepos;
    });
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadRepositories(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Repository> loadedRepositories = snapshot.data ?? [];

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              itemCount: loadedRepositories.length,
              separatorBuilder: (context, index) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final repository = loadedRepositories[index];

                return Card(
                  child: ListTile(
                    onTap: () => _launchUrl(Uri.parse(repository.url)),
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
                          mainAxisAlignment: MediaQuery.of(context).orientation == Orientation.landscape
                              ? MainAxisAlignment.spaceEvenly
                              : MainAxisAlignment.spaceBetween,
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
                SizedBox(
                  width: 360,
                  child: Text(
                    '${snapshot.error}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => context.pushReplacement('/'),
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
