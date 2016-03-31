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

// MARK: - User Info Representable
public protocol UserInfoRepresentable
{
    // MARK: - Text Content

    /// A value for `NSLocalizedDescriptionKey`.
    ///
    /// This property's default implementation returns `nil`.
    var localizedDescription: String? { get }

    /// A value for `NSLocalizedRecoveryOptionsErrorKey`.
    ///
    /// This property's default implementation returns `nil`.
    var localizedRecoveryOptions: [String]? { get }

    /// A value for `NSLocalizedRecoverySuggestionErrorKey`.
    ///
    /// This property's default implementation returns `nil`.
    var localizedRecoverySuggestion: String? { get }

    /// A value for `NSLocalizedFailureReasonErrorKey`.
    ///
    /// This property's default implementation returns `nil`.
    var localizedFailureReason: String? { get }

    // MARK: - Underlying Error

    /// A value for `NSUnderlyingErrorKey`.
    ///
    /// This property's default implementation returns `nil`.
    var underlyingError: NSError? { get }

    // MARK: - Additional User Info Values

    /// Additional user info keys and values to apply.
    ///
    /// These are applied after the built-in properties, so any repeated keys will be overridden.
    ///
    /// This property's default implementation returns an empty dictionary.
    var additionalUserInfoValues: [String:AnyObject] { get }
}

extension UserInfoRepresentable
{
    // MARK: - Text Content
    public var localizedDescription: String? { return nil }
    public var localizedRecoveryOptions: [String]? { return nil }
    public var localizedRecoverySuggestion: String? { return nil }
    public var localizedFailureReason: String? { return nil }

    // MARK: - Underlying Error
    public var underlyingError: NSError? { return nil }

    // MARK: - Additional User Info Values
    public var additionalUserInfoValues: [String:AnyObject] { return [:] }
}

extension NSErrorRepresentable where Self: UserInfoRepresentable
{
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
