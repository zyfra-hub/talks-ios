//
//  WeakKeyDictionary.swift
//  WeakDictionary-iOS
//
//  Created by Nicholas Cross on 2/1/19.
//  Copyright © 2019 Nicholas Cross. All rights reserved.
//

import Foundation

public struct WeakKeyDictionary<Key: AnyObject & Hashable, Value: AnyObject> {
    private var storage: WeakDictionary<WeakDictionaryKey<Key, Value>, Value>
    private let valuesRetainedByKey: Bool

    public init(valuesRetainedByKey: Bool = false) {
        self.init(
            storage: WeakDictionary<WeakDictionaryKey<Key, Value>, Value>(),
            valuesRetainedByKey: valuesRetainedByKey
        )
    }

    public init(dictionary: [Key: Value], valuesRetainedByKey: Bool = false) {
        var newStorage = WeakDictionary<WeakDictionaryKey<Key, Value>, Value>()

        dictionary.forEach { key, value in
            var keyRef: WeakDictionaryKey<Key, Value>!

            if valuesRetainedByKey {
                keyRef = WeakDictionaryKey<Key, Value>(key: key, value: value)
            } else {
                keyRef = WeakDictionaryKey<Key, Value>(key: key)
            }

            newStorage[keyRef] = value
        }

        self.init(storage: newStorage, valuesRetainedByKey: valuesRetainedByKey)
    }

    private init(storage: WeakDictionary<WeakDictionaryKey<Key, Value>, Value>, valuesRetainedByKey: Bool = false) {
        self.storage = storage
        self.valuesRetainedByKey = valuesRetainedByKey
    }

    public mutating func reap() {
        storage = weakKeyDictionary().storage
    }

    public func weakDictionary() -> WeakDictionary<Key, Value> {
        dictionary().weakDictionary()
    }

    public func weakKeyDictionary() -> WeakKeyDictionary<Key, Value> {
        self[startIndex..<endIndex]
    }

    public func dictionary() -> [Key: Value] {
        var newStorage = [Key: Value]()

        storage.forEach { key, value in
            if let retainedKey = key.key, let retainedValue = value.value {
                newStorage[retainedKey] = retainedValue
            }
        }

        return newStorage
    }
}

extension WeakKeyDictionary: Collection {
    public typealias Index = DictionaryIndex<WeakDictionaryKey<Key, Value>, WeakDictionaryReference<Value>>

    public var startIndex: Index {
        storage.startIndex
    }

    public var endIndex: Index {
        storage.endIndex
    }

    public func index(after index: Index) -> Index {
        storage.index(after: index)
    }

    public subscript(position: Index) -> (WeakDictionaryKey<Key, Value>, WeakDictionaryReference<Value>) {
        return storage[position]
    }

    public subscript(key: Key) -> Value? {
        get {
            storage[WeakDictionaryKey<Key, Value>(key: key)]
        }

        set {
            let retainedValue = valuesRetainedByKey ? newValue : nil
            let weakKey = WeakDictionaryKey<Key, Value>(key: key, value: retainedValue)
            storage[weakKey] = newValue
        }
    }

    public subscript(bounds: Range<Index>) -> WeakKeyDictionary<Key, Value> {
        let subStorage = storage[bounds.lowerBound..<bounds.upperBound]
        var newStorage = WeakDictionary<WeakDictionaryKey<Key, Value>, Value>()

        subStorage.filter { key, value in key.key != nil && value.value != nil }
            .forEach { key, value in newStorage[key] = value.value }

        return WeakKeyDictionary<Key, Value>(storage: newStorage)
    }
}

public extension WeakDictionary where Key: AnyObject {
    func weakKeyDictionary(valuesRetainedByKey: Bool = false) -> WeakKeyDictionary<Key, Value> {
        WeakKeyDictionary<Key, Value>(dictionary: dictionary(), valuesRetainedByKey: valuesRetainedByKey)
    }
}

public extension Dictionary where Key: AnyObject, Value: AnyObject {
    func weakKeyDictionary(valuesRetainedByKey: Bool = false) -> WeakKeyDictionary<Key, Value> {
        WeakKeyDictionary<Key, Value>(dictionary: self, valuesRetainedByKey: valuesRetainedByKey)
    }
}
