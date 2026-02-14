ini dokumentasi func" bekend

## 📖 Dokumentasi API

Silakan pilih modul yang ingin dilihat:

- [🔐 Autentikasi](#bagian-login)
- [🔐 Login OAuth](#bagian-login-oauth)
- [📝 Registrasi User](#bagian-register)
- [📍 Listener Lokasi](#bagian-location-listener)
- [🗺️ Tulis Lokasi](#bagian-write-location)



<a name="bagian-login">
    ### Login Func

Untuk Login

**Endpoint:**

```
import 'package:ajimashudi/providers/auth_provider.dart';

loginUser(email, password);
```

**Auth:** Required (Bearer Token)

#### Parameters

| Name       | Type               | In    | Required | Description   |
| :--------- | :----------------- | :---- | :------- | :------------ |
| `email`    | string             | query | No       | email User    |
| `password` | string(min 6 char) | query | No       | password User |

#### Response

- **Success**

```json
{
      "success": true,
      "name": "kevin apta",
      "role": "user",
      "uid": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
}
```
- **Error**
```json
{
    "success": false,
    "error": "Invalid Login Credientals"
}
```
</a>

<a name="bagian-login-oauth">
        ### Login OAuth Func

Login menggunakan akun Google dan membuat data user di tabel `users` jika belum ada.

**Endpoint:**

```
import 'package:ajimashudi/providers/auth_provider.dart';

LoginOauthUser();
```

**Auth:** Required (Google OAuth)

#### Parameters

Tidak ada parameter.

#### Response

- **Success**

```json
{
    "success": true,
    "name": "nama pengguna",
    "role": "user",
    "uid": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
}
```

- **Error**

```json
{
    "success": false,
    "error": "Exception message"
}
```
</a>

<a name="bagian-register">
        ### Register Func

Registrasi user baru melalui Supabase, lalu menyimpan data dasar ke tabel `users`.

**Endpoint:**

```
import 'package:ajimashudi/providers/auth_provider.dart';

signInUser(username: username, email: email, password: password);
```

**Auth:** Not Required

#### Parameters

| Name       | Type               | In    | Required | Description        |
| :--------- | :----------------- | :---- | :------- | :----------------- |
| `username` | string             | query | No       | nama user          |
| `email`    | string             | query | No       | email user         |
| `password` | string(min 6 char) | query | No       | password user      |

#### Response

- **Success**

```json
{
    "success": true
}
```

- **Error**

```json
{
    "success": false,
    "error": "Exception message"
}
```
</a>

<a name="bagian-location-listener">
        ### Location Listener Func

Membuka stream lokasi real-time dari device. Hasilnya dapat dipakai untuk update UI atau menyimpan lokasi secara berkala.

**Endpoint:**

```
import 'package:ajimashudi/providers/location_listener.dart';

final stream = await getLocationStream();
```

**Auth:** Not Required

#### Parameters

Tidak ada parameter.

#### Response

Mengembalikan `Stream<LocationData>` dari plugin location.
</a>

<a name="bagian-write-location">
        ### Write Location Func

Menyimpan koordinat lokasi ke Firebase Realtime Database pada path user tertentu.

**Endpoint:**

```
import 'package:ajimashudi/providers/write_location.dart';

writeLocation(userId, latitude: lat, longitude: lng);
```

**Auth:** Not Required

#### Parameters

| Name        | Type    | In    | Required | Description       |
| :---------- | :------ | :---- | :------- | :---------------- |
| `user`      | string  | query | No       | id/path user      |
| `latitude`  | double  | query | No       | latitude user     |
| `longitude` | double  | query | No       | longitude user    |

#### Response

- **Success**

```json
{
    "success": true
}
```

- **Error**

```json
{
    "success": false,
    "error": "Exception message"
}
```
</a>