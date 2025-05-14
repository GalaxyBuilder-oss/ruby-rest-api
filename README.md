Untuk mengembangkan aplikasi Ruby di Windows, Anda perlu mempersiapkan beberapa alat dan lingkungan. Berikut adalah langkah-langkah yang perlu Anda ikuti:

### 1. Instal Ruby
Instalasi Ruby di Windows bisa dilakukan dengan menggunakan RubyInstaller, yang menyediakan instalasi Ruby yang mudah untuk pengguna Windows.

- **Unduh RubyInstaller**:
  Kunjungi [rubyinstaller.org](https://rubyinstaller.org/) dan unduh versi Ruby yang Anda inginkan (disarankan untuk memilih versi yang stabil).

- **Instal Ruby**:
  Jalankan installer dan ikuti instruksinya. Pastikan untuk memilih opsi untuk menambahkan Ruby ke PATH selama instalasi. Ini akan memudahkan Anda dalam menjalankan perintah Ruby dari command prompt.

### 2. Instal Bundler
Bundler adalah alat untuk mengelola gem (library) dependencies dalam proyek Ruby.

- **Instal Bundler**:
  Buka Command Prompt atau PowerShell dan jalankan perintah berikut:
  ```sh
  gem install bundler
  ```

### 3. Setup Editor/IDE
Pilih editor atau IDE yang mendukung pengembangan Ruby. Berikut beberapa rekomendasi:

- **VS Code**:
  Unduh Visual Studio Code dari [code.visualstudio.com](https://code.visualstudio.com/) dan instal extension Ruby untuk mendukung sintaks dan debugging.

- **RubyMine**:
  RubyMine adalah IDE berbayar yang khusus untuk pengembangan Ruby dan Rails. Anda bisa mengunduhnya dari [jetbrains.com/ruby](https://www.jetbrains.com/ruby/).

### 4. Setup Git
Git adalah sistem kontrol versi yang sangat penting untuk pengembangan perangkat lunak modern.

- **Instal Git**:
  Unduh dan instal Git dari [git-scm.com](https://git-scm.com/). Pastikan untuk memilih opsi untuk menambahkan Git ke PATH.

### 5. Instal SQLite (Opsional)
Jika Anda menggunakan Rails dan SQLite sebagai database, Anda perlu menginstal SQLite.

- **Unduh SQLite**:
  Unduh file ZIP yang berisi `sqlite3.exe` dari [sqlite.org/download.html](https://www.sqlite.org/download.html).

- **Tambahkan ke PATH**:
  Ekstrak file ZIP dan tambahkan direktori yang berisi `sqlite3.exe` ke PATH sistem.

### 6. Setup Rails (Opsional)
Jika Anda berencana untuk mengembangkan aplikasi web menggunakan Rails, Anda perlu menginstal Rails.

- **Instal Rails**:
  Jalankan perintah berikut di Command Prompt atau PowerShell:
  ```sh
  gem install rails
  ```

### 7. Instalasi Dependencies
Beberapa gem mungkin memerlukan alat tambahan seperti DevKit untuk kompilasi.

- **Unduh dan Instal DevKit**:
  Jika Anda menggunakan RubyInstaller2, DevKit sudah termasuk. Jika tidak, unduh DevKit dari [rubyinstaller.org](https://rubyinstaller.org/) dan ikuti petunjuk instalasi.

### 8. Verifikasi Instalasi
Setelah semua alat diinstal, verifikasi instalasi dengan menjalankan perintah berikut di Command Prompt atau PowerShell:

```sh
ruby -v
gem -v
bundler -v
rails -v
git --version
```

### 9. Membuat Proyek Ruby
Anda sekarang siap untuk mulai mengembangkan proyek Ruby atau Rails. Untuk membuat proyek Rails baru, gunakan perintah:

```sh
rails new my_project
cd my_project
rails server
```

Ini akan membuat proyek Rails baru dan menjalankan server di `http://localhost:3000`.

Dengan langkah-langkah ini, Anda akan siap mengembangkan aplikasi Ruby di Windows.

Untuk membuat REST API menggunakan Ruby, kita bisa menggunakan framework seperti Sinatra atau Rails. Rails sangat populer dan menyediakan banyak fitur out-of-the-box, sementara Sinatra lebih ringan dan mudah digunakan untuk aplikasi yang lebih sederhana.

Berikut adalah contoh membuat REST API menggunakan Sinatra:

1. **Instal Sinatra**:
   ```sh
   gem install sinatra
   ```

2. **Buat file `app.rb`**:
   ```ruby
   require 'sinatra'
   require 'json'

   users = [
     { id: 1, name: 'John Doe', email: 'john@example.com' },
     { id: 2, name: 'Jane Doe', email: 'jane@example.com' }
   ]

   get '/users' do
     content_type :json
     users.to_json
   end

   get '/users/:id' do
     content_type :json
     user = users.find { |u| u[:id] == params[:id].to_i }
     if user
       user.to_json
     else
       halt 404, { message: 'User not found' }.to_json
     end
   end

   post '/users' do
     content_type :json
     new_user = JSON.parse(request.body.read)
     new_user['id'] = users.size + 1
     users << new_user
     new_user.to_json
   end

   put '/users/:id' do
     content_type :json
     user = users.find { |u| u[:id] == params[:id].to_i }
     if user
       updated_user = JSON.parse(request.body.read)
       user.merge!(updated_user)
       user.to_json
     else
       halt 404, { message: 'User not found' }.to_json
     end
   end

   delete '/users/:id' do
     content_type :json
     user = users.find { |u| u[:id] == params[:id].to_i }
     if user
       users.delete(user)
       { message: 'User deleted' }.to_json
     else
       halt 404, { message: 'User not found' }.to_json
     end
   end
   ```

3. **Jalankan Aplikasi**:
   ```sh
   ruby app.rb -o 0.0.0.0 -p 4567
   ```

API ini akan berjalan di `http://127.0.0.1:4567`. Anda bisa mengakses berbagai endpoint seperti:
- `GET /users` untuk mendapatkan semua pengguna
- `GET /users/:id` untuk mendapatkan pengguna berdasarkan ID
- `POST /users` untuk menambahkan pengguna baru
- `PUT /users/:id` untuk memperbarui pengguna berdasarkan ID
- `DELETE /users/:id` untuk menghapus pengguna berdasarkan ID

Jika Anda ingin menggunakan Rails untuk membuat REST API, berikut adalah langkah-langkahnya:

1. **Instal Rails**:
   ```sh
   gem install rails
   ```

2. **Buat aplikasi Rails baru**:
   ```sh
   rails new my_api --api
   cd my_api
   ```

3. **Buat scaffold untuk model User**:
   ```sh
   rails generate scaffold User name:string email:string
   rails db:migrate
   ```

4. **Tambahkan route untuk API di `config/routes.rb`**:
   ```ruby
   Rails.application.routes.draw do
     resources :users
   end
   ```

5. **Jalankan server Rails**:
   ```sh
   rails server
   ```

API ini akan berjalan di `http://127.0.0.1:3000`. Anda bisa mengakses berbagai endpoint seperti:
- `GET /users` untuk mendapatkan semua pengguna
- `GET /users/:id` untuk mendapatkan pengguna berdasarkan ID
- `POST /users` untuk menambahkan pengguna baru
- `PUT /users/:id` untuk memperbarui pengguna berdasarkan ID
- `DELETE /users/:id` untuk menghapus pengguna berdasarkan ID

Pilih framework yang paling sesuai dengan kebutuhan dan preferensi Anda.