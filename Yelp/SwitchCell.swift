//
//  SwitchCell.swift
//  Yelp
//
//  Created by Janvier Wijaya on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    @objc optional func switchCell(_ switchCell: SwitchCell,
            didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {
    weak var delegate: SwitchCellDelegate?

    @IBOutlet weak var controlLabel: UILabel!
    @IBOutlet weak var controlSwitch: UISwitch!

    @IBAction func changeSwitchValue(_ sender: Any) {
        delegate?.switchCell?(self, didChangeValue: controlSwitch.isOn)
    }
}
