# Riverpod Demo

## Prerequisites

In order to be able to setup and run this application, the following need to be installed and setup

- [Flutter](https://docs.flutter.dev/get-started/install)
- [Android Studio](https://developer.android.com/studio)
- [VS Code](https://code.visualstudio.com/)

## Project Setup

To setup the project in your machine:

- Clone the repo

```console
foo@bar:~$ git clone git@github.com:moseskamira/RiverPod-Demo.git
```
- CD into the repo and install the dependencies

```console
foo@bar:~$ cd RiverPod-Demo
```

```console
foo@bar:~$ flutter pub get
```

- Run the build runner in all packages to generate required files

```console
dart run build_runner watch --delete-conflicting-outputs
```
## Project Implemented Concepts
- Riverpod: Statement Management
- Providers: State Management
- GoRouters: Route Management
- FirebaseFirestore: Data Storage and Retrieval
- GetIt: For Dependency Injection
- Localization & Internationalization