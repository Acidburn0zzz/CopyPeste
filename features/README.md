-- CUCUMBER CopyPeste --
========================

<img src="https://github.com/CopyPeste/CopyPeste/blob/master/documentation/images/british_flag.jpg" width="150">

Unit test - procedure
=====================

___

1. Introduction
---------------

Cucumber tools allow each to implement easily and quickly units tests into CopyPeste.
https://cucumber.io/

___

2. Utilisation
--------------

###	a. The commands

The commands to run tests must be in the repository unit_test in project root.
```shell
$rake [options]
```

###	b. The options

To get possible options, you need use the next command, it show each possibilities.
```shell
$rake
```
The options allow to define directory in "path_tests" tree which will be executed.

___

3 - Unit test implementation
----------------------------

###     a. In CopyPeste branches

Each branch in CopyPeste tree must contain a "unit_test" folder.
This allows to dissociate software and tests.

The folder contains the prototype of the test file.

###     b. Test system tree

unit_test tree

```
unit_test/
├── example
│   └── unit_test
├── features
│   ├── scenarios
│   │   ├── app
│   │   ├── config
│   │   ├── examples
│   │   ├── libs
│   │   ├── modules
│   │   └── scripts
│   ├── step_definitions
│   │   ├── app
│   │   ├── config
│   │   ├── examples
│   │   ├── libs
│   │   ├── modules
│   │   └── scripts
│   └── support
└── path_tests
    ├── app
    │   ├── commands
    │   └── core
    ├── config
    ├── examples
    ├── libs
    │   ├── app
    │   ├── graphics
    │   └── modules
    ├── modules
    │   ├── analysis
    │   └── graphics
    └── scripts
```

####Descriptions:
- **example**, it contains example code, there are two type, functional and another with an error.
- **features**, Cucumber repository will be executed via the Rakefile.
- **features -> scenario**, it contains project tree of CopyPeste which link with various scenarios executable.
- **features -> step_definitions**, it contains executable steps, it will find in "path_tests" dossier.
- **features -> support**, Cucumber configuration.
- **path_tests**, it contains CopyPeste tree, each repository must have symbolics links toward executable tests.

The folder "path_tests" contains symbolic links toward tests files.
```shell
$ln -s TARGET LINK_NAME
```
Symbolic links, example:
```
ccb_my_super_test.rb -> path/to/my/test/file/unit_test/ccb_my_super_test.rb
```

**BE CAREFUL**, "path_tests" is the only folder to be used to add tests.

###  c. Prototype of test file

The test files must be prototype in a specific way.
First of all, the files names must begin with "ccb" (cucumber call back), it allows to have a global tests files name, more it must be ruby type, example: ccb_my_super_test.rb

The code contained in file called via Cucumber must be **always filled in of the next manner**:
```ruby
Given /^step ccb_my_super_test loading$/ do
      #	     Your arguments
end

When /^step ccb_my_super_test checking$/ do
end

Then /^step ccb_my_super_test resulting$/ do
end
```

"ccb_my_super_test" will have to be modified under test file name without the extension.

**BE CAREFUL**, the test files need to use "require_relative" to include files.
"require_relative" allows you to load a file that is relative to the file containing the "require_relative" statement.

###		   d. Problem indication

To indicate a note problem at Cucumber, it simply to use "pending", this will stop the process and Cucumber will show the error for user.
You can add a message, like this:
```ruby
pending("ccb_my_super_test task x FAIL")
```
If you want, you can stop step without the error message, it simply to use:
```ruby
skip_this_scenario
```

4 - Steps
-----------

* In **your branch**
  - Add "unit_test" folder.  
 **=>** This allows to dissociate your development and your test.
  - Create "ccb_your_name.rb" in your folder.  
 **=>** Now, you can implement your code test with the prototype of the test file.
* In **main "unit_test" directory**
  - Add a symbolic link between "path_tests" and your "unit_test" folder.  
 **=>** The symbolic link must be a path in "path_test" similar than your branch.  
 **=>** Your symbolic link should have the same name than your test file.
  - Now, you can try.  
 **=>** Use the "rake" command.

5 - Updates
-----------

For update refer you at: [Flatch78](https://github.com/Flatch78) OR [kashimsax](https://github.com/kashimsax)

___
___
___

<img src="https://github.com/CopyPeste/CopyPeste/blob/master/documentation/images/french_flag.jpg" width="150">

Unit test - procédure
=====================

___

1. Introduction
---------------

L'outil Cucumber permet à chacun d'implémenter facilement et rapidement les tests unitaires dans CopyPeste.
https://cucumber.io/

___

2. Utilisation
--------------

###	a. Les commandes

Les commandes pour lancer les tests doivent se faire dans le dossier unit_test à la racine du projet.
```shell
$rake [options]
```

###	b. Les options

Pour obtenir les options possibles, il suffit d'utiliser la commande suivante qui affichera les différentes possibilités.
```shell
$rake
```
Les options permettent de définir le dossier dans l'arborescence "path_tests" qui sera exécutée.

___

3 - Mise en place d'un test unitaire
------------------------------------

###     a. Les branches de CopyPeste

Chaque branche dans l'arbre de CopyPeste doit contenir un dossier "unit_test".
Celui-ci permet de bien dissocier le logiciel et des tests.

Ce dossier contient le prototype du fichier de test

### 	   b. Arborescence du système de test

unit_test tree

```
unit_test/
├── example
│   └── unit_test
├── features
│   ├── scenarios
│   │   ├── app
│   │   ├── config
│   │   ├── examples
│   │   ├── libs
│   │   ├── modules
│   │   └── scripts
│   ├── step_definitions
│   │   ├── app
│   │   ├── config
│   │   ├── examples
│   │   ├── libs
│   │   ├── modules
│   │   └── scripts
│   └── support
└── path_tests
    ├── app
    │   ├── commands
    │   └── core
    ├── config
    ├── examples
    ├── libs
    │   ├── app
    │   ├── graphics
    │   └── modules
    ├── modules
    │   ├── analysis
    │   └── graphics
    └── scripts
```

####Descriptions:
- **example**, contient un exemple de code testé, il y a deux types, fonctionnel et un second contenant une erreur.
- **features**, répertoire de Cucumber qui sera exécuté via le Rakefile.
- **features -> scenario**, contient l'arborescence du projet CopyPeste qui est lié aux différents scénarios à exécuter.
- **features -> step_definitions**, détient les étapes qui seront exécutées, il va les chercher dans le dossier "path_tests".
- **features -> support**, configuration de Cucumber.
- **path_tests**, contient l'arborescence de CopyPeste, chaque dossier doit contenir un lien symbolique vers les tests à exécuter.

Les répertoires dans "path_tests" contiendront les liens symboliques vers les fichiers de tests.
```shell
$ln -s TARGET LINK_NAME
```
Lien sympbolique, example:
```
ccb_my_super_test.rb -> path/to/my/test/file/unit_test/ccb_my_super_test.rb
```

**ATTENTION**, "path_tests" est le seul dossier à utiliser pour la mise en place des tests.

###	       c. Prototype du fichier de test

Les fichiers test doivent être prototypés d'une certaine manière.
Tout d'abord, les noms des fichiers doivent commencer par "ccb" (Cucumber Call Back) cela permet d'avoir un nom global aux fichiers de tests, de plus il doit être de type ruby, exemple: ccb_my_super_test.rb

Le code contenu dans le fichier appelé via Cucumber devra **toujours être rempli de cette manière**:
```ruby
Given /^step ccb_my_super_test loading$/ do
      #	     Your arguments
end

When /^step ccb_my_super_test checking$/ do
end

Then /^step ccb_my_super_test resulting$/ do
end
```

"ccb_my_super_test" devra être modifié selon le nom du fichier test sans l'extension.

**ATTENTION**, Les fichiers de tests doivent utiliser "require_relative" pour inclure des fichiers.
"require_relative" permet de charger un fichier avec un chemin relatif au fichier qui contient la déclaration "require_relative".

###		   d. Indiquer un problème

Pour indiquer à Cucumber qu'un problème a été constaté, il suffit d'utiliser "pending", cela arrêtera le processus et Cucumber indiquera l'erreur à l'utilisateur.
Vous pouvez y ajouter un message:
```ruby
pending("ccb_my_super_test task x FAIL")
```

Si vous souhaitez arrêter l'étape sans afficher de message spécifique, il suffit d'utiliser:
```ruby
skip_this_scenario
```

4 - Steps
-----------

* Dans **votre branche**
  - Ajout du dossier "unit_test".  
 **=>** Celui-ci permet de dissocier votre développement et vos tests.
  - Créer le fichier "ccb_your_name.rb" dans votre dossier de test.  
 **=>** Maintenant, vous pouvez implémenter votre code de test avec le prototype du fichier de test.
* Dans **le répertoire principale "unit_test"**
  - Ajouter le lien symbolique entre "path_tests" et votre dossier "unit_test".  
 **=>** Le chemin de votre lien symbolique dans "path_test" doit être similaire au chemin de votre branche.  
 **=>** Votre lien symbolique doit avoir le même nom que votre fichier de test.
  - Maintenant, vous pouvez essayer.  
 **=>** Utilisez la commande "rake".

5 - Mise à jours
----------------

Pour toute mises à jours merci de se référer à: [Flatch78](https://github.com/Flatch78) OR [kashimsax](https://github.com/kashimsax)
