Welcome to the CopyPeste project.

Born from the recognition of a real lack of visibility about possible redundancies, duplications or vulnerabilities contained in openBSD's ports tree, CopyPeste is a research project which aims to analyze all these sources to generate data about the ports tree.
In order to find interesting data, several analysis modules are in development. Each of them  realizes simple tasks like finding all duplicate files in the ports tree (eg: FDF module). A Framework is also in construction to easily manage, configure and use the analysis modules.

Development currently in progress.

### Installation:

```sh
$> git clone https://github.com/CopyPeste/CopyPeste.git
$> make install
$> make gems
$> make init
```

### How to find duplicated files:

```sh
$> cd app
$> ruby copy_peste.rb
$> use fdf
$> run
```

For more information, please check our [wiki](https://github.com/CopyPeste/CopyPeste/wiki) (in french for the moment). 
