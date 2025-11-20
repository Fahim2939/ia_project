// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final CommonSupabaseStorageRepositoryProvider = Provider((ref)=> CommonSupabaseStorageRepository(supabase: Supabase.instance.client));

class CommonSupabaseStorageRepository {
  final SupabaseClient _supabase;

  CommonSupabaseStorageRepository({required SupabaseClient supabase})
      : _supabase = supabase;

  /// Upload ANY file to Supabase Storage
  /// [bucket] → e.g., "profile", "chat", "videos"
  /// [path] → folder path inside bucket  e.g., "users/uid.png"
  Future<String> uploadFile({
    required String bucket,
    required String path,
    required File file,
  }) async {
    try {
      // Get file bytes
      final fileBytes = await file.readAsBytes();

      // Detect file type
      final contentType = lookupMimeType(file.path);

      // Upload
      final response = await _supabase.storage.from(bucket).uploadBinary(
            path,
            fileBytes,
            fileOptions: FileOptions(
              contentType: contentType,
              upsert: true, // overwrite if exists
            ),
          );

      if (response.isEmpty) {
        throw Exception("Upload failed");
      }

      // Return public URL
      final publicUrl = _supabase.storage.from(bucket).getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      throw Exception("Upload error: $e");
    }
  }
}
