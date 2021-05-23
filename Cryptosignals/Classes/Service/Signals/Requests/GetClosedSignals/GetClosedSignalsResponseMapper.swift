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
                let timestamp = signalJSON["timestamp"] as? String,
                let typeValue = signalJSON["type"] as? Int,
                let type = CryptoSignal.Kind(rawValue: typeValue),
                let entry = signalJSON["entry"] as? Double,
                let target = signalJSON["target"] as? Double,
                let gain = signalJSON["gain"] as? Double
            else {
                return nil
            }
            
            return CryptoSignal(id: id,
                                exchangeId: exchangeId,
                                fromCurrencyId: fromCurrencyId,
                                toCurrencyId: toCurrencyId,
                                timestamp: timestamp,
                                type: type,
                                entry: entry,
                                target: target,
                                gain: gain)
        }
    }
}
