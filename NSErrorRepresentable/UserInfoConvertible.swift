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

// MARK: - User Info Convertible

/// A protocol for types that can be converted to a user info value.
///
/// All properties of this protocol have default implementations, which return empty values.
public protocol UserInfoConvertible
{
    // MARK: - Text Content

    /// A value for `NSLocalizedDescriptionKey`.
    var localizedDescription: String? { get }

    /// A value for `NSLocalizedRecoveryOptionsErrorKey`.
    var localizedRecoveryOptions: [String]? { get }

    /// A value for `NSLocalizedRecoverySuggestionErrorKey`.
    var localizedRecoverySuggestion: String? { get }

    /// A value for `NSLocalizedFailureReasonErrorKey`.
    var localizedFailureReason: String? { get }

    // MARK: - Underlying Error

    /// A value for `NSUnderlyingErrorKey`.
    var underlyingError: NSError? { get }

    // MARK: - Additional User Info Values

    /// Additional user info keys and values to apply.
    ///
    /// These are applied after the built-in properties, so any repeated keys will be overridden.
    var additionalUserInfoValues: [String:AnyObject] { get }
}

extension UserInfoConvertible
{
    // MARK: - Text Content

    /// This property's default implementation returns `nil`.
    public var localizedDescription: String? { return nil }

    /// This property's default implementation returns `nil`.
    public var localizedRecoveryOptions: [String]? { return nil }

    /// This property's default implementation returns `nil`.
    public var localizedRecoverySuggestion: String? { return nil }

    /// This property's default implementation returns `nil`.
    public var localizedFailureReason: String? { return nil }

    // MARK: - Underlying Error

    /// This property's default implementation returns `nil`.
    public var underlyingError: NSError? { return nil }

    // MARK: - Additional User Info Values

    /// This property's default implementation returns an empty dictionary.
    public var additionalUserInfoValues: [String:AnyObject] { return [:] }
}

extension NSErrorConvertible where Self: UserInfoConvertible
{
    // MARK: - User Info

    /// A user info representation of the value.
    public var userInfo: [String:AnyObject]?
    {
        var userInfo = [String:AnyObject]()

        userInfo[NSLocalizedDescriptionKey] = localizedDescription
        userInfo[NSLocalizedRecoveryOptionsErrorKey] = localizedRecoveryOptions
        userInfo[NSLocalizedRecoverySuggestionErrorKey] = localizedRecoverySuggestion
        userInfo[NSLocalizedFailureReasonErrorKey] = localizedFailureReason
        userInfo[NSUnderlyingErrorKey] = underlyingError

        additionalUserInfoValues.forEach({ key, value in userInfo[key] = value })

        return userInfo
    }
}
