import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_shortener/data/models/click_model.dart';
import 'package:link_shortener/data/data_sources/interface/click_remote_data_source.dart';
import 'package:link_shortener/data/exceptions/data_exception.dart';

class ClickRemoteDataSourceImpl implements ClickRemoteDataSource {
  final FirebaseFirestore firestore;
  ClickRemoteDataSourceImpl({required this.firestore});

  CollectionReference<Map<String, dynamic>> get _links => firestore.collection('links');

  @override
  Future<void> recordClick(ClickModel click) async {
    try {
      final docRef = _links.doc(click.linkId).collection('clicks').doc(click.id);
      final batch = firestore.batch();
      batch.set(docRef, click.toMap());
      final linkRef = _links.doc(click.linkId);
      batch.update(linkRef, {'clicksCount': FieldValue.increment(1)});
      await batch.commit();
    } catch (e, st) {
      throw DataSourceException('Failed to record click', e, st);
    }
  }

  @override
  Future<List<ClickModel>> getClicksForLinkId(String linkId) async {
    try {
      final snap = await _links.doc(linkId).collection('clicks').orderBy('clickedAt', descending: true).get();
      return snap.docs.map((d) {
        final m = d.data();
        m['id'] = d.id;
        return ClickModel.fromMap(m);
      }).toList();
    } catch (e, st) {
      throw DataSourceException('Failed to fetch clicks for link', e, st);
    }
  }
}
