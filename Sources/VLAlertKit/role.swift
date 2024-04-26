import SwiftUI

/// Available roles for alert buttons
@frozen public enum VLAlertButtonRole: Equatable, Sendable
{
 /// The default role for an alert button.
 case `default`

 /// The destructive role for an alert button, typically indicating a destructive action.
 case destructive

 /// The cancel role for an alert button, indicating a cancel or dismiss action.
 case cancel
 
 /// Converts the alert button role into a corresponding SwiftUI system role.
 ///
 /// - Returns: The corresponding SwiftUI system role or `nil` if no matching role is found.
 var system: ButtonRole?
 {
  switch self
  {
   case .`default`: return .none
   case .cancel: return .cancel
   case .destructive: return .destructive
  }
 }
}
