import 'package:flutter/material.dart';

import 'package:ussd_advanced/ussd_advanced.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController _controller;
  String? _response;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Ussd Plugin example')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // text input
            TextField(
              controller: _controller,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Ussd code'),
            ),

            // dispaly responce if any
            if (_response != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(_response!),
              ),

            // buttons
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      UssdAdvanced.sendUssd(
                        code: _controller.text,
                        subscriptionId: 1,
                      );
                    },
                    child: const Text('norma\nrequest'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      String? res = await UssdAdvanced.sendAdvancedUssd(
                        code: _controller.text,
                        subscriptionId: 1,
                      );
                      setState(() {
                        _response = res;
                      });
                    },
                    child: const Text('single session\nrequest'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      String? res = await UssdAdvanced.multisessionUssd(
                        code: _controller.text,
                        subscriptionId: 1,
                      );
                      setState(() {
                        _response = res;
                      });
                      String? res2 = await UssdAdvanced.sendMessage('0');
                      setState(() {
                        _response = res2;
                      });
                      await UssdAdvanced.cancelSession();
                    },
                    child: const Text('multi session\nrequest'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
