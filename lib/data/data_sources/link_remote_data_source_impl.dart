import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_shortener/data/data_sources/interface/link_remote_data_source.dart';
import 'package:link_shortener/data/models/link_model.dart';
import 'package:link_shortener/data/exceptions/data_exception.dart';


class LinkRemoteDataSourceImpl implements LinkRemoteDataSource {
  final FirebaseFirestore firestore;
  LinkRemoteDataSourceImpl({required this.firestore});

  CollectionReference<Map<String, dynamic>> get _links => firestore.collection('links');

  @override
  Future<LinkModel> saveLink(LinkModel link) async {
    try {
      final docRef = _links.doc(link.id);
      await docRef.set(link.toMap());
      return link;
    } catch (e, st) {
      throw DataSourceException('Failed to save link', e, st);
    }
  }

  @override
  Future<void> deleteLink(String linkId) async {
    try {
      final docRef = _links.doc(linkId);
      final clicksSnap = await docRef.collection('clicks').get();
      final batch = firestore.batch();
      for (final d in clicksSnap.docs) {
        batch.delete(d.reference);
      }
      batch.delete(docRef);
      await batch.commit();
    } catch (e, st) {
      throw DataSourceException('Failed to delete link', e, st);
    }
  }

  @override
  Future<LinkModel?> getLinkByCode(String code) async {
    try {
      final q = await _links.where('shortCode', isEqualTo: code).limit(1).get();
      if (q.docs.isEmpty) return null;
      final d = q.docs.first;
      final data = d.data();
      data['id'] = d.id;
      return LinkModel.fromMap(data);
    } catch (e, st) {
      throw DataSourceException('Failed to get link by code', e, st);
    }
  }
}
