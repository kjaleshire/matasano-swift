//
//  main.swift
//  matasano
//
//  Created by Kyle J Aleshire on 6/28/15.
//  Copyright © 2015 Kyle J Aleshire. All rights reserved.
//

import Foundation

enum MatasanoError: Error {
    case invalidHexString
}

func hexDecodeString(_ encoded_string: String) throws -> [UInt8] {
    let string_bytes = [UInt8](encoded_string.utf8)

    if string_bytes.count % 2 == 1 {
        throw MatasanoError.invalidHexString
    }

    let even_chars = string_bytes.enumerated().lazy.filter{i, _ in i % 2 == 0}.map{hexDecodeChar($1)}
    let odd_chars = string_bytes.enumerated().lazy.filter{i, _ in i % 2 == 1}.map{hexDecodeChar($1)}

    return zip(even_chars, odd_chars).map{($0 << 0x4) | $1}
}

func hexDecodeChar(_ hex_char: UInt8) -> UInt8 {
    switch UnicodeScalar(hex_char) {
    case "0"..."9":
        return hex_char - 0x30
    case "a"..."f":
        return hex_char - 0x57
    default:
        return hex_char
    }
}

do {
  try hexDecodeString("7b5a4215415d544115415d5015455447414c155c46155f4058455c5b523f")
} catch {
  print("failed")
}
