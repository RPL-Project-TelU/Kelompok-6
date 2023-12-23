sig Text {}
sig EncrtpedText{}

sig Account {
	id: Text,
	email: Text,
	password: EncrtpedText,
	id_account: some Transaksi,
}

sig Transaksi {
	id: Text,
	id_account: Text,
	id_Transaksi: some Laporan,
	Masuk: Text,
	keluar: Text,
}

sig KategoriTransaksi{
	id: Text,
	id_Kategori: some Transaksi,
	namakategori: Text,
}

sig Laporan {
	id: Text, 
	Pemasukan: Text,
	Pengeluaran: Text,
}

run {} for 2
