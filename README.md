# UIControlTargetWrapper

In short it replaces this 
```Swift 
let button = UIButton()
button.addTarget(self, action: #selector(didTapOnButton), for: .touchDown)

@objc private func didTapOnButton() {
     //you code here...
}
```

with 
```Swift 
let button = UIButton()
button.addTarget(for: .touchDown) { _ in
    //you code here...
}
```
