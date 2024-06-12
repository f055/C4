import WatchKit

extension WKInterfaceLabel: ToggleableLabel {
    func turnOn() {
        setTextColor(UIColor.white)
    }

    func turnOff() {
        setTextColor(UIColor.darkGray)
    }
}
