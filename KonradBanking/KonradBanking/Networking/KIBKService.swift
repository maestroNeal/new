//
//  Copyright © 2024 Konrad Group. All rights reserved.
//

import Foundation
import Alamofire

// Konradian Imperial Bank of Konmerce
struct KIBKTransactionResponse: Codable {
    
    struct KIBKTransaction: Codable {
        let date: Date
        let amount: Double
        let transactionId: String
        let details: String
        let category: [String]
        let accountNumber: String
    }
    
    let data: [KIBKTransaction]
}

class KIBKService {
    static func getTransactions(completion: @Sendable @escaping ([KIBKTransactionResponse.KIBKTransaction]) -> ()) {
        AF.request("https://kghiretest.s3.amazonaws.com/KIBK.json").response { response in
            do {
                guard let data = response.data else {
                    return completion([])
                }
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let transactions = try decoder.decode(KIBKTransactionResponse.self, from: data).data
                completion(transactions)
            }
            catch {
                completion([])
            }
        }
    }
}
