/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Activity type in your schema. */
@immutable
class Activity extends Model {
  static const classType = const _ActivityModelType();
  final String id;
  final String? _activityName;
  final Trip? _trip;
  final TemporalDateTime? _activityDate;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get activityName {
    try {
      return _activityName!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Trip get trip {
    try {
      return _trip!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime get activityDate {
    try {
      return _activityDate!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Activity._internal({required this.id, required activityName, required trip, required activityDate, createdAt, updatedAt}): _activityName = activityName, _trip = trip, _activityDate = activityDate, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Activity({String? id, required String activityName, required Trip trip, required TemporalDateTime activityDate}) {
    return Activity._internal(
      id: id == null ? UUID.getUUID() : id,
      activityName: activityName,
      trip: trip,
      activityDate: activityDate);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Activity &&
      id == other.id &&
      _activityName == other._activityName &&
      _trip == other._trip &&
      _activityDate == other._activityDate;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Activity {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("activityName=" + "$_activityName" + ", ");
    buffer.write("trip=" + (_trip != null ? _trip!.toString() : "null") + ", ");
    buffer.write("activityDate=" + (_activityDate != null ? _activityDate!.format() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Activity copyWith({String? id, String? activityName, Trip? trip, TemporalDateTime? activityDate}) {
    return Activity._internal(
      id: id ?? this.id,
      activityName: activityName ?? this.activityName,
      trip: trip ?? this.trip,
      activityDate: activityDate ?? this.activityDate);
  }
  
  Activity.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _activityName = json['activityName'],
      _trip = json['trip']?['serializedData'] != null
        ? Trip.fromJson(new Map<String, dynamic>.from(json['trip']['serializedData']))
        : null,
      _activityDate = json['activityDate'] != null ? TemporalDateTime.fromString(json['activityDate']) : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'activityName': _activityName, 'trip': _trip?.toJson(), 'activityDate': _activityDate?.format(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "activity.id");
  static final QueryField ACTIVITYNAME = QueryField(fieldName: "activityName");
  static final QueryField TRIP = QueryField(
    fieldName: "trip",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Trip).toString()));
  static final QueryField ACTIVITYDATE = QueryField(fieldName: "activityDate");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Activity";
    modelSchemaDefinition.pluralName = "Activities";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: AuthRuleProvider.USERPOOLS,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Activity.ACTIVITYNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Activity.TRIP,
      isRequired: true,
      targetName: "tripID",
      ofModelName: (Trip).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Activity.ACTIVITYDATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _ActivityModelType extends ModelType<Activity> {
  const _ActivityModelType();
  
  @override
  Activity fromJson(Map<String, dynamic> jsonData) {
    return Activity.fromJson(jsonData);
  }
}