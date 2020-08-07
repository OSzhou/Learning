/*
 Hash Table: A symbol table of generic key-value pairs.
 
 The key must be `Hashable`, which means it can be transformed into a fairly
 unique integer value. The more unique the hash value, the better.
 
 Hash tables use an internal array of buckets to store key-value pairs. The
 hash table's capacity is determined by the number of buckets. This
 implementation has a fixed capacity--it does not resize the array as more
 key-value pairs are inserted.
 
 To insert or locate a particular key-value pair, a hash function transforms the
 key into an array index. An ideal hash function would guarantee that different
 keys map to different indices. In practice, however, this is difficult to
 achieve.
 
 Since different keys can map to the same array index, all hash tables implement
 a collision resolution strategy. This implementation uses a strategy called
 separate chaining, where key-value pairs that hash to the same index are
 "chained together" in a list. For good performance, the capacity of the hash
 table should be sufficiently large so that the lists are small.
 
 A well-sized hash table provides very good average performance. In the
 worst-case, however, all keys map to the same bucket, resulting in a list that
 that requires O(n) time to traverse.
 
 Average Worst-Case
 Space:   O(n)     O(n)
 Search:  O(1)     O(n)
 Insert:  O(1)     O(n)
 Delete:  O(1)     O(n)
 */
public struct HashTable2<Key: Hashable, Value> {
    
    private enum State {
        case unused
        case active
        case dummy
    }
    
    private struct Entry {
        var state: State = .unused
        var key: Key?
        var value: Value?
    }
    
    private let Step: Int = 1
    
    private var buckets: [Entry]
    
    /// The number of key-value pairs in the hash table.
    private(set) public var count = 0
    
    /// A Boolean value that indicates whether the hash table is empty.
    public var isEmpty: Bool { return count == 0 }
    
    /**
     Create a hash table with the given capacity.
     */
    public init(capacity: Int) {
        assert(capacity > 0)
        
        buckets = Array<Entry>(repeatElement(Entry(), count: capacity))
    }
    
    /**
     Returns the given key's array index.
     */
    private func index(forKey key: Key) -> Int {
        return abs(key.hashValue % buckets.count)
    }
    
    /**
     Accesses the value associated with
     the given key for reading and writing.
     */
    public subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        set {
            if let value = newValue {
                updateValue(value, forKey: key)
            } else {
                removeValue(forKey: key)
            }
        }
    }
    
    /**
     Updates the value stored in the hash table for the given key,
     or adds a new key-value pair if the key does not exist.
     */
    @discardableResult public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
        
//        if count * 4 > 3 * buckets.count {
//
//            //            let resizeCapacity = count * 2 // Growth rate = used * 2
//            //            let resizeCapacity = count * 3 // Growth rate = used * 3
//            let resizeCapacity = count * 3 + buckets.count / 2 // Growth rate = used * 3 + capacity / 2
//
//            print("count: \(count)  resize: \(resizeCapacity)")
//            resize(resizeCapacity)
//        }
        
        let index = self.index(forKey: key)
        
        var freeslotIndex: Int?
        
        let bucket = buckets[index]
        if bucket.state == .active, bucket.key == key {
            let oldValue = buckets[index].value
            buckets[index].value = value
            return oldValue
        }
        
        // 线性探测
        var i: Int = 0
        while true {
            
            if i > 0 {
                print("线性开始： index:\(index)")
            }
            
            let idx = (index + Step * i) % buckets.count
            
            let bucket = buckets[idx]
            
            if bucket.state == .active, bucket.key == key {
                
                let oldValue = buckets[idx].value
                buckets[idx].value = value
                return oldValue
                
            } else if bucket.state == .dummy, freeslotIndex != nil {
                
                freeslotIndex = idx
                
            } else if bucket.state == .unused {
                
                var entry = Entry()
                entry.state = .active
                entry.key = key
                entry.value = value
                
                if let id = freeslotIndex {
                    buckets[id] = entry
                } else {
                    buckets[idx] = entry
                }
                count += 1
                return nil
            }
            
            i += 1
        }
        
        return nil
    }
    
    private mutating func resize(_ capacity: Int) {
        let oldBuckets = buckets
        buckets = Array<Entry>(repeatElement(Entry(), count: capacity))
        for bucket in oldBuckets {
            if bucket.state != .dummy, bucket.state != .unused {
                self.updateValue(bucket.value!, forKey: bucket.key!)
            }
        }
    }
    
    /**
     Returns the value for the given key.
     */
    public func value(forKey key: Key) -> Value? {
        let index = self.index(forKey: key)
        
        let bucket = buckets[index]
        if bucket.state == .active, bucket.key == key {
            return bucket.value
        }
        
        // 线性探测
        var i: Int = 0
        while true {
            let idx = (index + Step * i) % buckets.count
            
            let bucket = buckets[idx]
            
            if bucket.state == .active, bucket.key == key {
                
                return bucket.value
                
            } else if bucket.state == .unused {
                
                return nil
            }
            
            i += 1
            
        }
        
        return nil
    }
    
    /**
     Removes the given key and its
     associated value from the hash table.
     */
    @discardableResult public mutating func removeValue(forKey key: Key) -> Value? {
        let index = self.index(forKey: key)
        
        let bucket = buckets[index]
        if bucket.state == .active, bucket.key == key {
            buckets[index].state = .dummy
            count -= 1
            return bucket.value
        }
        
        // 线性探测
        var i: Int = 0
        while true {
            let idx = (index + Step * i) % buckets.count
            
            let bucket = buckets[idx]
            
            if bucket.state == .active, bucket.key == key {
                
                buckets[idx].state = .dummy
                count -= 1
                return bucket.value
                
            } else if bucket.state == .unused {
                
                return nil
            }
            
            i += 1
            
        }
        
        return nil
    }
    
    /**
     Removes all key-value pairs from the hash table.
     */
    public mutating func removeAll() {
        buckets = Array<Entry>(repeatElement(Entry(), count: buckets.count))
        count = 0
    }
}

extension HashTable2: CustomStringConvertible {
    /// A string that represents the contents of the hash table.
    public var description: String {
        let pairs = buckets.map { e in "\(e.key) = \(e.value)" }
        return pairs.joined(separator: "\n")
    }
}
