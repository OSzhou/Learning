public class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    weak var previous: LinkedListNode?

    public init(value: T) {
        self.value = value
    }
}

public class LinkedList<T> {
    public typealias Node = LinkedListNode<T>

    private var head: Node?

    private var tail: Node?
    private var nodeCount: Int = 0

    public var isEmpty: Bool {
        return head == nil
    }

    public var first: Node? {
        return head
    }

    public var last: Node? {
        guard var node = head else {
            return nil
        }

        while let next = node.next {
            node = next
        }

        return node

//        return tail
    }

    public func append(_ value: T) {
        let newNode = Node(value: value)
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }

        nodeCount += 1
    }

    public var count: Int {
        guard var node = head else {
            return 0
        }

        var count = 1
        while let nextNode = node.next {
            count += 1
            node = nextNode
        }

        return count

//        return nodeCount
    }

    public func node(atIndex index: Int) -> Node? {
        if index == 0 {
            return head
        } else {
            guard var node = head else {
                return nil
            }

            var count = 1
            while let lastNode = node.next {
                if count == index {
                    return lastNode
                }
                count += 1
                node = lastNode
            }
            return nil
        }
    }

    public subscript(index: Int) -> T? {
        let node = self.node(atIndex: index)
        return node?.value
    }

    public func insert(_ value: T, atIndex index: Int) -> Bool {
        let newNode = Node(value: value)
        if index == 0 {
            head?.previous = newNode
            newNode.next = head

            nodeCount += 1
            tail = newNode

            head = newNode
            return true
        } else {

            if let prev = self.node(atIndex: index - 1) {

                let next = prev.next
                next?.previous = newNode
                newNode.next = next
                newNode.previous = prev

                if next == nil {
                    tail = newNode
                }

                prev.next = newNode

                nodeCount += 1
                return true
            } else {
                return false
            }
        }
    }

    public func removeAll() {
        head = nil

        tail = nil

        nodeCount = 0
    }

    public func remove(node: Node) -> T {
        let prev = node.previous
        let next = node.next

        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }

        if next == nil {
            tail = prev
        }

        next?.previous = prev

        node.previous = nil
        node.next = nil
        nodeCount -= 1
        return node.value
    }

    public func removeLast() -> T? {
        if let lst = self.last {

            return remove(node: lst)
        }
        return nil
    }

    public func removeAt(_ index: Int) -> T? {
        let node = self.node(atIndex: index)
        if let nd = node {
            return self.remove(node: nd)
        } else {
            return nil
        }
    }

    public func reverse() {
        var node = head
        tail = node
        while let currentNode = node {
            node = currentNode.next

            let tmp = currentNode.previous
            currentNode.previous = currentNode.next
            currentNode.next = tmp
//            swap(&currentNode.previous, &currentNode.next)
            head = currentNode
        }
    }

    public func reverseNotUseTail() {
        var node = head
        var next = node?.next
        var last: Node?
        while next != nil {
            next = node?.next
            node?.next = last

            node?.previous = next //单向链表注释此行，双向链表需要加上，否则上面的删除逻辑会有异常

            last = node
            head = node

            node = next
        }
    }

    public func map<U>(transform: (T) -> U) -> LinkedList<U> {
        let result = LinkedList<U>()

//        var node = head
//        while node != nil {
//            result.append(transform(node!.value))
//            node = node!.next
//        }


        var node = head
        var last: LinkedListNode<U>?
        while node != nil {
            if result.head == nil {
                result.head = last
            }

            let tmp = LinkedListNode(value: transform(node!.value))
            last?.next = tmp
            last = tmp

            node = node!.next
        }

        return result
    }

    public func filter(predicate: (T) -> Bool) -> LinkedList<T> {
        let result = LinkedList<T>()
//        var node = head
//        while node != nil {
//            if predicate(node!.value) {
//                result.append(node!.value)
//            }
//            node = node?.next
//        }


        var node = head
        var last: LinkedListNode<T>?
        while node != nil {
            if predicate(node!.value) {
                if result.head == nil {
                    result.head = last
                }

                let tmp = LinkedListNode(value: node!.value)
                last?.next = tmp

                last = tmp
            }
            node = node?.next
        }

        return result
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        var s = "["

        var node = head
        while node != nil {
            s += "\(node!.value)"
            node = node!.next

            if node != nil {
                s += ", "
            }
        }
        return s + "]"
    }
}

func test() {
    let list = LinkedList<String>()

    list.reverseNotUseTail()
    print(list)

    list.insert("hello", atIndex: 0)
    print(list)
    list.reverseNotUseTail()
    print(list)

    list.insert("world", atIndex: 1)
    print(list)
    list.reverseNotUseTail()
    print(list)

    list.insert("1", atIndex: 2)
    print(list[0])
    print(list[1])
    print(list[2])
    print(list.first?.value)
    print(list)
    print(list.filter(predicate: { (str) -> Bool in
        str.count > 1
    }))
    print(list.map(transform: { (str) -> Int in
        return str.count
    }))
    //        list.reverse()
    //        print(list)
    list.reverseNotUseTail()
    print(list)

    print(list.remove(node: list.last!))
    print(list.remove(node: list.last!))
    print(list.remove(node: list.last!))
    print(list.last?.value)
    print(list)
    //        list.reverse()
    //        print(list)
    list.reverseNotUseTail()
    print(list)

    print(list.insert("0", atIndex: 0))
    print(list.insert("1", atIndex: 0))
    print(list.last?.value)
    list.append("2")
    print(list.last?.value)
    print(list)
    list.reverse()
    print(list)
    list.reverseNotUseTail()
    print(list)
    print(list.filter(predicate: { (str) -> Bool in
        (Int(str) ?? 0) > 0
    }))
    print(list.map(transform: { (str) -> Int in
        return str.count
    }))

    print(list.remove(node: list.first!))
    print(list.last?.value)
    print(list.first?.value)
    print(list.count)
    print(list[0])
    print(list[1])
    print(list.removeAt(0))
    print(list.removeLast())
    print(list)
    list.reverse()
    print(list)
    list.reverseNotUseTail()
    print(list)

    print("Solution54 spiralOrder success")
}

test()