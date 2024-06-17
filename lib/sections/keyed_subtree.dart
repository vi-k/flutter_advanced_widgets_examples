import 'package:flutter/material.dart';

class KeyedSubtreeApp extends StatelessWidget {
  const KeyedSubtreeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomeScreen(title: 'Keyed subtree'),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key, required this.title});

  final String title;

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  String? _user;

  void _signIn(String login) {
    setState(() {
      _user = login;
    });
  }

  void _signOut() {
    setState(() {
      _user = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SignIn(_signIn),
            if (_user != null)
              Expanded(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    User(_user!),
                    const SizedBox(height: 10),
                    SignOut(_signOut),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SignIn extends StatelessWidget {
  const SignIn(this.onLogin);

  final void Function(String login) onLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Sign in:'),
        TextField(
          onSubmitted: onLogin,
        ),
      ],
    );
  }
}

class SignOut extends StatefulWidget {
  const SignOut(
    this.onSignOut, {
    super.key,
    this.user,
  });

  final void Function() onSignOut;
  final String? user;

  @override
  State<SignOut> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  String? _user;

  @override
  void initState() {
    super.initState();

    _user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onSignOut,
      child: _user == null
          ? const Text('Sign out')
          : Text('Sign out $_user'),
    );
  }
}

class UserInfo {
  final String confidentialData;

  UserInfo(this.confidentialData);
}

class User extends StatefulWidget {
  final String user;

  const User(this.user, {super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  UserInfo? _userInfo;

  @override
  void initState() {
    super.initState();

    _loadUserInfo(widget.user).then((info) {
      setState(() {
        _userInfo = info;
      });
    });
  }

  @override
  void dispose() {
    /// ...

    super.dispose();
  }

  Future<UserInfo> _loadUserInfo(String user) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    return UserInfo('Confidential data for user `$user`');
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = _userInfo;

    return userInfo == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.user),
              Text(userInfo.confidentialData),
            ],
          );
  }
}
