ini dokumentasi func" bekend

## 📖 Dokumentasi API

Silakan pilih modul yang ingin dilihat:

- [🔐 Autentikasi](docs/auth.md)
- [👥 Manajemen User](docs/users.md)
- [💸 Transaksi](#bagian-transaksi)

### Login Func

Untuk Login

<a name="bagian-transaksi"></a>
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
      'success': true,
      'name': kevin apta,
      'role': user,
      'uid': XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX,
}
```
- **Error**
```json
{
    'success': false,
    'error': "Invalid Login Credientals"
}
```