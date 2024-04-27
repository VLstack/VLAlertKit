import Foundation
import SwiftUI

/// A protocol representing data for displaying an alert in SwiftUI.
public protocol VLAlertData: Equatable, Sendable
{
 /// The title of the alert, localized for internationalization support.
 var title: LocalizedStringKey { get }

 /// The message body of the alert, localized for internationalization support.
 var message: LocalizedStringKey? { get }

 /// The buttons to display in the alert.
 var buttons: [ VLAlertButton ] { get }
}

extension VLAlertData
{
 /// Determines whether the alert requires a cancel button based on its buttons configuration.
 fileprivate var requireCancelButton: Bool
 {
  let destructive = buttons.contains { $0.role == .destructive }
  let cancel = buttons.contains { $0.role == .cancel }
  
  return destructive && !cancel
 }
 
 /// Generates the content of the alert.
 ///
 /// - Parameter dismiss: A closure to dismiss the alert.
 /// - Returns: A SwiftUI view representing the content of the alert.
 @ViewBuilder
 func content(dismiss: @escaping () -> Void) -> some View
 {
  if buttons.isEmpty
  {
   Button("OK", action: dismiss)
  }
  else
  {
   Group
   {
    ForEach(buttons, id: \.id)
    {
     button in
     Button(button.label,
            role: button.role.system,
            action:
            {
             dismiss()
             button.action()
            })
    }
             
    if requireCancelButton
    {
     Button("Cancel", role: .cancel, action: dismiss)
    }
   }
  }
 }
}
