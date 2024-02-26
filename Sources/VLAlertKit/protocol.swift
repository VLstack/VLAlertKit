import Foundation
import SwiftUI

public protocol VLAlertData: Equatable
{
 var title: LocalizedStringKey { get }
 var message: LocalizedStringKey? { get }
 var buttons: [ VLAlertButton ] { get }
}

extension VLAlertData
{
 fileprivate var requireCancelButton: Bool
 {
  let destructive = buttons.contains { $0.role == .destructive }
  let cancel = buttons.contains { $0.role == .cancel }
  
  return destructive && !cancel
 }
 
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
    ForEach(buttons.indices, id: \.self)
    {
     index in
     let button = buttons[index]
     Button(button.label,
            role: button.role.system,
            action:
            {
             button.action()
             dismiss()
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
