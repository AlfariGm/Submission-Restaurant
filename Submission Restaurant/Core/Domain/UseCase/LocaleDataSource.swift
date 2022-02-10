//
//  LocaleDataSource.swift
//  TheMealsApp
//
//  Created by Galfari on 07/01/22.
//

import Foundation
import RealmSwift
import RxSwift
import Combine

protocol LocaleDataSourceProtocol: class {
    
    func getCategories() -> Observable<[CategoryEntity]>
    func addCategories(from categories: [CategoryEntity]) -> Observable<Bool>
    
//    func getCategories() -> AnyPublisher<[CategoryEntity], Error>
    
//      func addCategories(from categories: [CategoryEntity]) -> AnyPublisher<Bool, Error>
}

final class LocaleDataSource: NSObject {
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    static let sharedInstance: (Realm?) -> LocaleDataSource = {
        realmDatabase in return LocaleDataSource(realm: realmDatabase)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
//    func getCategories() -> AnyPublisher<[CategoryEntity], Error> {
//        return Future<[CategoryEntity], Error> { completion in
//          if let realm = self.realm {
//            let categories: Results<CategoryEntity> = {
//              realm.objects(CategoryEntity.self)
//                .sorted(byKeyPath: "title", ascending: true)
//            }()
//            completion(.success(categories.toArray(ofType: CategoryEntity.self)))
//          } else {
//            completion(.failure(DatabaseError.invalidInstance))
//          }
//        }.eraseToAnyPublisher()
//      }
//
//      func addCategories(
//        from categories: [CategoryEntity]
//      ) -> AnyPublisher<Bool, Error> {
//        return Future<Bool, Error> { completion in
//          if let realm = self.realm {
//            do {
//              try realm.write {
//                for category in categories {
//                  realm.add(category, update: .all)
//                }
//                completion(.success(true))
//              }
//            } catch {
//              completion(.failure(DatabaseError.requestFailed))
//            }
//          } else {
//            completion(.failure(DatabaseError.invalidInstance))
//          }
//        }.eraseToAnyPublisher()
//      }
    
    
    func getCategories() -> Observable<[CategoryEntity]> {
        return Observable<[CategoryEntity]>.create { observer in
            if let realm = self.realm {
                let categories: Results<CategoryEntity> = {
                    realm.objects(CategoryEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                observer.onNext(categories.toArray(ofType: CategoryEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }

    func addCategories(from categories: [CategoryEntity]) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for category in categories {
                            realm.add(category, update: .all)
                        }
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}