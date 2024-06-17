import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'tc.dart';

/// This sample app shows an app with two screens.
///
/// The first route '/' is mapped to [HomeScreen], and the second route
/// '/details' is mapped to [DetailsScreen].
///
/// The buttons use context.go() to navigate to each destination. On mobile
/// devices, each destination is deep-linkable and on the web, can be navigated
/// to using the address bar.
///

late TC tc;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tc = TC();

  return runApp(const MyApp());
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const DetailsScreen();
          },
        ),
        GoRoute(
          path: 'details_with_id/:id',
          builder: (BuildContext context, GoRouterState state) {
            return DetailsScreen(id: state.pathParameters["id"]);
          },
        )
      ],
    ),
  ],
  observers: [TCObserver()],
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

class TCObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    Map<String, dynamic> event = makeEvent("didPush", route, previousRoute);

    tc.sendCustomEvent(
        page_name: route.settings.name!, key: "GoRoute", value: event);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    Map<String, dynamic> event = makeEvent("didPop", route, previousRoute);

    tc.sendCustomEvent(
        page_name: route.settings.name!, key: "GoRoute", value: event);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    Map<String, dynamic> event = makeEvent("didRemove", route, previousRoute);

    tc.sendCustomEvent(
        page_name: route.settings.name!, key: "GoRoute", value: event);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    Map<String, dynamic> event = makeEvent("didReplace", newRoute!, oldRoute);

    tc.sendCustomEvent(
        page_name: newRoute.settings.name!, key: "GoRoute", value: event);
  }

  Map<String, dynamic> makeEvent(
      String action, Route<dynamic> route, Route<dynamic>? previousRoute) {
    Map<String, dynamic> event = {
      "action": action,
      "arguments": route.settings.arguments
    };
    if (previousRoute != null) {
      event["previous_route"] = previousRoute.settings.name;
    }
    return event;
  }
}
