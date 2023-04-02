//* Synchronous
//? merupakan proses yang dikerjakan secara berurutan.

//* Asynchronous
//? merupakan proses yang dilewatkan sementara waktu untuk diproses, dan akan dijalan setelah menjalankan proses yang sifatnya synchronous

//* 3 Status Asynchronous
//? 1. Uncompleted (belum dijalankan alias menunggu proses lain)
//? 2. Completed (sudah dijalankan dan berhasil) -> data (sukses)
//? 3. Completed (sudah dijalankan, tapi error) -> data (error)

//! membuat asynchronous menjadi synchronous menggunakan kata kunci menambahkan 'async' pada void main () aysnc {} serta menambahkan kata kunci 'await' pada 'await namaMethod()'
void main() async {
  //* Synchronous ->> dia akan menjalankan proses sesuai urutan
  print('Synchronous');
  print('--------------------');
  pertama();
  kedua();

  //* Asynchronous
  print('--------------------');
  print('Asynchronous');
  print('--------------------');
  //dataDelay()  ->  termasuk asynchronous sehingga, data tersebut di skip dahulu dan dijalankan setelah proses synchronous atau proses lain nya selesai
  //! asynchronous tipe 1
  dataDelay(); // terakhir

  //! asynchronous tipe 2 (asynchronous murni dibawah ini)
  // then((String status) adalah response callback saat telah selesai memanggil Future (completed)
  /* getOrder(10).then((String status) {
    print('Completed');
    print(status);
    // catchError((onError) {} merupakan menangkap error. sama halnya kayak konsep try-catch
  }).catchError((onError) {
    print('Error');
    print(onError);
  }); */
  //!

  //* cara 2.1 dalam menerapkan asynchronous
  //* ini lebih cocok ketika murni sifanya yaitu asynchronous
  await getOrder(10).then((String status) {
    print('Completed');
    print(status);
    // catchError((onError) {} merupakan menangkap error
  }).catchError((onError) {
    print('Error');
    print(onError);
  });

  //* cara 2.2 dalam menerakan asynchronous dengan try catch (lebih rapi)
  //* ini lebih cocok ketika mengubah asynchronous menjadi synchronous (menggunakan await)
  try {
    String status = await getOrder(1);
    print('Completed');
    print(status);
  } catch (error) {
    print('Error');
    print(error);
  }

  pertama();
  kedua();
}

void pertama() {
  print('data1');
}

void kedua() {
  print('data2');
}

//! Penerapan asynchronous (completed dan sukses)
void dataDelay() {
  //async
  Future(() {
    print('Data yang delay');
  });

  //future delay (memberikan durasi saat ditampilkan)
  Future.delayed((Duration(seconds: 2)), () {
    print('Data yang delay selama 2 detik');
    print('Status Completed');
  });
}

//! Penerapan asynchronous (completed dan error)
Future<String> getOrder(int beli) {
  int stock = 5;

  return Future.delayed((Duration(seconds: 2)), () {
    if (stock > beli) {
      //berhasil membeli barang
      return 'Berhasil membeli barang sebanyak $beli';
    } else {
      //stock kurang dan tidak berhasil (error)
      // jika error pakai //! 'throw' bukan return ketika mengembalikan nilai
      throw 'Tidak Berhasil membeli barang karena stock kurang';
    }
  });
}
