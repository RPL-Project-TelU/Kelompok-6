// Deklarasi tipe data
sig EncryptedText {}
sig Text{}
sig Text1{}

// Deklarasi struktur akun
sig Account {
  id: Text, // ID akun
  email: Text, // Email akun
  password: EncryptedText, // Password yang dienkripsi
  transaction: some Transaction,
}

// Deklarasi struktur transaksi
sig Transaction {
  id: Text1, // ID transaksi
  report: one Report, // Laporan transaksi
  moneyIn: Int, // Jumlah uang masuk
  moneyOut: Int, // Jumlah uang keluar
  categoryTransaction: one CategoryTransaction, // Kategori transaksi
}

// Deklarasi kategori transaksi
sig CategoryTransaction {
  id: Text1, // ID kategori
  name: Text1, // Nama kategori
}

// Deklarasi laporan
sig Report {
  id: Text, // ID laporan
  income: Int, // Jumlah pendapatan
  expense: Int, // Jumlah pengeluaran
}

// Deklarasi kategori Hutang
sig Hutang extends CategoryTransaction {}

// Deklarasi kategori Tabungan
sig Tabungan extends CategoryTransaction {}

// Predikat untuk memvalidasi transaksi
pred validTransaction[t: Transaction] {
 t.id in Text1 and
  t.moneyIn > 0 and
  t.moneyOut >= 0 
} 

// Predikat untuk memvalidasi kategori transaksi
pred validCategoryTransaction[a: CategoryTransaction] {
a.id in Text1 and a.name in Text1
}

// Predikat untuk memvalidasi laporan
pred validReport[q: Report] {
q.id in Text and q.income > 0 and
q.expense >= 0
}

// Predikat untuk memvalidasi akun
pred validAccount[a: Account] {
 a.id in Text and
  some a.email  and
  some a.password
}

// Predikat untuk memvalidasi semua entitas
pred allValid[a: Account, t: Transaction, q: CategoryTransaction, r: Report] {
  validAccount[a] and
  validTransaction[t] and
  validCategoryTransaction[q] and
  validReport[r]
}

// Asumsi bahwa semua akun valid
assert accountsAreValid {
  all a: Account | not validAccount[a] or
validAccount[a]
}

// Asumsi bahwa semua transaksi valid
assert allTransactionsAreValid {
  all t: Transaction |  not validTransaction[t] or
validTransaction[t]
}

// Asumsi bahwa semua laporan valid
assert reportAreValid {
all q: Report | not validReport[q] or
validReport[q]
}

// Asumsi bahwa semua kategori transaksi valid
assert categoryTransactioAreValid{
all p: CategoryTransaction | validCategoryTransaction[p]
}

// Mengecek validitas semua akun
//check accountsAreValid for 2 

// Mengecek validitas semua transaksi
//check allTransactionsAreValid for 2 

// Mengecek validitas semua laporan
//check reportAreValid for 2

// Mengecek validitas semua kategori transaksi
//check categoryTransactioAreValid for 2

// Menjalankan predikat allValid
run allValid for 2
