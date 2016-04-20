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

/**
 Catches throw errors, converts them to `NSError` values, and throws the converted errors.
 
 Errors are caught in this order:
 
  1. By attempting to convert to the `NSErrorRepresentable` protocol.
  2. By attempting to convert to the `NSErrorConvertible` protocol.
  3. By forcing conversion to `NSError`.

 - parameter function: A throwing function.

 - throws: `NSError` objects.
 */
public func rethrowNSError<Value>(@autoclosure function: () throws -> Value) throws -> Value
{
    do
    {
        return try function()
    }
    catch let error as NSErrorRepresentable
    {
        throw error.NSError
    }
    catch let error as NSErrorConvertible
    {
        throw error.NSError
    }
    catch let error as NSError
    {
        throw error
    }
}
