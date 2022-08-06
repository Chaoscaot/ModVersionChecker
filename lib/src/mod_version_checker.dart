import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mod_version_checker/src/screens/selector_screen.dart';

import 'data/api_wrapper.dart';

class ModrinthTool extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        home: ModDirectorySelectorWidget(),
      ),
    );
  }
}
