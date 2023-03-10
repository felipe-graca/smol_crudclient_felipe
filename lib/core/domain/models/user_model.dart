// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? cpf;
  final String? birthDate;
  final String? gender;
  const UserModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.cpf,
    this.birthDate,
    this.gender,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? cpf,
    String? birthDate,
    String? gender,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      cpf: cpf ?? this.cpf,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
    );
  }

  static const empty = UserModel();

  Map<String, dynamic> toMap({required bool isNewUser}) {
    if (isNewUser) {
      return <String, dynamic>{
        'nome': name,
        'email': email,
        'telefone': phoneNumber,
        'cpf': cpf,
        'data_nascimento': birthDate,
        'sexo': gender,
      };
    }
    return <String, dynamic>{
      'id': id,
      'nome': name,
      'email': email,
      'telefone': phoneNumber,
      'cpf': cpf,
      'data_nascimento': birthDate,
      'sexo': gender,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['nome'] != null ? map['nome'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber: map['telefone'] != null ? map['telefone'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      birthDate: map['data_nascimento'] != null
          ? map['data_nascimento'] as String
          : null,
      gender: map['sexo'] != null ? map['sexo'] as String : null,
    );
  }

  String toJson({bool isNewUser = false}) =>
      json.encode(toMap(isNewUser: isNewUser));

  factory UserModel.fromJson(Map<String, dynamic> source) =>
      UserModel.fromMap(source);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, cpf: $cpf, birthDate: $birthDate, gender: $gender)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.cpf == cpf &&
        other.birthDate == birthDate &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        cpf.hashCode ^
        birthDate.hashCode ^
        gender.hashCode;
  }
}
