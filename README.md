# Flutter Expense

Ứng dụng quản lý chi tiêu cá nhân, xây dựng bằng Flutter với framework Nylo.

## 📋 Tính năng

- Theo dõi thu chi hàng ngày
- Phân loại chi tiêu theo danh mục
- Giao diện Material Design (Light/Dark theme)
- Đa ngôn ngữ (i18n)
- Kiến trúc MVC với Nylo framework

## 🛠️ Công nghệ

- **Framework:** Flutter + [Nylo](https://nylo.dev)
- **Language:** Dart
- **Architecture:** MVC (Nylo pattern)

## ⚙️ Cài đặt

### 1. Clone repository

```bash
git clone https://github.com/trucuit/flutter-expense.git
cd flutter-expense
```

### 2. Cấu hình Environment

Copy file `.env-example` thành `.env` và cập nhật giá trị:

```bash
cp .env-example .env
```

| Biến | Mô tả | Mặc định |
|------|--------|----------|
| `APP_NAME` | Tên ứng dụng | `Nylo` |
| `APP_ENV` | Môi trường (`developing` / `production`) | `developing` |
| `APP_DEBUG` | Bật/tắt debug | `true` |
| `APP_URL` | URL ứng dụng | `https://nylo.dev` |
| `API_BASE_URL` | Base URL của API backend | _(required)_ |
| `TIMEZONE` | Múi giờ | `UTC` |
| `DEFAULT_LOCALE` | Ngôn ngữ mặc định | `en` |

### 3. Cài đặt dependencies

```bash
flutter pub get
```

### 4. Chạy ứng dụng

```bash
flutter run
```

## 🔒 Bảo mật

> **⚠️ QUAN TRỌNG:** File `.env` chứa cấu hình nhạy cảm, không commit lên Git. Chỉ commit `.env-example` làm template.

## 📄 License

MIT License — xem file [LICENSE](LICENSE).
