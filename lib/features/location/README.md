# 📖 Provider Documentation

Dokumentasi ini mencakup fungsi-fungsi utama pada aplikasi **Ajimashudi** untuk autentikasi dan manajemen lokasi.

### 🗂️ Daftar Isi

* [🔐 Autentikasi (Email & Password)](https://www.google.com/search?q=%23-autentikasi-email--password)
* [🌐 Login OAuth (Google)](https://www.google.com/search?q=%23-login-oauth-google)
* [📝 Registrasi Pengguna](https://www.google.com/search?q=%23-registrasi-pengguna)
* [🛰️ Listener Lokasi (Real-time)](https://www.google.com/search?q=%23-listener-lokasi-real-time)
* [📍 Write Location (Firebase)](https://www.google.com/search?q=%23-write-location-firebase)

---

### 🔐 Autentikasi (Email & Password)

Digunakan untuk masuk ke aplikasi menggunakan kredensial terdaftar.

**Provider Path:**
`import 'package:ajimashudi/providers/auth_provider.dart';`

**Fungsi:**

```dart
loginUser(String email, String password);

```

**Parameters:**
| Name | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `email` | `String` | ✅ Yes | Email pengguna |
| `password` | `String` | ✅ Yes | Minimal 6 karakter |

**Response:**

* **Success**
```json
{ "success": true, "name": "Kevin Apta", "role": "user", "uid": "UID-123" }

```


* **Error**
```json
{ "success": false, "error": "Invalid Login Credentials" }

```



---

### 🌐 Login OAuth (Google)

Login instan menggunakan akun Google. Jika user belum ada di tabel `users`, data akan otomatis dibuat.

**Provider Path:**
`import 'package:ajimashudi/providers/auth_provider.dart';`

**Fungsi:**

```dart
loginOauthUser();

```

**Response Success:**

```json
{
  "success": true,
  "name": "Nama Pengguna",
  "role": "user",
  "uid": "UID-123"
}

```

---

### 📝 Registrasi Pengguna

Mendaftarkan user baru ke Supabase Auth dan menyimpan data profil ke tabel `users`.

**Provider Path:**
`import 'package:ajimashudi/providers/auth_provider.dart';`

**Fungsi:**

```dart
signInUser({required String username, required String email, required String password});

```

**Parameters:**
| Name | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `username` | `String` | ✅ Yes | Nama tampilan user |
| `email` | `String` | ✅ Yes | Email aktif |
| `password` | `String` | ✅ Yes | Minimal 6 karakter |

---

### 🛰️ Listener Lokasi (Real-time)

Membuka aliran data (*stream*) koordinat perangkat secara real-time.

**Provider Path:**
`import 'package:ajimashudi/providers/location_listener.dart';`

**Fungsi:**

```dart
final stream = await getLocationStream();

```

**Return Type:**
`Stream<LocationData>` (dari package `location`)

---

### 📍 Write Location (Firebase)

Mengirimkan data koordinat ke **Firebase Realtime Database** untuk pelacakan.

**Provider Path:**
`import 'package:ajimashudi/providers/write_location.dart';`

**Fungsi:**

```dart
writeLocation(String userId, {double latitude, double longitude});

```

**Parameters:**
| Name | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `userId` | `String` | ✅ Yes | UID user sebagai path database |
| `latitude` | `double` | ✅ Yes | Titik koordinat Lintang |
| `longitude` | `double` | ✅ Yes | Titik koordinat Bujur |

---
