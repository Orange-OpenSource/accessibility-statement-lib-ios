//
// MIT License
// Copyright (c) 2023 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation

struct Declaration {
    
    // =======================
    // MARK: Stored Properties
    // =======================
    
    public var title : String = String()
    public var lang: String = String()
    public var status: String = String()
    public var auditDate: String = String()
    public var conformity: String = String()
    public var conformityAverage: CGFloat = CGFloat()
    public var conformityAverageDisplay: String = String ()
    public var referentialName: String = String()
    public var referentialVersion: String = String()
    public var referentialLevel: String = String()
    public var technologies: String = String()
    public var detailUrl: String = String()
    public var identityAdresse: String = String()
    public var identityName: String = String()
}
