import SwiftUI

public enum VLAlertButtonRole: Equatable
{
 case `default`
 case destructive
 case cancel
 
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
