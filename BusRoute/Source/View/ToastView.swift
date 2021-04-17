//
//  ToastView.swift
//  BusRoute
//
//  Created by Rathi on 4/3/21.
//

import UIKit

enum ToastPosition: Int {
    case top
    case bottom
}
final class ToastView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabelForToastWithOnlyMessage: UILabel!
    
    static let toastViewTag = 100
    fileprivate static let dismissInterval: TimeInterval = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(ToastView.className, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView?.backgroundColor = UIColor.orange
        
    }
    
    var message: String? {
        didSet {
            titleLabelForToastWithOnlyMessage.textAlignment = .center
            titleLabelForToastWithOnlyMessage.text = message
            titleLabelForToastWithOnlyMessage.sizeToFit()
        }
    }
    
    var dismissAfter: TimeInterval? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + ToastView.dismissInterval) {
                self.hide()
            }
        }
    }
    var toastColor: UIColor? {
        didSet {
            contentView?.backgroundColor = toastColor ?? UIColor.gray
        }
    }
    var position: ToastPosition?
    
    // MARK: Show toast message
    func show() {
        if let mainWindow = UIApplication.shared.keyWindow {
            self.tag = ToastView.toastViewTag
            var delay: TimeInterval = 0
            // check if any toast exists; if so show the next queued toast after some delay
            if mainWindow.viewWithTag(ToastView.toastViewTag) != nil {
                delay = 1.0
            }
            perform(#selector(ToastView.showToastMessage), with: nil, afterDelay: delay)
        }
    }
    
    /**
     To dismiss toast message
     */
    func hide() {
        self.removeFromSuperview()
    }
    
    @objc fileprivate func showToastMessage() {
        if let mainWindow = UIApplication.shared.keyWindow {
            // remove the existing toast
            if let oldToast = mainWindow.viewWithTag(ToastView.toastViewTag) {
                oldToast.removeFromSuperview()
            }
            mainWindow.addSubview(self)
        }
        
    }
    class func toast(with message: String, dismissAfter: TimeInterval = ToastView.dismissInterval, position: ToastPosition = .bottom, toastColor: UIColor = UIColor.themeColor) -> ToastView? {
        var y: CGFloat = 0
        let x: CGFloat = 0
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 80
        let tabPosition = position
        
        switch tabPosition {
        case .bottom:
            y = UIScreen.main.bounds.height - height
        case .top:
            y = 56 + UIApplication.shared.statusBarFrame.height
        }
        let toast = ToastView(frame: CGRect(x: x, y: y, width: width, height: height))
        toast.message = message
        toast.position = position
        toast.dismissAfter = dismissAfter
        toast.toastColor = toastColor
        
        return toast
    }
}
