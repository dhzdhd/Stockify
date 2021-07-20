import 'package:stockify/backend/auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Object? user;
Auth? authInstance;

final String supabaseUrl = dotenv.env['SUPABASE_URL'] as String;
final String supabaseKey = dotenv.env['SUPABASE_KEY'] as String;
