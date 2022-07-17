import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../main.dart';
import 'dart:io';

class StorageService {
  Future<String> getImageUrl(String key) async {
    final GetUrlResult result = await Amplify.Storage.getUrl(
      key: key,
      options: S3GetUrlOptions(expires: 60000),
    );
    return result.url;
  }
}

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

final imageUrlProvider =
    FutureProvider.autoDispose.family<String, String>((ref, key) {
  final storageService = ref.watch(storageServiceProvider);
  return storageService.getImageUrl(key);
});
