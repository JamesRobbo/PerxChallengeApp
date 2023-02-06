//
//  SearchResponse.swift
//  PerxChallenge
//
//  Created by James Robinson on 06/02/2023.
//

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let meta: Meta?
    let results: [SearchResult]?
}

// MARK: - Meta
struct Meta: Codable {
    let disclaimer: String?
    let terms, license: String?
    let lastUpdated: String?
    let results: SearchResults?

    enum CodingKeys: String, CodingKey {
        case disclaimer, terms, license
        case lastUpdated = "last_updated"
        case results
    }
}

// MARK: - SearchResults
struct SearchResults: Codable {
    let skip, limit, total: Int?
}

// MARK: - SearchResult
struct SearchResult: Codable {
    let productNdc, genericName, labelerName, brandName: String?
    let activeIngredients: [ActiveIngredient]?
    let finished: Bool?
    let packaging: [Packaging]?
    let listingExpirationDate: String?
    let openfda: Openfda?
    let marketingCategory, dosageForm, splID, productType: String?
    let route: [String]?
    let marketingStartDate, productID, applicationNumber, brandNameBase: String?

    enum CodingKeys: String, CodingKey {
        case productNdc = "product_ndc"
        case genericName = "generic_name"
        case labelerName = "labeler_name"
        case brandName = "brand_name"
        case activeIngredients = "active_ingredients"
        case finished, packaging
        case listingExpirationDate = "listing_expiration_date"
        case openfda
        case marketingCategory = "marketing_category"
        case dosageForm = "dosage_form"
        case splID = "spl_id"
        case productType = "product_type"
        case route
        case marketingStartDate = "marketing_start_date"
        case productID = "product_id"
        case applicationNumber = "application_number"
        case brandNameBase = "brand_name_base"
    }
}

// MARK: - ActiveIngredient
struct ActiveIngredient: Codable {
    let name, strength: String?
}

// MARK: - Openfda
struct Openfda: Codable {
    let manufacturerName, splSetID: [String]?
    let isOriginalPackager: [Bool]?
    let unii: [String]?

    enum CodingKeys: String, CodingKey {
        case manufacturerName = "manufacturer_name"
        case splSetID = "spl_set_id"
        case isOriginalPackager = "is_original_packager"
        case unii
    }
}

// MARK: - Packaging
struct Packaging: Codable {
    let packageNdc, description, marketingStartDate: String?
    let sample: Bool?

    enum CodingKeys: String, CodingKey {
        case packageNdc = "package_ndc"
        case description
        case marketingStartDate = "marketing_start_date"
        case sample
    }
}

