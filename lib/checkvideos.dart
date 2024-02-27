import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/sheets/v4.dart' as sheets;

class VideoSourcesManager {
  static final List<Map<String, dynamic>> videoSourcesData = [];

  static Future<void> fetchDataFromSpreadsheet() async {
    videoSourcesData.clear();
    // Load and authenticate using the credentials JSON file
    final credentials = auth.ServiceAccountCredentials.fromJson(
        await loadServiceAccountCredentials());
    final client = await auth.clientViaServiceAccount(
        credentials, [sheets.SheetsApi.spreadsheetsReadonlyScope]);

    // Spreadsheet ID can be found in the URL of the spreadsheet
    const spreadsheetId = "1I4nxbkwuZ-yyE-VSQNMXNDJs5aATlCV2f__N7jHnQ5M";

    // The range of cells you want to read from (e.g., "Sheet1!A2:C")
    const range =
        "Nursery-KG!A2:C"; // Adjust the sheet name and range accordingly

    try {
      var response = await sheets.SheetsApi(client)
          .spreadsheets
          .values
          .get(spreadsheetId, range);

      // Parse and store the data in audioSourcesData
      if (response.values != null && response.values!.isNotEmpty) {
        for (var row in response.values!) {
          // Ensure the row has three columns (URI, ID, Title)
          if (row.length >= 3) {
            final String uri = row[2] as String;
            final String id = row[0] as String;
            final String title = row[1] as String;
            videoSourcesData.add({
              'uri': uri,
              'id': id,
              'title': title,
            });
          }
        }
      }
    } catch (e) {
      // print("Error reading data: $e");
    } finally {
      client.close();
    }
  }

  static Future<void> fetchDataFromSpreadsheet1() async {
    videoSourcesData.clear();
    // Load and authenticate using the credentials JSON file
    final credentials = auth.ServiceAccountCredentials.fromJson(
        await loadServiceAccountCredentials());
    final client = await auth.clientViaServiceAccount(
        credentials, [sheets.SheetsApi.spreadsheetsReadonlyScope]);

    // Spreadsheet ID can be found in the URL of the spreadsheet
    const spreadsheetId = "1I4nxbkwuZ-yyE-VSQNMXNDJs5aATlCV2f__N7jHnQ5M";

    // The range of cells you want to read from (e.g., "Sheet1!A2:C")
    const range = "1-4!A2:C"; // Adjust the sheet name and range accordingly

    try {
      var response = await sheets.SheetsApi(client)
          .spreadsheets
          .values
          .get(spreadsheetId, range);

      // Parse and store the data in audioSourcesData
      if (response.values != null && response.values!.isNotEmpty) {
        for (var row in response.values!) {
          // Ensure the row has three columns (URI, ID, Title)
          if (row.length >= 3) {
            final String uri = row[2] as String;
            final String id = row[0] as String;
            final String title = row[1] as String;
            videoSourcesData.add({
              'uri': uri,
              'id': id,
              'title': title,
            });
          }
        }
      }
    } catch (e) {
      // print("Error reading data: $e");
    } finally {
      client.close();
    }
  }

  static Future<void> fetchDataFromSpreadsheet2() async {
    videoSourcesData.clear();
    // Load and authenticate using the credentials JSON file
    final credentials = auth.ServiceAccountCredentials.fromJson(
        await loadServiceAccountCredentials());
    final client = await auth.clientViaServiceAccount(
        credentials, [sheets.SheetsApi.spreadsheetsReadonlyScope]);

    // Spreadsheet ID can be found in the URL of the spreadsheet
    const spreadsheetId = "1I4nxbkwuZ-yyE-VSQNMXNDJs5aATlCV2f__N7jHnQ5M";

    // The range of cells you want to read from (e.g., "Sheet1!A2:C")
    const range = "5-8!A2:C"; // Adjust the sheet name and range accordingly

    try {
      var response = await sheets.SheetsApi(client)
          .spreadsheets
          .values
          .get(spreadsheetId, range);

      // Parse and store the data in audioSourcesData
      if (response.values != null && response.values!.isNotEmpty) {
        for (var row in response.values!) {
          // Ensure the row has three columns (URI, ID, Title)
          if (row.length >= 3) {
            final String uri = row[2] as String;
            final String id = row[0] as String;
            final String title = row[1] as String;
            videoSourcesData.add({
              'uri': uri,
              'id': id,
              'title': title,
            });
          }
        }
      }
    } catch (e) {
      // print("Error reading data: $e");
    } finally {
      client.close();
    }
  }

  static Future<void> fetchDataFromSpreadsheet3() async {
    videoSourcesData.clear();
    // Load and authenticate using the credentials JSON file
    final credentials = auth.ServiceAccountCredentials.fromJson(
        await loadServiceAccountCredentials());
    final client = await auth.clientViaServiceAccount(
        credentials, [sheets.SheetsApi.spreadsheetsReadonlyScope]);

    // Spreadsheet ID can be found in the URL of the spreadsheet
    const spreadsheetId = "1I4nxbkwuZ-yyE-VSQNMXNDJs5aATlCV2f__N7jHnQ5M";

    // The range of cells you want to read from (e.g., "Sheet1!A2:C")
    const range = "9-12!A2:C"; // Adjust the sheet name and range accordingly

    try {
      var response = await sheets.SheetsApi(client)
          .spreadsheets
          .values
          .get(spreadsheetId, range);

      // Parse and store the data in audioSourcesData
      if (response.values != null && response.values!.isNotEmpty) {
        for (var row in response.values!) {
          // Ensure the row has three columns (URI, ID, Title)
          if (row.length >= 3) {
            final String uri = row[2] as String;
            final String id = row[0] as String;
            final String title = row[1] as String;
            videoSourcesData.add({
              'uri': uri,
              'id': id,
              'title': title,
            });
          }
        }
      }
    } catch (e) {
      // print("Error reading data: $e");
    } finally {
      client.close();
    }
  }

  static Future<Map<String, dynamic>> loadServiceAccountCredentials() async {
    final String jsonString = await rootBundle
        .loadString('assets/edu-connect-415517-137bc8922316.json');
    return json.decode(utf8.decode(jsonString.codeUnits))
        as Map<String, dynamic>;
  }

  static List<Map<String, dynamic>> getData() {
    return videoSourcesData;
  }
  // Other methods for managing video sources go here...
}
