# TaskManager 📝

Un gestionnaire de tâches en ligne de commande développé en **Dart**.  
Ce projet permet de créer, gérer, sauvegarder et tester des tâches avec persistance en **JSON**.

---

## 🚀 Fonctionnalités
- Ajouter, modifier et supprimer des tâches
- Gestion des exceptions personnalisées
- Sauvegarde et lecture des données en JSON
- Organisation du code en classes et fonctions modulaires
- Tests unitaires avec `task_test.dart`

---

## 📂 Structure du projet
TaskManager/ \
├── bin/ \
│   └── main.dart        # Point d'entrée principal \
│   \
├── data/ \
│   └── tasks.json               # Fichier de persistance des tâches \
│   \
├── lib/ \
│   └── entry_checker/         # Verification des saisies de l'utilisateur \
│   └── exceptions/            # Implementation des Exceptions personnalisées \
│   └── models.dart/           # Définition des differens class Task, SimpleTask, UrgentTask \
│   └── repository.dart/       # Définition de la repository \
│   └── services/              # Définition des differentes actions \
│   \
├── test/ \
│   └── task_manager_test.dart         # Tests unitaires \
├── pubspec.yaml                 # Dépendances et configuration \
├── README.md                    # Documentation du projet \


---

## ⚙️ Installation
1. Cloner le dépôt :
   ```bash
   git clone https://github.com/alionel76/TaskManagerUpdated.git
   cd TaskManagerUpdated
   ```
2. Installer les dépendances :
    ```bash
   dart pub get
   ````

---

## ▶️ Utilisation
Exécuter le programme principal :
   ```bash
   dart run bin/main.dart
   ```

---

## 🧪 Tests
   ```bash
   dart test test/task_test.dart
   ```

---

## 📌 Prérequis
1. Dart SDK ≥ 3.0
2. VS Code ou Android Studio recommandé pour le développement

---

## 📖 À propos
Ce projet a été fait pour apprendre et pratiquer :
1. La programmation orientée objet en Dart
2. La gestion des fichiers JSON
3. Les exceptions et tests unitaires
4. Le développement d’applications CLI

---

## 🤝 Contribution
Les contributions sont les bienvenues !

---

## 📜 Licence
Libre d'accès.

