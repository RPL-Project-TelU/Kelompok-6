abstract sig User {}
abstract sig Admin {}

sig Nasabah extends User {}
sig Bank extends Admin {}

sig CreditCard {
    owner: Nasabah,
    limit: Int,
    balance: Int
}

sig Transaction {
    payer: Nasabah,
    payee: Bank,
    amount: Int,
    status: one StatusTransaction
}

sig StatusTransaction {
    success, failure
}

// Rules

// Rule 1: Setiap kartu kredit dimiliki oleh satu Nasabah
fact CreditCardOwnership {
    all c: CreditCard | one o: Nasabah | c.owner = o
}

// Rule 2: Jumlah transaksi harus non-negatif
fact NonNegativeTransaction {
    all t: Transaction | t.amount >= 0
}

// Rule 3: Setiap transaksi harus memiliki status
fact TransactionStatus {
    all t: Transaction | one s: StatusTransaction | t.status = s
}

// Rule 4: Transaksi sukses hanya dapat dilakukan oleh Nasabah
fact SuccessfulTransactionByNasabah {
    all t: Transaction | t.status = StatusTransaction.success implies t.payer in Nasabah
}

// Rule 5: Transaksi ke Bank harus sukses
fact SuccessfulTransactionToBank {
    all t: Transaction | t.payee in Bank implies t.status = StatusTransaction.success
}

run {} for 5 but 2 Nasabah, 3 Bank, 3 CreditCard, 5 Transaction, 2 StatusTransaction
