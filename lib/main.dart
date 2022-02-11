import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ValueNotifier<int>>(
          create: (context) => ValueNotifier<int>(0),
        ),
        ChangeNotifierProvider<ValueNotifier<double>>(
          create: (context) => ValueNotifier<double>(0.0),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final intProvider = context.watch<ValueNotifier<int>>();
    print('value int: ${intProvider.value}');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Builder(
              builder: (context) {
                // method disini akan tetap dieksekusi ketika intProvider berubah,
                // mesikpun double provider tidak ada perubahan

                final doubleProvider = context.watch<ValueNotifier<double>>();
                print(
                    'double value changed in builder:  ${doubleProvider.value}');
                return Text('${doubleProvider.value}');
              },
            ),
            const ChildWidget(),
          ],
        ),
      ),
      persistentFooterButtons: [
        TextButton(
          onPressed: () {
            print('change int clicked');
            final intProvider = context.read<ValueNotifier<int>>();
            intProvider.value += 1;
          },
          child: const Text('Change int'),
        ),
        TextButton(
          onPressed: () {
            print('change double clicked');
            final intProvider = context.read<ValueNotifier<double>>();
            intProvider.value += 1;
          },
          child: const Text('Change double'),
        ),
      ],
    );
  }
}

class ChildWidget extends StatelessWidget {
  const ChildWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // method disini hanya akan dieksekusi ketika ada perubahan pada double provider
    final doubleProvider = context.watch<ValueNotifier<double>>();
    print('double value changed in ChildWidget: ${doubleProvider.value}');
    return Text('${doubleProvider.value}');
  }
}
