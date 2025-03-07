//
//  UIBlockingProgressHUD.swift
//  FakeNFT
//
//  Created by Igor Ignatov on 14.09.2023.
//
import UIKit
import ProgressHUD

final class UIProgressHUD {

    private static var window: UIWindow? {
        return UIApplication.shared.windows.first
    }

    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.show()
    }

    static func dismiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
}
