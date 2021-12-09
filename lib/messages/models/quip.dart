import 'package:epigram/messages/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Quip extends Equatable {
  final String id;
  final String userId;
  final String username;
  final String message;
  final String timestamp;

  const Quip(
    this.id,
    this.userId,
    this.username,
    this.message,
    this.timestamp,
  );

  Quip copyWith({
    String? id,
    String? userId,
    String? username,
    String? message,
    String? timestamp,
  }) {
    return Quip(
      id ?? this.id,
      userId ?? this.userId,
      username ?? this.username,
      message ?? this.message,
      timestamp ?? this.timestamp,
    );
  }

  Quip.fromJson(Map<String, dynamic> jsonData)
      : id = jsonData['aggregateId'],
        userId = jsonData['userId'],
        username = jsonData['username'],
        message = jsonData['message'],
        timestamp = jsonData['timestamp'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'username': username,
        'message': message,
        'timestamp': timestamp,
      };

  static Quip fromEntity(QuipEntity entity) {
    return Quip(
      entity.id,
      entity.userId,
      entity.username,
      entity.message,
      entity.timestamp,
    );
  }

  QuipEntity toEntity() {
    return QuipEntity(
      id,
      userId,
      username,
      message,
      timestamp,
    );
  }

  @override
  String toString() {
    return 'Quip{id: $id, userId: $userId, message: $message}';
  }

  @override
  List<Object?> get props => [id, userId, username, message, timestamp];
}
