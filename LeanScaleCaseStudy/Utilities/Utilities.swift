//
//  Utilities.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 24/09/2021.
//

import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil , leading: NSLayoutXAxisAnchor? = nil , bottom: NSLayoutYAxisAnchor? = nil , trailing: NSLayoutXAxisAnchor? = nil , centerX:NSLayoutXAxisAnchor? = nil ,centerY: NSLayoutYAxisAnchor? = nil ,paddingTop: CGFloat = 0 ,paddingLeft: CGFloat = 0 ,paddingBottom: CGFloat = 0 ,paddingRight: CGFloat = 0 , width: CGFloat = 0 ,height: CGFloat = 0 ,paddingCenterX: CGFloat = 0 ,paddingCenterY: CGFloat = 0) {
           translatesAutoresizingMaskIntoConstraints = false
           
           if let top = top {
               topAnchor.constraint(equalTo: top, constant:paddingTop).isActive = true
           }
           
           if let left = leading {
               leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
           }
           
           if let bottom = bottom {
               bottomAnchor.constraint(equalTo: bottom, constant:-paddingBottom).isActive = true
           }
           
           if let right = trailing {
               trailingAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
           }
           
           if width != 0 {
               widthAnchor.constraint(equalToConstant: width).isActive = true
           }
           
           if height != 0 {
               heightAnchor.constraint(equalToConstant: height).isActive = true
           }
           if let centerX = centerX {
               centerXAnchor.constraint(equalTo: centerX, constant: paddingCenterX).isActive = true
           }
           if let centerY = centerY {
               centerYAnchor.constraint(equalTo: centerY, constant: paddingCenterY).isActive = true
           }
       }
    
}

extension UITableViewCell {
    static func getIdentifier () -> String  {
        return String(describing: self)
    }
    
}

extension UICollectionViewCell {
    static func getIdentifier () -> String  {
        return String(describing: self)
    }
    
}
extension UIScrollView {
    func addRefreshController() -> UIRefreshControl {
        let r = UIRefreshControl()
        self.refreshControl = r
        self.addSubview(r)
        return r
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    public var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    public var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

var imageCashes = NSCache<AnyObject , AnyObject>()

extension UIImageView {
    
    func imageFromServerURL(urlString: String) {
        if let image = imageCashes.object(forKey: urlString as NSString) {
            self.image = image as? UIImage
            return
        }
        let session = URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                if error != nil {
                    return
                }
                if let data = data , let image = UIImage(data: data) {
                    imageCashes.setObject(image , forKey: urlString as NSString)
                    self.image = image
                }
                    
            })
                
        })
        session.resume()
        //return session
           
    }
    
}

func createAlert (title : String? , message : String? , cancelButton : Bool = true , view : UIView? = nil , titleOK : String = SString.ok , ok : @escaping ()->Void , present : @escaping (_ vc : UIAlertController)->Void ) {
    
    let alert = UIAlertController(title: nil , message: message , preferredStyle: UIAlertController.Style.alert)
    let ok = UIAlertAction(title: titleOK , style: .default){ _ in
        ok()
    }
    alert.addAction(ok)
    if cancelButton {
        let cancel = UIAlertAction(title: SString.cancel , style: .cancel , handler: nil )
        alert.addAction(cancel)
    }
    
    if let popoverController = alert.popoverPresentationController , let v = view {
        popoverController.sourceView = v
    }
    
    present(alert)
}
