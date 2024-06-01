import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/custom_elevated_button.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () async {
              await _logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(
              child: Card(
                elevation: 5,
                color: Colors.white.withOpacity(0.9),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          snapshot.data!['profileImageUrl'] ??
                              'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Name: ',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                snapshot.data!['name'] ?? 'User Name',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Email: ',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                snapshot.data!['email'] ?? 'user@example.com',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomElevatedLoadingButton(
                        height: MediaQuery.of(context).size.height * 0.05,
                        onPressed: () async {
                          await _logout(context);
                        },
                        child: Row(
                          children: [
                            Text(
                              'Log out',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(Icons.logout)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, String>> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('name') ?? 'No Name';
    String email = prefs.getString('email') ?? 'No Email';
    String profileImageUrl = prefs.getString('profileImageUrl') ??
        'https://cdn-icons-png.flaticon.com/512/149/149071.png';
    return {
      'name': username,
      'email': email,
      'profileImageUrl': profileImageUrl,
    };
  }
}
