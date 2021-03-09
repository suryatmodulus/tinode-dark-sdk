import 'package:tinode/src/models/topic-subscription.dart';
import 'package:tinode/src/models/delete-transaction.dart';
import 'package:tinode/src/models/topic-description.dart';
import 'package:tinode/src/models/credential.dart';

class ServerMessage {
  final CtrlMessage ctrl;
  final MetaMessage meta;

  ServerMessage({this.ctrl, this.meta});

  static ServerMessage fromMessage(Map<String, dynamic> msg) {
    return ServerMessage(
      ctrl: msg['ctrl'] != null ? CtrlMessage.fromMessage(msg['ctrl']) : null,
      meta: msg['meta'] != null ? MetaMessage.fromMessage(msg['meta']) : null,
    );
  }
}

class CtrlMessage {
  /// Message Id
  final String id;

  /// Related topic
  final String topic;

  /// Message code
  final int code;

  /// Message text
  final String text;

  /// Message timestamp
  final DateTime ts;

  final dynamic params;

  CtrlMessage({
    this.id,
    this.topic,
    this.code,
    this.text,
    this.ts,
    this.params,
  });

  static CtrlMessage fromMessage(Map<String, dynamic> msg) {
    return CtrlMessage(
      id: msg['id'],
      code: msg['code'],
      text: msg['text'],
      topic: msg['topic'],
      params: msg['params'],
      ts: msg['ts'] != null ? DateTime.parse(msg['ts']) : DateTime.now(),
    );
  }
}

class MetaMessage {
  /// Message Id
  final String id;

  /// Related topic
  final String topic;

  /// Message timestamp
  final DateTime ts;

  /// Topic description, optional
  final TopicDescription desc;

  ///  topic subscribers or user's subscriptions, optional
  final List<TopicSubscription> sub;

  /// Array of tags that the topic or user (in case of "me" topic) is indexed by
  final List<String> tags;

  /// Array of user's credentials
  final List<UserCredential> cred;

  /// Latest applicable 'delete' transaction
  final DeleteTransaction del;

  MetaMessage({this.id, this.topic, this.ts, this.desc, this.sub, this.tags, this.cred, this.del});

  static MetaMessage fromMessage(Map<String, dynamic> msg) {
    return MetaMessage(
      id: msg['id'],
      topic: msg['topic'],
      ts: msg['ts'] != null ? DateTime.parse(msg['ts']) : DateTime.now(),
      desc: TopicDescription.fromMessage(msg['desc']),
      sub: msg['sub'] != null && msg['sub'].length != null ? msg['sub'].map((Map<String, dynamic> sub) => TopicSubscription.fromMessage(sub)) : [],
      tags: msg['tags'],
      cred: msg['cred'] != null && msg['cred'].length != null ? msg['cred'].map((Map<String, dynamic> cred) => UserCredential.fromMessage(cred)) : [],
      del: DeleteTransaction.fromMessage(msg['del']),
    );
  }
}
