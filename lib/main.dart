import 'package:flutter/material.dart';
import 'package:integrative/auth/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://vjsbvmwyecfndohtkocp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZqc2J2bXd5ZWNmbmRvaHRrb2NwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM1MjkzNDUsImV4cCI6MjAyOTEwNTM0NX0.q90kS0iJMo126dCj6Pd4d-o1Mx612GS79bFBrGC4BPQ',
  );
  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

