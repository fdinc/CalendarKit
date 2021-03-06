import UIKit
import DateToolsSwift

class DateLabel: UILabel {

  var fontSize: CGFloat = 18

  var date: Date! {
    didSet {
      text = String(date.day)
      updateState()
    }
  }

  var selected: Bool = false {
    didSet {
      animate()
    }
  }

  var style = DaySelectorStyle()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }

  func configure() {
    isUserInteractionEnabled = true
    textAlignment = .center
    clipsToBounds = true
  }

  func updateStyle(_ newStyle: DaySelectorStyle) {
    style = newStyle
    updateState()
  }

  func updateState() {
    let today = date.isToday
    if selected {
      font = UIFont.boldSystemFont(ofSize: fontSize)
      textColor = style.activeTextColor
      backgroundColor = today ? style.todayActiveBackgroundColor : style.selectedBackgroundColor
    } else {
      let notTodayColor = date.isWeekend ? style.weekendTextColor : style.inactiveTextColor
      font = UIFont.systemFont(ofSize: fontSize)
      textColor = today ? style.todayInactiveTextColor : notTodayColor
      backgroundColor = style.inactiveBackgroundColor
    }
  }

  func animate(){
    UIView.transition(with: self, duration: 0.4,
      options: .transitionCrossDissolve,
      animations: { _ in
        self.updateState()
      }, completion: nil)
  }

  override func layoutSubviews() {
    layer.cornerRadius = bounds.height / 2
  }
  override func tintColorDidChange() {
    updateState()
  }
}
