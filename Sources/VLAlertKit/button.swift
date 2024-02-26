import SwiftUI

public struct VLAlertButton
{
 public let label: LocalizedStringKey
 public let role: VLAlertButtonRole
 public let action: () -> Void
 
 public init(_ label: LocalizedStringKey,
             role: VLAlertButtonRole = .default,
             action: @escaping () -> Void = {})
 {
  self.label = label
  self.role = role
  self.action = action
 }

 var system: Alert.Button
 {
  let button: Alert.Button
        
  switch role
  {
   case .`default`: button = .default(Text(label), action: action)
   case .cancel: button = .cancel(Text(label), action: action)
   case .destructive: button = .destructive(Text(label), action: action)
  }
        
  return button
 }
}
