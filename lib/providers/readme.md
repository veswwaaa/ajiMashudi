ini dokumentasi func" bekend

## 📖 Dokumentasi API
Silakan pilih modul yang ingin dilihat:
- [🔐 Autentikasi](docs/auth.md)
- [👥 Manajemen User](docs/users.md)
- [💸 Transaksi](#bagian-transaksi)

### 👤 User Profile
Mengambil data detail profil pengguna yang sedang login.

<a name="bagian-transaksi"></a>
**Endpoint:** `GET /api/v1/users/profile`  
**Auth:** Required (Bearer Token)

#### Parameters
| Name | Type | In | Required | Description |
| :--- | :--- | :--- | :--- | :--- |
| `fields` | string | query | No | Field yang ingin ditampilkan (comma separated) |

#### Response
- **200 OK**
```json
{
  "status": "success",
  "data": {
    "id": "USR-99",
    "username": "daffaganteng",
    "email": "daffa@perusahaan.com"
  }
}