import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final route = GoRouter.of(context);
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('GitHub Repositories')),
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Flutter Repositories',
                style: theme.textTheme.displaySmall?.copyWith(color: Colors.grey.shade800),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: const ButtonStyle(
                  visualDensity: VisualDensity(horizontal: 4, vertical: 4),
                ),
                onPressed: () => route.push('/repositories/flutter'),
                child: Text(
                  'Check',
                  style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
