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
// Code goes here
function example() {
  console.log("Hello, world!");
}
```
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