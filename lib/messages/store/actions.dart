import 'package:epigram/app/models.dart';
import 'package:epigram/messages/models.dart';

class LoadQuipsAction {}

class CreateQuipAction {
  final Quip quip;

  const CreateQuipAction(this.quip);
}

class AddQuipAction {
  final Quip quip;

  const AddQuipAction(this.quip);
}

class DeleteQuipAction {
  final String id;

  const DeleteQuipAction(this.id);
}

class UpdateQuipAction {
  final Quip quip;

  const UpdateQuipAction(this.quip);
}

class QuipsNotLoadedAction {}

class QuipsLoadedAction {
  final List<Quip> quips;

  const QuipsLoadedAction(this.quips);
}

class UpdateTabAction {
  final BottomNavTab newTab;

  const UpdateTabAction(this.newTab);

  @override
  String toString() {
    return 'UpdateTabAction{newTab: $newTab}';
  }
}

class ExpressEmoteForQuip {
  final String emote;

  const ExpressEmoteForQuip(this.emote);
}
