//
//  Copyright © 2024 Konrad Group. All rights reserved.
//

import Foundation
import Alamofire

// Royal Bank of Konrada
struct RBKTransactionResponse: Codable {
    struct RBKTransaction: Codable {
        let transactionId: String
        let description: String
        let transactionAmount: Double
        let currency: Currency
        let isWithdrawal: Bool
        let date: Date
        let accountId: String
        
        enum Currency: String, Codable {
            case CAD
            case USD
        }
    }
    
    let data: [RBKTransaction]
}

class RBKService {
    static func getTransactions(completion: @Sendable @escaping ([RBKTransactionResponse.RBKTransaction]) -> ()) {
        AF.request("https://kghiretest.s3.amazonaws.com/RBK.json").response { response in
            do {
                guard let data = response.data else {
                    return completion([])
                }
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let transactions = try decoder.decode(RBKTransactionResponse.self, from: data).data
                completion(transactions)
            }
            catch {
                completion([])
            }
        }
    }
}
