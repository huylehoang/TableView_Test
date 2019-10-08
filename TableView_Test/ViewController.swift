//
//  ViewController.swift
//  TableView_Test
//
//  Created by LeeX on 3/31/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "List"
        setUpBinding()
        viewModel.requestData()
    }
    
    private func setUpBinding() {
        
        viewModel.loading
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.sections
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource()))
            .disposed(by: disposeBag)
        
        viewModel.error
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] (error) in
                guard let `self` = self else { return }
                self.emptyScreen(withText: error.element)
            }
            .disposed(by: disposeBag)
    }
}

//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//
//    private func getData(forSection section: Int) -> [String] {
//        return tableData.filter{ $0.prefix(1) == indexTitlesArray[section] }
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return indexTitlesArray.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return getData(forSection: section).count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
//            return UITableViewCell(style: .default, reuseIdentifier: "cell")
//        }
//        cell.textLabel?.text = getData(forSection: indexPath.section)[indexPath.row]
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return indexTitlesArray[section]
//    }
//
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return indexTitlesArray
//    }
//
//    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
//        return indexTitlesArray.firstIndex(of: title) ?? 0
//    }
//}
