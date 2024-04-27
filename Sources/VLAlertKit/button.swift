import Foundation
import SwiftUI

/// Represents a button for use in alerts.
public struct VLAlertButton: Identifiable
{
 public let id: String = UUID().uuidString

 /// The label for the button, localized for internationalization support.
 public let label: LocalizedStringKey

 /// The role of the button in the alert.
 public let role: VLAlertButtonRole

 /// The action to perform when the button is tapped.
 public let action: () -> Void
 
 /// Initializes an alert button with the specified label, role, and action.
 ///
 /// - Parameters:
 ///   - label: The label for the button, localized for internationalization support.
 ///   - role: The role of the button in the alert. Defaults to `.default`.
 ///   - action: The action to perform when the button is tapped. Defaults to an empty closure.
 public init(_ label: LocalizedStringKey,
             role: VLAlertButtonRole = .default,
             action: @escaping @Sendable () async -> Void = {})
 {
  self.label = label
  self.role = role
  self.action = { Task { await action() } }
 }

 /// Converts the button into a SwiftUI system button for use in SwiftUI views.
 ///
 /// - Returns: The SwiftUI system button corresponding to the button's role and label.
 var system: Alert.Button
 {
  switch role
  {
  case .`default`: return .default(Text(label), action: action)
   case .cancel: return .cancel(Text(label), action: action)
   case .destructive: return .destructive(Text(label), action: action)
  }
 }
}
