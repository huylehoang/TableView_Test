//
//  ViewModel.swift
//  TableView_Test
//
//  Created by LeeX on 9/21/19
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import RxDataSources
import RxCocoa
import RxSwift

class ViewModel {
    lazy private var tableData = {
        return PropertyList.loadNames(by: PListReader(resource: "Names", type: "plist"))
    }()
    
    lazy private var indexTitlesArray = {
        return "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
            .components(separatedBy: " ")
    }()
    
    let sections: PublishSubject<[MySection]> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    
    private func getData(with sectionTitle: String) -> [String] {
        return tableData.filter{ $0.prefix(1) == sectionTitle }
    }
    
    private func getData() {
        loading.onNext(true)
        var tmpSections = [MySection]()
        indexTitlesArray.forEach { (title) in
            !getData(with: title).isEmpty ? tmpSections.append(MySection(header: title, items: getData(with: title))) : ()
        }
        !tmpSections.isEmpty ? sections.onNext(tmpSections) : error.onNext("No Data Founded")
        loading.onNext(false)
    }
    
    func requestData() {
        getData()
    }
}

extension ViewModel {
    func dataSource() -> RxTableViewSectionedReloadDataSource<MySection> {
        let dataSource = RxTableViewSectionedReloadDataSource<MySection>(
            configureCell: { (_, tableView, indexPath, item) -> UITableViewCell in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                    return UITableViewCell(style: .default, reuseIdentifier: "cell")
                }
                cell.textLabel?.text = item
                return cell
                
        })
        dataSource.titleForHeaderInSection = { (dataSource, section) in
            return dataSource[section].header
        }
        dataSource.sectionIndexTitles = { [weak self] (_) in
            guard let `self` = self else { return nil }
            return self.indexTitlesArray
        }
        return dataSource
    }
}
