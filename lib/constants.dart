import 'package:flutter_dotenv/flutter_dotenv.dart';

final String supabaseUrl = dotenv.env['SUPABASE_URL'].toString();
final String supabaseKey = dotenv.env['SUPABASE_KEY'].toString();

String? email;
String? password;
