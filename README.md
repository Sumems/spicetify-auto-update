# Spicetify Auto-Update Shortcut Manager

[English](#english) | [Bahasa Indonesia](#bahasa-indonesia)

---

<a name="english"></a>

## EN | English

This utility (`Manage-SpicetifyAutoUpdate`) helps you manage a special "Standalone Shortcut" that automatically updates Spicetify every time you launch Spotify.

### Why use this?

By default, Spicetify might not update automatically, causing themes or extensions to break when Spotify updates. This script creates a shortcut that does two things sequentially:

1.  Runs `spicetify update` to ensure everything is patched.
2.  Launches Spotify.

### Features

- **Install Shortcut**: Creates a "Spotify (Spicetify)" shortcut in your Application Menu / Desktop.
- **Auto-Update**: Always checks for Spicetify updates before launching Spotify.
- **Uninstall & Cleanup**: Removes the shortcut and cleans up old scheduled tasks (Windows).

### Prerequisites

- [Spicetify](https://spicetify.app/) installed.
- Spotify installed.

### How to Use

#### Windows (PowerShell)

1.  Open powershell as administrator and run "Set-ExecutionPolicy -Scope CurrentUser Unrestricted"
2.  Right-click `Manage-SpicetifyAutoUpdate.ps1`.
3.  Select **Run with PowerShell**.
4.  Follow the interactive menu (Press `1` to Install, `2` to Uninstall).

#### Linux (Bash)

1.  Open your terminal in this folder.
2.  Make the script executable:
    ```bash
    chmod +x Manage-SpicetifyAutoUpdate.sh
    ```
3.  Run the script:
    ```bash
    ./Manage-SpicetifyAutoUpdate.sh
    ```
4.  Follow the interactive menu.

---

<a name="bahasa-indonesia"></a>

## ID | Bahasa Indonesia

Script ini (`Manage-SpicetifyAutoUpdate`) dibuat untuk memudahkan pengelolaan _shortcut_ khusus yang secara otomatis melakukan pembaruan (update) pada Spicetify setiap kali Anda membuka Spotify.

### Mengapa Script Ini Dibuat?

Secara default, Spicetify mungkin tidak selalu terupdate otomatis atau terkadang tertimpa oleh update Spotify biasa. Script ini memberikan solusi sederhana dengan membuat "Standalone Shortcut" yang melakukan dua hal secara berurutan:

1.  Menjalankan perintah `spicetify update` untuk memastikan tema dan ekstensi tetap berjalan lancar.
2.  Membuka aplikasi Spotify.

### Fitur

- **Install Shortcut**: Membuat shortcut "Spotify (Spicetify)" di Desktop dan Start Menu (Windows) atau Application Launcher (Linux).
- **Auto-Update**: Shortcut yang dibuat akan selalu mengecek update Spicetify sebelum membuka Spotify.
- **Uninstall & Cleanup**: Menghapus shortcut yang dibuat dan membersihkan konfigurasi lama.

### Prasyarat

- [Spicetify](https://spicetify.app/) sudah terinstall.
- Spotify sudah terinstall.

### Cara Menggunakan

#### Windows (PowerShell)

1.  Klik kanan pada file `Manage-SpicetifyAutoUpdate.ps1`.
2.  Pilih **Run with PowerShell**.
3.  Ikuti menu interaktif yang tersedia (Tekan `1` untuk Install, `2` untuk Uninstall).

#### Linux (Bash)

1.  Buka terminal di dalam folder ini.
2.  Berikan izin eksekusi pada script:
    ```bash
    chmod +x Manage-SpicetifyAutoUpdate.sh
    ```
3.  Jalankan script:
    ```bash
    ./Manage-SpicetifyAutoUpdate.sh
    ```
4.  Ikuti menu interaktif yang tersedia.

---

### Notes / Catatan

- **Windows**: The script creates a `.lnk` shortcut that runs PowerShell commands hiddenly. / Script membuat shortcut `.lnk` yang menjalankan perintah PowerShell secara tersembunyi.
- **Linux**: The script creates a `.desktop` file in `~/.local/share/applications/`. / Script membuat file `.desktop` di `~/.local/share/applications/`.
