import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/*
   ==> note for CommandersAct
  import TC !
*/
import 'tc.dart';
import 'package:tccore_plugin/TCDebug.dart';

/// This sample app shows an app with two screens, but three routes.
///
/// The first route '/' is mapped to [HomeScreen], and the second route
/// '/details' is mapped to [DetailsScreen].
/// 'details_with_id/:id' is mapped to [DetailsScreen] with id as a parameter.
///
/// The buttons use context.go() to navigate to each destination. On mobile
/// devices, each destination is deep-linkable and on the web, can be navigated
/// to using the address bar.
///

late TC tc;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /*
    ==> note for CommandersAct
    init TC !
  */
  tc = TC(
      siteId: 7244,
      privacyId: 6,
      sourceKey: "cbd9693f-37c9-4130-92d7-9f77b835c991");

  TCDebug().setDebugLevel(TCLogLevel.TCLogLevel_Verbose);

  return runApp(const MyApp());
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'accueil',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          name: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const DetailsScreen();
          },
        ),
        GoRoute(
          path: 'details_with_id/:id',
          name: 'details with id',
          builder: (BuildContext context, GoRouterState state) {
            return DetailsScreen(id: state.pathParameters["id"]);
          },
        )
      ],
    ),
  ],
  observers: [tc.getTCObserver()],
);

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

/// The home screen
class HomeScreen extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => context.go('/details'),
              child: const Text('Go to the Details screen'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/details_with_id/12'),
              child: const Text('Go to the Details2 screen'),
            )
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatefulWidget {
  final String? id;
  const DetailsScreen({super.key, this.id});

  @override
  State<StatefulWidget> createState() {
    return DetailsScreenState();
  }
}

// Create a corresponding State class.
class DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String title = "Details Screen";
    if (widget.id != null) {
      title = "Details Screen with id: ${widget.id}";
    }
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Go back to the Home screen'),
        ),
      ),
    );
  }
}
