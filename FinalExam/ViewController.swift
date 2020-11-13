//
//  ViewController.swift
//  FinalExam
//
//  Created by Jackson, William on 6/26/19.
//  Copyright © 2019 Jackson, William. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    //KEY 75bdb5648c5e4d46a92c4f251ebc8d68
    
    var sources = [Source]()
    var selectedSource: Source?
    let tableView: UITableView = {
        var tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(NewsSourceTVCell.self, forCellReuseIdentifier: "CellID")
        return tv
    }()
    
    override func viewDidLoad() {x
        super.viewDidLoad()
        getSources()
        view.addSubview(tableView)
        [
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        tableView.topAnchor.constraint(equalTo: view.topAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].forEach({ $0.isActive = true })
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getSources() {
        AF.request("https://newsapi.org/v2/sources?language=en&apiKey=75bdb5648c5e4d46a92c4f251ebc8d68").responseJSON { (response) in
            if response.result.isSuccess {
                let data = JSON(response.result.value!)
                let sources = data["sources"].arrayObject!
                var tempSources = [Source]()
                for source in sources {
                    let tempSource = Source(json: JSON(source))
                    tempSources.append(tempSource)
                }
                if self.sources.isEmpty {
                    self.sources = tempSources
                    self.tableView.reloadData()
                }
                
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToNews" {
            let vc = segue.destination as! ViewController2
            vc.source = selectedSource
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as! NewsSourceTVCell
        cell.source = sources[indexPath.row]
        cell.nameLabel.text = sources[indexPath.row].name!
        cell.descLabel.text = sources[indexPath.row].desc!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! NewsSourceTVCell
        selectedSource = cell.source!
        self.performSegue(withIdentifier: "SegueToNews", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
}

class NewsSourceTVCell: UITableViewCell {
    
    var source: Source?
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        return label
    }()
    let descLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.numberOfLines = 3
        return label
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        [
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            nameLabel.widthAnchor.constraint(equalToConstant: 200),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
            ].forEach({ $0.isActive = true })
        addSubview(descLabel)
        [
            descLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14),
            descLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            descLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            descLabel.heightAnchor.constraint(equalToConstant: 65)
            ].forEach({ $0.isActive = true })
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

