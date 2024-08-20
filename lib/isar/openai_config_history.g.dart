// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openai_config_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOpenaiConfigHistoryCollection on Isar {
  IsarCollection<OpenaiConfigHistory> get openaiConfigHistorys =>
      this.collection();
}

const OpenaiConfigHistorySchema = CollectionSchema(
  name: r'OpenaiConfigHistory',
  id: 7577703519246927726,
  properties: {
    r'apiBaseUrl': PropertySchema(
      id: 0,
      name: r'apiBaseUrl',
      type: IsarType.string,
    ),
    r'apiKey': PropertySchema(
      id: 1,
      name: r'apiKey',
      type: IsarType.string,
    ),
    r'model': PropertySchema(
      id: 2,
      name: r'model',
      type: IsarType.string,
    ),
    r'tag': PropertySchema(
      id: 3,
      name: r'tag',
      type: IsarType.string,
    ),
    r'temperature': PropertySchema(
      id: 4,
      name: r'temperature',
      type: IsarType.double,
    )
  },
  estimateSize: _openaiConfigHistoryEstimateSize,
  serialize: _openaiConfigHistorySerialize,
  deserialize: _openaiConfigHistoryDeserialize,
  deserializeProp: _openaiConfigHistoryDeserializeProp,
  idName: r'id',
  indexes: {
    r'tag': IndexSchema(
      id: -8827799455852696894,
      name: r'tag',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'tag',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _openaiConfigHistoryGetId,
  getLinks: _openaiConfigHistoryGetLinks,
  attach: _openaiConfigHistoryAttach,
  version: '3.1.8',
);

int _openaiConfigHistoryEstimateSize(
  OpenaiConfigHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.apiBaseUrl.length * 3;
  bytesCount += 3 + object.apiKey.length * 3;
  bytesCount += 3 + object.model.length * 3;
  bytesCount += 3 + object.tag.length * 3;
  return bytesCount;
}

void _openaiConfigHistorySerialize(
  OpenaiConfigHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.apiBaseUrl);
  writer.writeString(offsets[1], object.apiKey);
  writer.writeString(offsets[2], object.model);
  writer.writeString(offsets[3], object.tag);
  writer.writeDouble(offsets[4], object.temperature);
}

OpenaiConfigHistory _openaiConfigHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OpenaiConfigHistory();
  object.apiBaseUrl = reader.readString(offsets[0]);
  object.apiKey = reader.readString(offsets[1]);
  object.id = id;
  object.model = reader.readString(offsets[2]);
  object.tag = reader.readString(offsets[3]);
  object.temperature = reader.readDouble(offsets[4]);
  return object;
}

P _openaiConfigHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _openaiConfigHistoryGetId(OpenaiConfigHistory object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _openaiConfigHistoryGetLinks(
    OpenaiConfigHistory object) {
  return [];
}

void _openaiConfigHistoryAttach(
    IsarCollection<dynamic> col, Id id, OpenaiConfigHistory object) {
  object.id = id;
}

extension OpenaiConfigHistoryByIndex on IsarCollection<OpenaiConfigHistory> {
  Future<OpenaiConfigHistory?> getByTag(String tag) {
    return getByIndex(r'tag', [tag]);
  }

  OpenaiConfigHistory? getByTagSync(String tag) {
    return getByIndexSync(r'tag', [tag]);
  }

  Future<bool> deleteByTag(String tag) {
    return deleteByIndex(r'tag', [tag]);
  }

  bool deleteByTagSync(String tag) {
    return deleteByIndexSync(r'tag', [tag]);
  }

  Future<List<OpenaiConfigHistory?>> getAllByTag(List<String> tagValues) {
    final values = tagValues.map((e) => [e]).toList();
    return getAllByIndex(r'tag', values);
  }

  List<OpenaiConfigHistory?> getAllByTagSync(List<String> tagValues) {
    final values = tagValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'tag', values);
  }

  Future<int> deleteAllByTag(List<String> tagValues) {
    final values = tagValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'tag', values);
  }

  int deleteAllByTagSync(List<String> tagValues) {
    final values = tagValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'tag', values);
  }

  Future<Id> putByTag(OpenaiConfigHistory object) {
    return putByIndex(r'tag', object);
  }

  Id putByTagSync(OpenaiConfigHistory object, {bool saveLinks = true}) {
    return putByIndexSync(r'tag', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTag(List<OpenaiConfigHistory> objects) {
    return putAllByIndex(r'tag', objects);
  }

  List<Id> putAllByTagSync(List<OpenaiConfigHistory> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'tag', objects, saveLinks: saveLinks);
  }
}

extension OpenaiConfigHistoryQueryWhereSort
    on QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QWhere> {
  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension OpenaiConfigHistoryQueryWhere
    on QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QWhereClause> {
  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterWhereClause>
      tagEqualTo(String tag) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tag',
        value: [tag],
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterWhereClause>
      tagNotEqualTo(String tag) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tag',
              lower: [],
              upper: [tag],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tag',
              lower: [tag],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tag',
              lower: [tag],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tag',
              lower: [],
              upper: [tag],
              includeUpper: false,
            ));
      }
    });
  }
}

extension OpenaiConfigHistoryQueryFilter on QueryBuilder<OpenaiConfigHistory,
    OpenaiConfigHistory, QFilterCondition> {
  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiBaseUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apiBaseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiBaseUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'apiBaseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiBaseUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'apiBaseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiBaseUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'apiBaseUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiBaseUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'apiBaseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiBaseUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'apiBaseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiBaseUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'apiBaseUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiBaseUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'apiBaseUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiBaseUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apiBaseUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiBaseUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'apiBaseUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'apiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'apiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'apiKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'apiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'apiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'apiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'apiKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apiKey',
        value: '',
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      apiKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'apiKey',
        value: '',
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      modelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      modelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      modelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      modelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'model',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      modelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      modelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      modelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      modelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'model',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      modelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model',
        value: '',
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      modelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'model',
        value: '',
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      tagEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      tagGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      tagLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      tagBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tag',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      tagStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      tagEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      tagContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      tagMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tag',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      tagIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tag',
        value: '',
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      tagIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tag',
        value: '',
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      temperatureEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'temperature',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      temperatureGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'temperature',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      temperatureLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'temperature',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterFilterCondition>
      temperatureBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'temperature',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension OpenaiConfigHistoryQueryObject on QueryBuilder<OpenaiConfigHistory,
    OpenaiConfigHistory, QFilterCondition> {}

extension OpenaiConfigHistoryQueryLinks on QueryBuilder<OpenaiConfigHistory,
    OpenaiConfigHistory, QFilterCondition> {}

extension OpenaiConfigHistoryQuerySortBy
    on QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QSortBy> {
  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      sortByApiBaseUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiBaseUrl', Sort.asc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      sortByApiBaseUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiBaseUrl', Sort.desc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      sortByApiKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiKey', Sort.asc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      sortByApiKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiKey', Sort.desc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      sortByModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.asc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      sortByModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.desc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      sortByTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tag', Sort.asc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      sortByTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tag', Sort.desc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      sortByTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperature', Sort.asc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      sortByTemperatureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperature', Sort.desc);
    });
  }
}

extension OpenaiConfigHistoryQuerySortThenBy
    on QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QSortThenBy> {
  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      thenByApiBaseUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiBaseUrl', Sort.asc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      thenByApiBaseUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiBaseUrl', Sort.desc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      thenByApiKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiKey', Sort.asc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      thenByApiKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiKey', Sort.desc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      thenByModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.asc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      thenByModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.desc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      thenByTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tag', Sort.asc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      thenByTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tag', Sort.desc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      thenByTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperature', Sort.asc);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QAfterSortBy>
      thenByTemperatureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperature', Sort.desc);
    });
  }
}

extension OpenaiConfigHistoryQueryWhereDistinct
    on QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QDistinct> {
  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QDistinct>
      distinctByApiBaseUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'apiBaseUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QDistinct>
      distinctByApiKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'apiKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QDistinct>
      distinctByModel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'model', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QDistinct>
      distinctByTag({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tag', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QDistinct>
      distinctByTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'temperature');
    });
  }
}

extension OpenaiConfigHistoryQueryProperty
    on QueryBuilder<OpenaiConfigHistory, OpenaiConfigHistory, QQueryProperty> {
  QueryBuilder<OpenaiConfigHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<OpenaiConfigHistory, String, QQueryOperations>
      apiBaseUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apiBaseUrl');
    });
  }

  QueryBuilder<OpenaiConfigHistory, String, QQueryOperations> apiKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apiKey');
    });
  }

  QueryBuilder<OpenaiConfigHistory, String, QQueryOperations> modelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'model');
    });
  }

  QueryBuilder<OpenaiConfigHistory, String, QQueryOperations> tagProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tag');
    });
  }

  QueryBuilder<OpenaiConfigHistory, double, QQueryOperations>
      temperatureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'temperature');
    });
  }
}
