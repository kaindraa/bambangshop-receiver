# BambangShop Receiver App
Tutorial and Example for Advanced Programming 2024 - Faculty of Computer Science, Universitas Indonesia

---

## About this Project
In this repository, we have provided you a REST (REpresentational State Transfer) API project using Rocket web framework.

This project consists of four modules:
1.  `controller`: this module contains handler functions used to receive request and send responses.
    In Model-View-Controller (MVC) pattern, this is the Controller part.
2.  `model`: this module contains structs that serve as data containers.
    In MVC pattern, this is the Model part.
3.  `service`: this module contains structs with business logic methods.
    In MVC pattern, this is also the Model part.
4.  `repository`: this module contains structs that serve as databases.
    You can use methods of the struct to get list of objects, or operating an object (create, read, update, delete).

This repository provides a Rocket web framework skeleton that you can work with.

As this is an Observer Design Pattern tutorial repository, you need to implement a feature: `Notification`.
This feature will receive notifications of creation, promotion, and deletion of a product, when this receiver instance is subscribed to a certain product type.
The notification will be sent using HTTP POST request, so you need to make the receiver endpoint in this project.

## API Documentations

You can download the Postman Collection JSON here: https://ristek.link/AdvProgWeek7Postman

After you download the Postman Collection, you can try the endpoints inside "BambangShop Receiver" folder.

Postman is an installable client that you can use to test web endpoints using HTTP request.
You can also make automated functional testing scripts for REST API projects using this client.
You can install Postman via this website: https://www.postman.com/downloads/

## How to Run in Development Environment
1.  Set up environment variables first by creating `.env` file.
    Here is the example of `.env` file:
    ```bash
    ROCKET_PORT=8001
    APP_INSTANCE_ROOT_URL=http://localhost:${ROCKET_PORT}
    APP_PUBLISHER_ROOT_URL=http://localhost:8000
    APP_INSTANCE_NAME=Safira Sudrajat
    ```
    Here are the details of each environment variable:
    | variable                | type   | description                                                     |
    |-------------------------|--------|-----------------------------------------------------------------|
    | ROCKET_PORT             | string | Port number that will be listened by this receiver instance.    |
    | APP_INSTANCE_ROOT_URL   | string | URL address where this receiver instance can be accessed.       |
    | APP_PUUBLISHER_ROOT_URL | string | URL address where the publisher instance can be accessed.       |
    | APP_INSTANCE_NAME       | string | Name of this receiver instance, will be shown on notifications. |
2.  Use `cargo run` to run this app.
    (You might want to use `cargo check` if you only need to verify your work without running the app.)
3.  To simulate multiple instances of BambangShop Receiver (as the tutorial mandates you to do so),
    you can open new terminal, then edit `ROCKET_PORT` in `.env` file, then execute another `cargo run`.

    For example, if you want to run 3 (three) instances of BambangShop Receiver at port `8001`, `8002`, and `8003`, you can do these steps:
    -   Edit `ROCKET_PORT` in `.env` to `8001`, then execute `cargo run`.
    -   Open new terminal, edit `ROCKET_PORT` in `.env` to `8002`, then execute `cargo run`.
    -   Open another new terminal, edit `ROCKET_PORT` in `.env` to `8003`, then execute `cargo run`.

## Mandatory Checklists (Subscriber)
-   [ ] Clone https://gitlab.com/ichlaffterlalu/bambangshop-receiver to a new repository.
-   **STAGE 1: Implement models and repositories**
    -   [ ] Commit: `Create Notification model struct.`
    -   [ ] Commit: `Create SubscriberRequest model struct.`
    -   [ ] Commit: `Create Notification database and Notification repository struct skeleton.`
    -   [ ] Commit: `Implement add function in Notification repository.`
    -   [ ] Commit: `Implement list_all_as_string function in Notification repository.`
    -   [ ] Write answers of your learning module's "Reflection Subscriber-1" questions in this README.
-   **STAGE 3: Implement services and controllers**
    -   [ ] Commit: `Create Notification service struct skeleton.`
    -   [ ] Commit: `Implement subscribe function in Notification service.`
    -   [ ] Commit: `Implement subscribe function in Notification controller.`
    -   [ ] Commit: `Implement unsubscribe function in Notification service.`
    -   [ ] Commit: `Implement unsubscribe function in Notification controller.`
    -   [ ] Commit: `Implement receive_notification function in Notification service.`
    -   [ ] Commit: `Implement receive function in Notification controller.`
    -   [ ] Commit: `Implement list_messages function in Notification service.`
    -   [ ] Commit: `Implement list function in Notification controller.`
    -   [ ] Write answers of your learning module's "Reflection Subscriber-2" questions in this README.

## Your Reflections
This is the place for you to write reflections:

### Mandatory (Subscriber) Reflections

#### Reflection Subscriber-1

> In this tutorial, we used RwLock<> to synchronise the use of Vec of Notifications. Explain why it is necessary for this case, and explain why we do not use Mutex<> instead?

Penggunaan RwLock dalam tutorial ini penting karena struktur data Vec<Notification> diakses oleh banyak thread secara bersamaan, baik untuk membaca maupun menulis. Dengan RwLock, beberapa thread dapat membaca data secara paralel tanpa saling mengganggu, selama tidak ada thread yang sedang menulis. Hal ini sangat efisien dalam kasus ini karena sebagian besar operasi (misalnya menampilkan daftar notifikasi) hanya membutuhkan akses baca.

Sementara itu, Mutex hanya mengizinkan satu thread untuk mengakses data pada satu waktu, baik untuk membaca maupun menulis. Jika menggunakan Mutex, operasi membaca sederhana pun akan saling menunggu giliran yang menyebabkan operasi menjadi sangat lambat, terutama saat banyak pembacaan terjadi bersamaan.

> In this tutorial, we used lazy_static external library to define Vec and DashMap as a “static” variable. Compared to Java where we can mutate the content of a static variable via a static function, why did not Rust allow us to do so?

Rust tidak mengizinkan mutasi langsung terhadap variabel `static` seperti di Java untuk mencegah race condition dan akses data yang tidak aman secara bawaan. Untuk menjaga keamanan dan konsistensi data dalam lingkungan multithreaded, Rust mewajibkan penggunaan mekanisme sinkronisasi seperti RwLock atau Mutex. Selain itu, variabel global yang dapat diubah harus didefinisikan menggunakan bantuan crate seperti lazy_static, sehingga akses terhadap data tetap terkontrol dan aman.

#### Reflection Subscriber-2

> Have you explored things outside of the steps in the tutorial, for example: src/lib.rs? If not, explain why you did not do so. If yes, explain things that you have learned from those other parts of code.

Ya, saya sudah explore src/main.rs. File ini bertanggung jawab untuk menjalankan aplikasi dengan framework Rocket. Di dalamnya, environment variable dimuat menggunakan `dotenv()` dan aplikasi dibangun menggunakan `rocket::build()` dengan konfigurasi tambahan seperti HTTP client dan route handler. Fungsi `route_stage()` dari modul `controller` digunakan untuk mendaftarkan semua endpoint yang akan dilayani. Selain itu, file ini juga mendeklarasikan modul-modul penting seperti `controller`, `service`, `repository`, dan `model` yang merepresentasikan struktur arsitektur aplikasi.

> Since you have completed the tutorial by now and have tried to test your notification system by spawning multiple instances of Receiver, explain how Observer pattern eases you to plug in more subscribers. How about spawning more than one instance of Main app, will it still be easy enough to add to the system?

Observer pattern sangat membantu dalam menambahkan lebih banyak subscriber karena setiap subscriber hanya perlu melakukan proses subscribe ke Main app tanpa perlu mengubah kode di sisi publisher. Notifikasi akan secara otomatis dikirim ke semua subscriber yang sudah terdaftar. Ini membuat sistem menjadi fleksibel dan scalable karena subscriber baru bisa ditambahkan kapan saja tanpa memengaruhi komponen lain dalam sistem.

Jika ingin menambahkan lebih dari satu instance Main app (publisher), kompleksitas akan meningkat. Hal ini karena pada sistem dengan banyak publisher, tidak ada jaminan bahwa semua subscriber terhubung ke publisher yang sesuai. Setiap publisher hanya mengetahui subscriber yang mendaftar langsung kepadanya.  Oleh karena itu, sistem dengan banyak publisher memerlukan pendekatan tambahan untuk memastikan semua notifikasi tersampaikan dengan benar ke subscriber yang sesuai.

> Have you tried to make your own Tests, or enhance documentation on your Postman collection? If you have tried those features, tell us whether it is useful for your work (it can be your tutorial work or your Group Project).

Saya telah mencoba menambahkan dokumentasi pada koleksi Postman, terutama di bagian deskripsi setiap request. Fitur ini sangat membantu jika digunakan bersama tim dalam proyek kelompok, agar semua anggota kelompok dapat memahami API lebih mudah.