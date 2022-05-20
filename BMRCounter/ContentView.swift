//
//  ContentView.swift
//  BMRCounter
//
//  Created by Reza Ramadhan on 28/04/22.
//

import SwiftUI

struct ContentView: View {
    @State var nama: String = ""
    @State var umur = ""
    @State var selectedGender : Gender = .male
    @State var gender = ["Male", "Female"]
    @State var berat = ""
    @State var tinggi = ""
    @State var result = ""
    @State var showingAlert = false
//    @State var hasil=""
//    @State var bmi:

    enum Gender: String, CaseIterable, Identifiable {
        case male, female
        var id: Self { self }
    }
    
    



    var body: some View{
        NavigationView{
            
            Form{
                Section(header: Text("General Information")){
                    TextField("Nama", text: $nama)
                    TextField("Umur", text: $umur)
                        .keyboardType(.numberPad)
                    Picker("Select Gender", selection: $selectedGender) {
                        Text("Male").tag(Gender.male)
                        Text("Female").tag(Gender.female)
                    }
                }

                Section(header: Text("Body Measuremnet")){
                    HStack{
                        TextField("Berat Badan", text: $berat)
                            .keyboardType(.numberPad)
                        Text("kg")
                    }
                    HStack{
                        TextField("Tinggi Badan", text: $tinggi)
                            .keyboardType(.numberPad)
                        Text("cm")
                    }

                }
                


                
                Button(action: {
                    result = Calculate()
                }) {
                    HStack {
                        Spacer()
                        Text("Calculate")
                        Spacer()
                    }
                }
                .disabled(berat.isEmpty || tinggi.isEmpty || nama.isEmpty || umur.isEmpty )
                
                
                Button(action: Reset) {
                    HStack {
                        Spacer()
                        Text("Reset")
                        Spacer()
                    }
                    .foregroundColor(.red)
                    
                }
                .disabled(result.isEmpty)
                
                if result != "" {
                    Section(header: Text("Result")){
                        Text(result)
                    }
                }
                
//                if result != ""{
//                    Reset() == .visible
//                } else {
//                    hidden()
//                }
//                Button(action: Reset) {
//                    Text("Reset!" ).font(.title).padding()
//                    .frame(width: 160, height: 55, alignment:    .center)
//                    .background(Color.green)
//                    .foregroundColor(.white)
//                    .clipShape(Capsule())
//                }

                
            }
            .navigationBarTitle("BMR Hiking Calculator").dynamicTypeSize(..<DynamicTypeSize.accessibility1)
            .navigationBarItems(trailing:
                    Button(action: {
                        showingAlert = true
                    }) {
                        Image(systemName: "info.circle")
                                            .imageScale(.large)
                    }
                .alert("What is BMR?", isPresented: $showingAlert, actions: {
                    Button("OK") {}
                  }, message: {
                    Text("Basal metabolic rate (BMR) adalah kalori yang tubuh Anda perlukan untuk melakukan aktivitas dasar tubuh. Aktivitas tersebut mencakup memompa jantung, mencerna makanan, bernapas, memperbaiki sel tubuh, hingga membuang racun dalam tubuh.")
                  })
            )
            
            

        }
        
        
    }
    func Calculate() -> String{
        let age = Float(umur) ?? 0
        let weight = Float(berat) ?? 0
        let height = Float(tinggi) ?? 0

        if(selectedGender == Gender.male){
            let hasil = 66.5 + (13.7 * weight) + (5 * height) - (6.8 * age)
            let bmrlaki = (125/100) * hasil
            return "\(nama), your result of BMR is \(bmrlaki)"
        } else if (selectedGender == Gender.female){
            let hasil = 655 + (9.6 * weight) + (1.8 * height) - (4.7 * age)
            let bmrperempuan = (125/100) * hasil
            return "\(nama), your result of BMR is \(bmrperempuan)";
        }
        
        return ""
    }
    
    func Reset() {
            nama = ""
            umur = ""
            berat = ""
            tinggi = ""
            result = ""
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

