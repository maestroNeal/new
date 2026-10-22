//
//  KDService.swift
//  KonradBanking
//
//  Created by Rahul Gangwar on 23/10/26.
//

import Foundation
import Alamofire

struct KDTransactionResponse: Codable {

    struct KDTransaction: Codable {

        struct Amount: Codable {
            let amount: Double
            let currency: String
        }

        struct Party: Codable {
            let id: String
            let name: String
        }

        enum TransactionType: String, Codable {
            case withdrawal
            case deposit
        }

        let id: String
        let transactionTime: Date
        let tags: [String]?
        let amount: Amount
        let from: Party
        let to: Party
        let type: TransactionType
    }

    let data: [KDTransaction]
}

class KDService {
    static func getTransactions(completion: @Sendable @escaping ([KDTransactionResponse.KDTransaction]) -> ()) {
        AF.request("https://kghiretest.s3.amazonaws.com/KD.json").response { response in
            do {
                guard let data = response.data else {
                    return completion([])
                }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let transactions = try decoder.decode(KDTransactionResponse.self, from: data).data
                completion(transactions)
            }
            catch {
                completion([])
            }
        }
    }
}
