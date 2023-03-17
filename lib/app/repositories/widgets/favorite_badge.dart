import 'package:a3_test/app/favorites/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteBadge extends StatefulWidget {
  const FavoriteBadge({required this.child, super.key});

  final Widget child;

  @override
  State<FavoriteBadge> createState() => _FavoriteBadgeState();
}

class _FavoriteBadgeState extends State<FavoriteBadge> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesProvider>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: Consumer<FavoritesProvider>(
        builder: (context, favProvider, child) {
          return Text('${favProvider.favorites.length}');
        },
      ),
      alignment: AlignmentDirectional.bottomEnd,
      backgroundColor: Colors.white,
      textColor: Colors.blueAccent,
      textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
      child: widget.child,
    );
  }
}
