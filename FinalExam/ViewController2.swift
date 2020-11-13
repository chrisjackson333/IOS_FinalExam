//
//  ViewController2.swift
//  FinalExam
//
//  Created by Jackson, William on 6/26/19.
//  Copyright © 2019 Jackson, William. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController2: UIViewController {
    
    var source: Source?
    var articles = [Article]()
    var selectedArticle: Article?
    let tableView: UITableView = {
        var tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(NewsTVCell.self, forCellReuseIdentifier: "CellID")
        return tv
    }()
    
    func getArticles() {
        let sourceName = source!.id!
        AF.request("https://newsapi.org/v2/everything?q=\(sourceName)&apiKey=75bdb5648c5e4d46a92c4f251ebc8d68").responseJSON { (response) in
            if response.result.isSuccess {
                let data = JSON(response.result.value!)
                print("Data \(data)")
                let articles = data["articles"].arrayObject!
                var tempArticles = [Article]()
                for article in articles {
                    let tempArticle = Article(json: JSON(article))
                    tempArticles.append(tempArticle)
                }
                if self.articles.isEmpty {
                    self.articles = tempArticles
                    self.tableView.reloadData()
                }
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getArticles()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToNewsDetails" {
            let vc = segue.destination as! ViewController3
            vc.article = selectedArticle
        }
    }
    
    @objc func globeTapped(sender: UIButton) {
        let url = URL(string: articles[sender.tag].urlToSource!)!
        UIApplication.shared.open(url)
    }
    
}

extension ViewController2: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as! NewsTVCell
        cell.article = articles[indexPath.row]
        cell.author.text = articles[indexPath.row].author!
        cell.sourceName.text = articles[indexPath.row].sourceName!
        cell.publishedAt.text = articles[indexPath.row].publishedAt!
        cell.title.text = articles[indexPath.row].title!
        cell.newsDescription.text = articles[indexPath.row].desc!
        cell.newsImageView.loadImage(urlString: articles[indexPath.row].urlToImg!)
        cell.globeImage.tag = indexPath.row
        cell.globeImage.addTarget(self, action: #selector(globeTapped), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! NewsTVCell
        selectedArticle = cell.article!
        self.performSegue(withIdentifier: "SegueToNewsDetails", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}

class NewsTVCell: UITableViewCell {
    
    var article: Article?
    
    let newsImageView: CachedImageView = {
        var iv = CachedImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let author: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Author"
        return label
    }()
    let sourceName: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Source Name"
        return label
    }()
    let publishedAt: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Published At"
        return label
    }()
    let title: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        return label
    }()
    let newsDescription: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.numberOfLines = 2
        return label
    }()
    let globeImage: UIButton = {
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "global"), for: .normal)
        btn.contentMode = .scaleAspectFill
        return btn
    }()
    
    func setupViews() {
        addSubview(newsImageView)
        [
            newsImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14),
            newsImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            newsImageView.widthAnchor.constraint(equalToConstant: 80),
            newsImageView.heightAnchor.constraint(equalToConstant: 80)
            ].forEach({ $0.isActive = true })
        addSubview(author)
        [
            author.leftAnchor.constraint(equalTo: newsImageView.rightAnchor, constant: 4),
            author.topAnchor.constraint(equalTo: newsImageView.topAnchor, constant: -2),
            author.widthAnchor.constraint(equalToConstant: 200),
            author.heightAnchor.constraint(equalToConstant: 30)
            ].forEach({ $0.isActive = true })
        addSubview(sourceName)
        [
            sourceName.leftAnchor.constraint(equalTo: newsImageView.rightAnchor, constant: 4),
            sourceName.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 2),
            sourceName.widthAnchor.constraint(equalToConstant: 200),
            sourceName.heightAnchor.constraint(equalToConstant: 30)
            ].forEach({ $0.isActive = true })
        addSubview(publishedAt)
        [
            publishedAt.leftAnchor.constraint(equalTo: newsImageView.rightAnchor, constant: 4),
            publishedAt.topAnchor.constraint(equalTo: sourceName.bottomAnchor, constant: 2),
            publishedAt.widthAnchor.constraint(equalToConstant: 200),
            publishedAt.heightAnchor.constraint(equalToConstant: 30)
            ].forEach({ $0.isActive = true })
        addSubview(title)
        [
            title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14),
            title.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 6),
            title.widthAnchor.constraint(equalToConstant: 200),
            title.heightAnchor.constraint(equalToConstant: 30)
            ].forEach({ $0.isActive = true })
        addSubview(newsDescription)
        [
            newsDescription.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14),
            newsDescription.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 6),
            newsDescription.widthAnchor.constraint(equalToConstant: 200),
            newsDescription.heightAnchor.constraint(equalToConstant: 30)
            ].forEach({ $0.isActive = true })
        addSubview(globeImage)
        [
            globeImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            globeImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            globeImage.widthAnchor.constraint(equalToConstant: 30),
            globeImage.heightAnchor.constraint(equalToConstant: 30)
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
