//
//  ██╗  ██╗████████╗███████╗██╗  ██╗████████╗
//  ╚██╗██╔╝╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝
//   ╚███╔╝    ██║   █████╗   ╚███╔╝    ██║
//   ██╔██╗    ██║   ██╔══╝   ██╔██╗    ██║
//  ██╔╝ ██╗   ██║   ███████╗██╔╝ ██╗   ██║
//  ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝
//
//  xEncode.swift
//  xTextHandler (https://github.com/cyanzhong/xTextHandler/)
//
//  Created by cyan on 16/7/4.
//  Copyright © 2016年 cyan. All rights reserved.
//

import Foundation
import AppKit
import CoreImage

//-- Encode & Decode --//
func Base64Encode(string: String) -> String {
    let encodedData = string.data(using: .utf8)
    return encodedData?.base64EncodedString() ?? string
}

func Base64Decode(string: String) -> String {
    if let decodedData = Data(base64Encoded: string) {
        return String(data: decodedData, encoding: .utf8) ?? string
    } else {
        return string
    }
}

func URLEncode(string: String) -> String {
    return string.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? string
}

func URLDecode(string: String) -> String {
    return string.removingPercentEncoding ?? string
}

func UpperCase(string: String) -> String {
    return string.uppercased()
}

func LowerCase(string: String) -> String {
    return string.lowercased()
}

func Escape(string: String) -> String {
    
    var result = ""
    for uc in string.characters {
        switch uc {
        case "\"":
            result.append("\\\"")
            break
        case "\'":
            result.append("\\\'")
            
            break
        case "\\":
            result.append("\\\\")
            break
        case "\t":
            result.append("\\t")
            break
        case "\n":
            result.append("\\n")
            break
        case "\r":
            result.append("\\r")
            break
        case "\u{8}":
            result.append("\\u{8}")
            break
        case "\u{12}":
            result.append("\\u{12}")
        default:
            result.append(uc)
            break
        }
    }
    
    return result
}

//-- Hash --//
func toHex(digest: [UInt8], length: Int) -> String {
    var hex = ""
    for index in 0..<length {
        hex += String(format: "%02x", digest[index])
    }
    return hex
}

func Crypto(string: String, length: Int, algorithm: (data: NSData, digest: UnsafeMutablePointer<UInt8>) -> ()) -> String {
    let digest = UnsafeMutablePointer<UInt8>(allocatingCapacity: length)
    if let data: NSData = string.data(using: .utf8) {
        algorithm(data: data, digest: digest)
        return toHex(digest: Array(UnsafeBufferPointer(start: digest, count: length)), length: length)
    } else {
        return string
    }
}

func MD5(string: String) -> String {
    return Crypto(string: string, length: Int(CC_MD5_DIGEST_LENGTH), algorithm: { data, digest in
        CC_MD5(data.bytes, CC_LONG(data.length), digest)
    })
}

func SHA1(string: String) -> String {
    return Crypto(string: string, length: Int(CC_SHA1_DIGEST_LENGTH), algorithm: { data, digest in
        CC_SHA1(data.bytes, CC_LONG(data.length), digest)
    })
}

func SHA256(string: String) -> String {
    return Crypto(string: string, length: Int(CC_SHA256_DIGEST_LENGTH), algorithm: { data, digest in
        CC_SHA256(data.bytes, CC_LONG(data.length), digest)
    })
}

//-- QRCode Image --//
func createImage(image: CIImage, size: CGFloat) -> NSImage? {
    
    let extent = image.extent.integral
    let scale = min(size/extent.width, size/extent.height)
    let width = extent.width * scale
    let height = extent.height * scale
    let colorSpace = CGColorSpaceCreateDeviceGray()
    if let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue) {
        let context = CIContext(options: nil)
        if let bitmapImage = context.createCGImage(image, from: extent) {
            bitmapRef.interpolationQuality = CGInterpolationQuality.none
            bitmapRef.scale(x: scale, y: scale)
            bitmapRef.draw(in: extent, image: bitmapImage)
            if let scaledImage = bitmapRef.makeImage() {
                return NSImage(cgImage: scaledImage, size: CGSize(width: size, height: size))
            }
        }
    }
    
    return nil
}

func QRCode(string: String) -> String {
    
    let data = string.data(using: .utf8)
    if let filter = CIFilter(name: "CIQRCodeGenerator") {
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("M", forKey: "inputCorrectionLevel")
        if let output = filter.outputImage, let image = createImage(image: output, size: 400) {
            // write to pasteboard
            let pasteboard = NSPasteboard.general()
            pasteboard.clearContents()
            pasteboard.writeObjects([image])
            // save file
            if let tiff = image.tiffRepresentation, let dowloads = NSSearchPathForDirectoriesInDomains(.downloadsDirectory, .userDomainMask, true).first {
                let path = (dowloads as NSString).appendingPathComponent("qrcode.png")
                let imageRep = NSBitmapImageRep(data: tiff)
                let imageData = imageRep?.representation(using: .PNG, properties: [:])
                do {
                    let url = URL(fileURLWithPath: path)
                    try imageData?.write(to: url)
                    // open generated file
                    NSWorkspace.shared().open(url)
                } catch {
                    xTextLog(string: "QRCode image write failed")
                }
            }
        }
    }
    
    return string
}
