import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haadiya_portfolio/core/constants.dart';
import 'package:haadiya_portfolio/models/models.dart';

/// Exposes the portfolio content to the views.
class PortfolioViewModel {
  List<Stat> get stats => K.stats;
  List<Job> get jobs => K.jobs;
  List<Project> get projects => K.projects;
  List<StackGroup> get stack => K.stack;
}

final portfolioProvider = Provider((ref) => PortfolioViewModel());
