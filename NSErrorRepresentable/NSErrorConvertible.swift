// NSErrorRepresentable
// Written in 2016 by Nate Stedman <nate@natestedman.com>
//
// To the extent possible under law, the author(s) have dedicated all copyright and
// related and neighboring rights to this software to the public domain worldwide.
// This software is distributed without any warranty.
//
// You should have received a copy of the CC0 Public Domain Dedication along with
// this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

import Foundation

// MARK: - Error Convertible

/// A protocol for types that can be converted to an `NSError` object.
public protocol NSErrorConvertible
{
    // MARK: - Components

    /// The error domain.
    static var domain: String { get }

    /// The error code.
    var code: Int { get }

    /// The error's user info, if any.
    ///
    /// This property's default implementation returns `nil`.
    var userInfo: [String:AnyObject]? { get }
}

extension NSErrorConvertible
{
    public var userInfo: [String:AnyObject]? { return nil }
}

extension NSErrorConvertible
{
    // MARK: - Error

    /// Returns an `NSError` representation of the receiver.
    public var NSError: Foundation.NSError
    {
        return Foundation.NSError(domain: Self.domain, code: code, userInfo: userInfo)
    }
}

extension NSErrorConvertible where Self:RawRepresentable, Self.RawValue == Int
{
    // MARK: - Raw Representable

    /// A default implementation of `code` that returns `rawValue`.
    public var code: Int { return rawValue }
}
