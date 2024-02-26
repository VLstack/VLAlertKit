import SwiftUI

struct VLAlertView<V, D>: View where V: View, D: VLAlertData
{
 private let content: V
 @Binding private var data: D?
 @State private var isPresented: Bool = false

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
 public func alert<D: VLAlertData>(with data: Binding<D?>) -> some View
 {
  VLAlertView(content: self, data: data)
 }
}

