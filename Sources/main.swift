// The Swift Programming Language
// https://docs.swift.org/swift-book

//  Created by maomh on 2021/4/15.

import Foundation
import ArgumentParser
import AppKit

@main
struct Imkit: ParsableCommand {
    @Flag(help: "Use default ABC input method.")
    var abc = false

    @Flag(help:"使用系统自带拼音输入法.")
    var pinyin = false

    @Flag(name: .shortAndLong, help:"List all of input methods that could be used.")
    var listAll = false

    @Option(name: .shortAndLong, help: "Select the input method 'code' and active it.")
    var select: String?

    mutating func run() throws {

        let context = NSTextInputContext.init(client: NSTextView.init())

        // 所有可用的输入法
        let all = context.keyboardInputSources ?? []

        // 输出所有可用的输入法
        if listAll {
            for im in all {
                print(im)
            }
            return
        }

        // select 不为空
        let targetInputMethod = select ?? ""
        if !targetInputMethod.isEmpty {
            for im in all {
                if im.contains(targetInputMethod) {
                    context.selectedKeyboardInputSource = im
                    print("Change input method to: \(im)")
                    return
                }
            }
            print("Input method not found: \(targetInputMethod)")
            return
        }

        let ims: [String: String] = [
            "ABC": "com.apple.keylayout.ABC",
            "简体拼音": "com.apple.inputmethod.SCIM.ITABC"
        ]

        if abc {
            context.selectedKeyboardInputSource = ims["ABC"]
            return
        }

        if pinyin {
            context.selectedKeyboardInputSource = ims["简体拼音"]
            return
        }

        let current = context.selectedKeyboardInputSource ?? ""
        if !current.isEmpty {
            print(current)
        }
    }
}

