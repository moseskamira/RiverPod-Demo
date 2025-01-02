// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deleteUserHash() => r'cab497aa48c53480f20e2b1697025d57edb5bd82';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [deleteUser].
@ProviderFor(deleteUser)
const deleteUserProvider = DeleteUserFamily();

/// See also [deleteUser].
class DeleteUserFamily extends Family<String> {
  /// See also [deleteUser].
  const DeleteUserFamily();

  /// See also [deleteUser].
  DeleteUserProvider call(
    String docId,
  ) {
    return DeleteUserProvider(
      docId,
    );
  }

  @override
  DeleteUserProvider getProviderOverride(
    covariant DeleteUserProvider provider,
  ) {
    return call(
      provider.docId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'deleteUserProvider';
}

/// See also [deleteUser].
class DeleteUserProvider extends Provider<String> {
  /// See also [deleteUser].
  DeleteUserProvider(
    String docId,
  ) : this._internal(
          (ref) => deleteUser(
            ref as DeleteUserRef,
            docId,
          ),
          from: deleteUserProvider,
          name: r'deleteUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteUserHash,
          dependencies: DeleteUserFamily._dependencies,
          allTransitiveDependencies:
              DeleteUserFamily._allTransitiveDependencies,
          docId: docId,
        );

  DeleteUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.docId,
  }) : super.internal();

  final String docId;

  @override
  Override overrideWith(
    String Function(DeleteUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteUserProvider._internal(
        (ref) => create(ref as DeleteUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        docId: docId,
      ),
    );
  }

  @override
  ProviderElement<String> createElement() {
    return _DeleteUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteUserProvider && other.docId == docId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, docId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeleteUserRef on ProviderRef<String> {
  /// The parameter `docId` of this provider.
  String get docId;
}

class _DeleteUserProviderElement extends ProviderElement<String>
    with DeleteUserRef {
  _DeleteUserProviderElement(super.provider);

  @override
  String get docId => (origin as DeleteUserProvider).docId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
