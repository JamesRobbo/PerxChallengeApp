//
//  DetailViewController.swift
//  PerxChallenge
//
//  Created by James Robinson on 06/02/2023.
//

import UIKit

class DetailViewController: BaseViewController<DetailViewModel> {
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    // I have left minimal information shown on this page. If I had more time a more detailed view could be developer, with a better UI as well.
    
    private func setupView() {
        var labels = [UILabel]()
        labels.append(self.createLabel(title: "Name: ",
                                       text: self.viewModel.searchResult.brandName))
        labels.append(self.createLabel(title: "Generic name: ",
                                       text: self.viewModel.searchResult.genericName))
        let ingredientsLabels = self.viewModel.searchResult.activeIngredients?.compactMap { self.createLabel(title: "\($0.name ?? ""): ", text: $0.strength) }
        if let ingredientsLabels = ingredientsLabels {
            labels.append(contentsOf: ingredientsLabels)
        }
        labels.append(self.createLabel(title: "Manufacturer: ",
                                       text: self.viewModel.searchResult.openfda?.manufacturerName?.first))
        
        labels.forEach {
            self.stackView.addArrangedSubview($0)
        }
        let spacerView = UIView()
        self.stackView.addArrangedSubview(spacerView)
    }

    private func createLabel(title: String = "", text: String?) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        if let text = text {
            label.text = title + text
        }
        return label
    }
}
