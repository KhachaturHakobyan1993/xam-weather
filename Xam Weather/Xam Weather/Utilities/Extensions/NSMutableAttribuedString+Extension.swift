//
//  NSMutableAttribuedString+Extension.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/26/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
	func height(withConstrainedWidth width: CGFloat) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
		
		return boundingBox.height
	}
	
	func width(withConstrainedHeight height: CGFloat) -> CGFloat {
		let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
		let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
		
		return boundingBox.width
	}
	
	class func setupWithText(_ text: String, description: String, textFont: UIFont, descriptionFont: UIFont, textColor: UIColor, descriptionColor: UIColor) -> NSMutableAttributedString?{
		
		let textAttribute = [NSAttributedString.Key.font: textFont, NSAttributedString.Key.foregroundColor: textColor]
		let descriptionAttribute = [NSAttributedString.Key.font: descriptionFont, NSAttributedString.Key.foregroundColor: descriptionColor]
		
		let attributedText = NSMutableAttributedString(string: text,
													   attributes: textAttribute)
		let descriptionAttributedString = NSMutableAttributedString(string: description,
																	attributes:  descriptionAttribute)
		attributedText.append(descriptionAttributedString)
		return attributedText
	}
	
	func appendNewLine() {
		self.append(NSAttributedString(string: "\n"))
	}
	
	func centerAlignWithSpacing(_ lineSpacing: CGFloat) {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .center
		paragraphStyle.lineSpacing = lineSpacing
		self.setParagraphStyle(paragraphStyle: paragraphStyle)
	}
	
	func setLineSpacing(_ lineSpacing: CGFloat) {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = lineSpacing
		self.setParagraphStyle(paragraphStyle: paragraphStyle)
	}
	
	func setParagraphStyle(paragraphStyle: NSParagraphStyle) {
		let range = NSMakeRange(0, self.string.count)
		self.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
	}
}
