import 'package:flutter/material.dart';
import 'package:sunu_task/core/constants/app_colors.dart';
import 'package:sunu_task/core/constants/app_strings.dart';

// === PARTIE 4 ===
// Import des tabs
import 'tabs/dashboard_tab.dart';
import 'tabs/projects_tab.dart';
import 'tabs/tasks_tab.dart';
import 'tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // === PARTIE 4 ===
  // Index de l'onglet actif
  int _currentIndex = 0;

  // Liste des onglets
  final List<Widget> _tabs = const [
    DashboardTab(),
    ProjectsTab(),
    TasksTab(),
    ProfileTab(),
  ];

  // Changer d'onglet
  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // FloatingActionButton visible seulement sur Dashboard et Projects
  bool get _showFab => _currentIndex == 0 || _currentIndex == 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ===== APP BAR =====
      appBar: AppBar(
        title: Text(AppStrings.appName),
        backgroundColor: AppColors.primary,
      ),

      // ===== DRAWER =====
      drawer: Drawer(
        child: Column(
          children: [

            // Header utilisateur
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primary,
              ),
              accountName: const Text("Utilisateur"),
              accountEmail: const Text("user@email.com"),
              currentAccountPicture: const CircleAvatar(
                child: Text(
                  "U",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),

            // Navigation items
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () {
                _onTabSelected(0);
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text("Projets"),
              onTap: () {
                _onTabSelected(1);
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.list),
              title: const Text("Tâches"),
              onTap: () {
                _onTabSelected(2);
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profil"),
              onTap: () {
                _onTabSelected(3);
                Navigator.pop(context);
              },
            ),

            const Spacer(),

            const Divider(),

            // Déconnexion
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Déconnexion"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // ===== BODY =====
      // IndexedStack pour préserver l'état des onglets
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),

      // ===== FLOATING ACTION BUTTON =====
      floatingActionButton: _showFab
          ? FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          // Création nouveau projet
        },
        child: const Icon(Icons.add),
      )
          : null,

      // ===== BOTTOM NAVIGATION =====
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: "Projets",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Tâches",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}