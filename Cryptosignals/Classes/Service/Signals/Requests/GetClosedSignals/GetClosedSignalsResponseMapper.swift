//
//  GetClosedSignalsResponseMapper.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 21.05.2021.
//

final class GetClosedSignalsResponseMapper {
    static func map(from response: Any) -> [CryptoSignal] {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any],
            let signals = data["signals"] as? [[String: Any]]
        else {
            return []
        }
        
        return signals.compactMap { signalJSON -> CryptoSignal? in
            guard
                let id = signalJSON["id"] as? Int,
                let exchangeId = signalJSON["exchange_id"] as? Int,
                let fromCurrencyId = signalJSON["from_currency_id"] as? Int,
                let toCurrencyId = signalJSON["to_currency_id"] as? Int,
                let dateStringFormat = signalJSON["timestamp"] as? String,
                let humanDate = signalJSON["timestamp_human"] as? String,
                let typeValue = signalJSON["type"] as? Int,
                let type = CryptoSignal.Kind(rawValue: typeValue),
                let entry = signalJSON["entry"] as? String,
                let target = signalJSON["target"] as? String,
                let gain = signalJSON["gain"] as? Double
            else {
                return nil
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            
            guard let date = formatter.date(from: dateStringFormat) else {
                return nil
            }
            
            return CryptoSignal(id: id,
                                exchangeId: exchangeId,
                                fromCurrencyId: fromCurrencyId,
                                toCurrencyId: toCurrencyId,
                                date: date,
                                humanDate: humanDate,
                                type: type,
                                entry: entry,
                                target: target,
                                gain: gain)
        }
    }
}
