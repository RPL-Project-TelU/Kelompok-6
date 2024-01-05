
one sig EncryptedText {}
one sig Text{}

sig Account {
  id: EncryptedText,
  email: Text,
  password: EncryptedText,
  transactions: some Transaction, 
}

sig Transaction {
  id: Text,
  report: one Report,
  moneyIn: Int,
  moneyOut: Int,
}

sig CategoryTransaction {
  id: Text,
  transactions: one Transaction, 
  name: Text,
}

sig Report {
  id: Text, 
  income: Int,
  expense: Int,
}

sig Hutang {
id: EncryptedText,
namaKategori: one CategoryTransaction,
}

sig Tabungan {
id: EncryptedText,
namaKategori1: one CategoryTransaction,
}

// Define facts and predicates

fact {
  all t: Transaction | t.moneyIn > 0
}

fact {
  all t: Transaction | t.moneyOut >= 0
}

pred validTransaction[t: Transaction] {
  t.moneyIn > 0 and t.moneyOut >= 0
} 

assert totalMoneyInIsPositive {
  all r: Report | r.income > 0
}

assert totalMoneyOutIsNonNegative {
  all r: Report | r.expense >= 0
}

pred validAccount[a: Account] {
  a.id in EncryptedText
}

assert accountsAreValid {
  all a: Account | validAccount[a]
}

run {} for 2 but 3 Int, 1 Text, 1 EncryptedText

