import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'reports_record.g.dart';

abstract class ReportsRecord
    implements Built<ReportsRecord, ReportsRecordBuilder> {
  static Serializer<ReportsRecord> get serializer => _$reportsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  String get typeCrime;

  @nullable
  @BuiltValueField(wireName: 'Location')
  String get location;

  @nullable
  DateTime get dateTime;

  @nullable
  @BuiltValueField(wireName: 'Details')
  String get details;

  @nullable
  String get dataTime;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ReportsRecordBuilder builder) => builder
    ..typeCrime = ''
    ..location = ''
    ..details = ''
    ..dataTime = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('reports');

  static Stream<ReportsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<ReportsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ReportsRecord._();
  factory ReportsRecord([void Function(ReportsRecordBuilder) updates]) =
      _$ReportsRecord;

  static ReportsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createReportsRecordData({
  DateTime createdTime,
  String typeCrime,
  String location,
  DateTime dateTime,
  String details,
  String dataTime,
}) =>
    serializers.toFirestore(
        ReportsRecord.serializer,
        ReportsRecord((r) => r
          ..createdTime = createdTime
          ..typeCrime = typeCrime
          ..location = location
          ..dateTime = dateTime
          ..details = details
          ..dataTime = dataTime));
