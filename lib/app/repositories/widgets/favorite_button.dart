import 'package:a3_test/app/favorites/favorites_provider.dart';
import 'package:a3_test/app/repositories/repositories_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.repository});
  final Repository repository;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesProvider>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoritesProvider>(context);
    final isFavorite = favProvider.favorites.any((fav) => fav.id == widget.repository.id);

    return IconButton(
      onPressed: () => favProvider.toggleFavorites(
        widget.repository.id,
        widget.repository.name,
        widget.repository.url,
      ),
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red.shade400 : Colors.grey,
      ),
      splashColor: isFavorite ? Colors.grey.shade50 : Colors.red.shade50,
      splashRadius: 32,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    );
  }
}
