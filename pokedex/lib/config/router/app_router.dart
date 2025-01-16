import 'package:go_router/go_router.dart';
import 'package:pokedex/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: "/pokemons",
  routes: [
    GoRoute(
      path: '/pokemons',
      name: PokemonScreen.name,
      builder: (context, state) => const PokemonScreen(),
      routes: [
        GoRoute(
            path: 'pokemon/:id',
            name: PokemonDetailsScreen.name,
            builder: (context, state) =>
                PokemonDetailsScreen(pokemonId: state.pathParameters['id']!)),
      ],
    ),
    GoRoute(path: "/", redirect: (_, __) => '/pokemons')
  ],
);
