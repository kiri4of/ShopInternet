//
//  DataFetching.swift
//  InternetShop
//
//  Created by Kiri4of on 11.12.2022.
//

import UIKit

//func getFetch(imageView: UIImageView, menuItem: Menu?) {
//    let URLImage = URL(string: (menuItem?.imageURL)!)
//    let queue = DispatchQueue.global(qos: .userInitiated)
//    queue.async {
//        guard let url = URLImage, let data = try? Data(contentsOf: url) else {return}
//        DispatchQueue.main.async {
//            imageView.image = UIImage(data: data)
//        }
//    }
//}

func getFetchData(urlString: String, complition: @escaping (Result<Data,Error>) -> Void) {
         guard let url = URL(string: urlString) else {return}
         
         let urlSessionDataTask = URLSession.shared.dataTask(with: url) { data, response, error in
             guard let data else {
                 complition(.failure(error!))
                 return
             }
             complition(.success(data))
         }
    urlSessionDataTask.resume()
}


//func getFetchDataFromURLs(URLs: [Menu], complition: @escaping (Result<[Data],Error>) -> Void) {
//
//    var dataArray = [Data]()
//
//    for i in URLs {
//        guard let url = URL(string: i.imageURL!) else {return}
//        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data else {return}
//            dataArray.append(data)
//        }
//        dataTask.resume()
//    }
//    sleep(1) //тут короче дата долго идет данные и поэтому слипаем
//    complition(.success(dataArray))
//
//}




