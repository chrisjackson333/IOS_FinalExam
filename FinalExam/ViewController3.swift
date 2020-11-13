//
//  ViewController3.swift
//  FinalExam
//
//  Created by Jackson, William on 6/26/19.
//  Copyright © 2019 Jackson, William. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
    
    var article: Article?
    
    let articleTitle: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.textAlignment = .center
        return label
    }()
    let author: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Author"
        label.textAlignment = .center
        return label
    }()
    let publishedAt: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PublishedAt"
        label.textAlignment = .center
        return label
    }()
    let imageView: CachedImageView = {
        var iv = CachedImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let desc: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Desc"
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    func setupViews() {
        articleTitle.text = article?.title!
        view.addSubview(articleTitle)
        [
            articleTitle.widthAnchor.constraint(equalToConstant: 300),
            articleTitle.heightAnchor.constraint(equalToConstant: 30),
            articleTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            articleTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15)
            ].forEach({ $0.isActive = true })
        author.text = article?.author!
        view.addSubview(author)
        [
            author.widthAnchor.constraint(equalToConstant: 300),
            author.heightAnchor.constraint(equalToConstant: 30),
            author.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            author.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 10)
            ].forEach({ $0.isActive = true })
        publishedAt.text = article?.publishedAt!
        view.addSubview(publishedAt)
        [
            publishedAt.widthAnchor.constraint(equalToConstant: 300),
            publishedAt.heightAnchor.constraint(equalToConstant: 30),
            publishedAt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            publishedAt.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 10)
            ].forEach({ $0.isActive = true })
        imageView.loadImage(urlString: article!.urlToImg!)
        view.addSubview(imageView)
        [
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: publishedAt.bottomAnchor, constant: 10)
            ].forEach({ $0.isActive = true })
        desc.text = article?.desc!
        view.addSubview(desc)
        [
            desc.widthAnchor.constraint(equalToConstant: 300),
            desc.heightAnchor.constraint(equalToConstant: 300),
            desc.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            desc.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
            ].forEach({ $0.isActive = true })
    }
    
}
