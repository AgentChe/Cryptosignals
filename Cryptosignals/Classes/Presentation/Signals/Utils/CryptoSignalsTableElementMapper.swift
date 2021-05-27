//
//  CryptoSignalsTableElementMapper.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 23.05.2021.
//

final class CryptoSignalsTableElementMapper {
    static func map(signals: [CryptoSignal],
                    exchanges: [Exchange],
                    currencies: [Currency]) -> [CryptoSignalsTableElement] {
        signals.map { signal in
            let fromCurrency = currencies.first(where: { $0.id == signal.fromCurrencyId })?.code ?? ""
            let toCurrency = currencies.first(where: { $0.id == signal.toCurrencyId })?.code ?? ""
            let currencies = String(format: "%@-%@", fromCurrency, toCurrency)
            
            let exchange = exchanges.first(where: { $0.id == signal.exchangeId })
            
            return CryptoSignalsTableElement(currencies: currencies,
                                             type: signal.type,
                                             date: signal.date,
                                             dateString: signal.humanDate,
                                             exchange: exchange?.name ?? "",
                                             gain: String(format: "%.2f%%", signal.gain),
                                             entryPoint: String(format: "%@ %@", fromCurrency, signal.entry),
                                             targetPrice: String(format: "%@ %@", fromCurrency, signal.target))
        }
    }
}
