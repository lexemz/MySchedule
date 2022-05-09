//
//  Log.swift
//  URLSessionKinopoisk
//
//  Created by Igor on 14.02.2022.
//

import Foundation

class Logger {
    private init() {}
    
    static func debug(
        _ data: @autoclosure () -> Any?,
        file: String = #file,
        line: Int = #line
    ) {
        let result = """
        
        🔹 [DEBUG]
        [DATA]: \(String(describing: data() ?? ""))
        [FILE]: \(extractFileName(from: file))
        [LINE]: \(line)
        ----------------
        """
        print(result)
    }
    
    static func error(
        _ error: Error,
        file: String = #file,
        line: Int = #line
    ) {
        let result = """

        🔸 [DEBUG]
        [ERROR]: \(error)
        [DESCRIPTION]: \(error.localizedDescription)
        [FILE]: \(extractFileName(from: file))
        [LINE]: \(line)
        ----------------
        """
        print(result)
    }
    
    private static func extractFileName(from path: String) -> String {
        path.components(separatedBy: "/").last ?? "[No file path]"
    }
}
