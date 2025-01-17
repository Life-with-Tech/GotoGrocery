import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tango/core/constants/app_colors.dart';
import 'package:tango/core/constants/coustom_toast.dart';
import 'package:tango/core/constants/data_loding.dart';
import 'package:tango/router/routing_service.dart';
import 'package:tango/state/providers/theme_provider.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create or Update a document in Firestore
  Future<void> setDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _db.collection(collection).doc(docId).set(data);
  }

  // Read (get) a document from Firestore
  Future<DocumentSnapshot> getDocument({
    required String collection,
    required String docId,
  }) async {
    return await _db.collection(collection).doc(docId).get();
  }

  // Read all documents in a Firestore collection
  Future<QuerySnapshot> getCollection({
    required String collection,
  }) async {
    return await _db.collection(collection).get();
  }

  // Update a specific field in Firestore
  Future<void> updateDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _db.collection(collection).doc(docId).update(data);
  }

  // Delete a document from Firestore
  Future<void> deleteDocument({
    required String collection,
    required String docId,
  }) async {
    await _db.collection(collection).doc(docId).delete();
  }

  static Future saveToFirestore(
    String collectionName,
    Map<String, dynamic> payload,
  ) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionRef = firestore.collection(collectionName);
    GlobalLoading.showLoadingDialog();
    await collectionRef.doc(payload["id"]).set(payload).then((onValue) {
      CustomToast.showToast(
        "Product Add Successfully",
        bgColor: themeProvider.isDark
            ? AppColors.darkSurface
            : AppColors.lightSurface,
        textColor: themeProvider.isDark
            ? AppColors.darkPrimary
            : AppColors.lightPrimary,
        fontSize: 15,
      );
    }).catchError((onError) {
      CustomToast.showToast(
        "Product Add Error :- ${onError.toString()}",
        bgColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: 15,
      );
    });
    RoutingService().goBack();
  }
}
