//
//  Copyright © 2024 Konrad Group. All rights reserved.
//

import Foundation
import Alamofire

// Bank of Konreal
struct BKOTransactionResponse: Codable {
    
    struct BKOTransaction: Codable {
        
        struct Contact: Codable {
            let contactId: String
            let name: String
        }
        
        struct Account: Codable {
            enum AccountType: String, Codable {
                case chequing
                case savings
                case credit
            }
            let accountId: String
            let name: String
            let type: AccountType
        }
        
        let date: Date
        let amount: Double
        let contact: Contact
        let account: Account
        let isDeposit: Bool
        let note: String?
    }
    
    let data: [BKOTransaction]
}

class BKOService {
    static func getTransactions(completion: @Sendable @escaping ([BKOTransactionResponse.BKOTransaction]) -> ()) {
        AF.request("https://kghiretest.s3.amazonaws.com/BKO.json").response { response in
            do {
                guard let data = response.data else {
                    return completion([])
                }
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let transactions = try decoder.decode(BKOTransactionResponse.self, from: data).data
                completion(transactions)
            }
            catch {
                completion([])
            }
        }
    }
}
