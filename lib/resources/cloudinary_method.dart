import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

// Simple Cloudinary upload method for images
class CloudinaryMethod {
  final _cloudName = 'dk4mauujs';
  final _uploadPreset = 'instaclone';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToCloudinary({
    required Uint8List file,
    String? folder,
    String? publicId,
  }) async {
    try {
      final url =
      Uri.parse('https://api.cloudinary.com/v1_1/$_cloudName/image/upload');

      final request = http.MultipartRequest('POST', url);

      // Add upload preset (required for unsigned uploads)
      request.fields['upload_preset'] = _uploadPreset;

      // Add optional folder
      if (folder != null) {
        request.fields['folder'] = folder;
      }

      // Add optional public ID
      if (publicId != null) {
        request.fields['public_id'] = publicId;
      }

      // Add the current user's UID as a tag for organization
      if (_auth.currentUser != null) {
        request.fields['tags'] = _auth.currentUser!.uid;
      }

      // Add the image file
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          file,
          filename: 'upload_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      );

      // Send request
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);

        // Return the secure URL
        return jsonMap['secure_url'];
      } else {
        throw Exception(
            'Failed to upload image to Cloudinary: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error uploading to Cloudinary: $e');
    }
  }

  /// Upload profile picture to Cloudinary
  Future<String> uploadProfilePicture(Uint8List file) async {
    final userId = _auth.currentUser!.uid;
    return await uploadImageToCloudinary(
      file: file,
      folder: 'profiles',
      publicId: userId, // This will replace old profile pics automatically
    );
  }

  /// Upload post image to Cloudinary
  Future<String> uploadPostImage(Uint8List file) async {
    final userId = _auth.currentUser!.uid;
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return await uploadImageToCloudinary(
      file: file,
      folder: 'posts',
      publicId: '${userId}_$timestamp',
    );
  }
}
