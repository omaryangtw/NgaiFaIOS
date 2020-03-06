//
//  ViewController.swift
//  Ngaifa
//
//  Created by Yang Omar on 2020/3/5.
//  Copyright © 2020 Yang Omar. All rights reserved.
//

import UIKit

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView? {
        didSet { textView?.contentInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0) }
    }
}


