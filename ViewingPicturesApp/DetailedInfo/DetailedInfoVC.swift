//
//  DetailedInfoVC.swift
//  ViewingPicturesApp
//
//  Created by Ramil Sharapov on 2021-08-31.
//

import UIKit

class DetailedInfoVC: UIViewController {
         
    private let networkService = NetworkService()
    
    private lazy var detailedInfoView = view as! DetailedInfoViewVC
    
    override func loadView() {
        view = DetailedInfoViewVC(frame: UIScreen.main.bounds)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

    }

    func setupResult(result: GeneralTableViewCellModel) {
        detailedInfoView.bind(data: result)
    }
}


