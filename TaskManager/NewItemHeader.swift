//
//  NewItemHeader.swift
//  TaskManager
//
//  Created by Björn Fröhling on 08/10/2017.
//  Copyright © 2017 Fröhling. All rights reserved.
//

import UIKit


class NewItemHeader: UIView, UITextFieldDelegate {

  var addNewItemClosure :(String) -> ()
  
  init(_ controller: UIViewController, placeholder: String, addNewItemClosure: @escaping (String) -> ()) {
    self.addNewItemClosure = addNewItemClosure
    super.init(frame: controller.view.frame)
    setup(placeholder)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("Still needs to be overwritten!")
  }
  
  private func setup(_ placeholder: String) {
    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 44))
    let textField = UITextField(frame: headerView.frame)
    textField.placeholder = placeholder
    textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
    textField.leftViewMode = .always
    textField.delegate = self
    headerView.addSubview(textField)
    self.addSubview(headerView)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let text = textField.text {
      addNewItemClosure(text)
    }
    textField.text = ""
    return textField.resignFirstResponder()
  }

}
