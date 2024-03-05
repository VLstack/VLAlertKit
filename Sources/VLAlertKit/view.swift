import SwiftUI

/// A view that presents an alert based on the provided data conforming to `VLAlertData`.
struct VLAlertView<V, D>: View where V: View, D: VLAlertData
{
 private let content: V
 @Binding private var data: D?
 @State private var isPresented: Bool = false

 /// Initializes an alert view with the specified content and alert data binding.
 ///
 /// - Parameters:
 ///   - content: The content of the alert view.
 ///   - data: A binding to the alert
 init(content: V,
      data: Binding<D?>)
 {
  self.content = content
  self._data = data
 }

 var body: some View
 {
  content
  .onChange(of: data)
  {
   if    data != nil
      && isPresented == false
   {
    isPresented = true
   }
  }
  .alert(data?.title ?? "",
         isPresented: $isPresented,
         actions:
         {
          if let data
          {
           data.content(dismiss: { self.data = nil  })
          }
         },
         message: { Text(data?.message ?? "") })
 }
}

extension View
{
 /// Presents an alert based on the provided alert data binding.
 ///
 /// - Parameter data: A binding to the alert data.
 /// - Returns: A view presenting an alert based on the provided data.
 public func alert<D: VLAlertData>(with data: Binding<D?>) -> some View
 {
  VLAlertView(content: self, data: data)
 }
}

