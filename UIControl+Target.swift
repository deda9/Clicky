import UIKit

protocol TargetProtocol {
    typealias TargetCallback = (UIControl) -> Void
    func addTarget(for event: UIControl.Event, callback: @escaping TargetCallback)
}

extension UIControl: TargetProtocol {
    
    private struct Keys {
        static var addingTarget = "addingTargetKey"
    }
    
    private class TargetCallbackWrapper: NSObject {
        var callback: TargetCallback?
        init(_ callback: TargetCallback?) {
            self.callback = callback
        }
    }
    
    private var targetCallback: TargetCallback? {
        get {
            guard let callbackWapper = objc_getAssociatedObject(self, &Keys.addingTarget) as? TargetCallbackWrapper else {
                return nil
            }
            return callbackWapper.callback
        }
        
        set{
            objc_setAssociatedObject(self, &Keys.addingTarget, TargetCallbackWrapper(newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addTarget(for event: UIControl.Event, callback: @escaping TargetCallback) {
        self.targetCallback = callback
        self.addTarget(self, action: #selector(didTapOnButton), for: event)
    }
    
    @objc private func didTapOnButton() {
        self.targetCallback?(self)
    }
}
