// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:js_util' as js_util;

const String _scriptId = 'google-identity-services-sdk';
bool _gsiInitialized = false;

Future<String?> fetchGoogleUserName({required String clientId}) async {
  if (clientId.isEmpty) {
    return null;
  }

  final completer = Completer<String?>();
  bool completed = false;

  void resolve(String? value) {
    if (!completed) {
      completed = true;
      if (!completer.isCompleted) {
        completer.complete(value);
      }
    }
  }

  Future<void> initialize() async {
    try {
      final google = js_util.getProperty(html.window, 'google');
      if (google == null) {
        resolve(null);
        return;
      }
      final accounts = js_util.getProperty(google, 'accounts');
      final id = js_util.getProperty(accounts, 'id');

      if (!_gsiInitialized) {
        js_util.callMethod(id, 'initialize', [
          js_util.jsify({
            'client_id': clientId,
            'auto_select': true,
            'callback': js_util.allowInterop((dynamic response) {
              final credential =
                  js_util.getProperty(response, 'credential') as String?;
              if (credential == null) {
                resolve(null);
                return;
              }
              resolve(_nameFromCredential(credential));
            }),
          }),
        ]);
        _gsiInitialized = true;
      }

      js_util.callMethod(id, 'prompt', [
        js_util.allowInterop((dynamic _) {
          // Prompt finished without credentials.
          resolve(null);
        }),
      ]);

      Future<void>.delayed(const Duration(seconds: 3)).then((_) {
        resolve(null);
      });
    } catch (_) {
      resolve(null);
    }
  }

  if (html.document.getElementById(_scriptId) != null) {
    unawaited(initialize());
  } else {
    final script = html.ScriptElement()
      ..id = _scriptId
      ..src = 'https://accounts.google.com/gsi/client'
      ..async = true
      ..defer = true;
    script.onError.listen((_) => resolve(null));
    script.onLoad.listen((_) {
      unawaited(initialize());
    });
    html.document.head?.append(script);
  }

  return completer.future.timeout(
    const Duration(seconds: 6),
    onTimeout: () => null,
  );
}

String? _nameFromCredential(String credential) {
  try {
    final parts = credential.split('.');
    if (parts.length < 2) {
      return null;
    }
    final normalized = base64Url.normalize(parts[1]);
    final decoded = utf8.decode(base64Url.decode(normalized));
    final payload = json.decode(decoded);
    if (payload is Map && payload['name'] is String) {
      return payload['name'] as String;
    }
  } catch (_) {
    return null;
  }
  return null;
}
