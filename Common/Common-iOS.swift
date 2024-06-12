import UIKit

extension UILabel: ToggleableLabel {
    func turnOn() {
        textColor = UIColor.white
    }

    func turnOff() {
        textColor = UIColor.darkGray
    }
}
