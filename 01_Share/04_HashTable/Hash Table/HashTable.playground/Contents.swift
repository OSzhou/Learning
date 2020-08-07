//: Playground - noun: a place where people can play

// Playing with hash values

"firstName".hashValue
abs("firstName".hashValue) % 5

"lastName".hashValue
abs("lastName".hashValue) % 5

"hobbies".hashValue
abs("hobbies".hashValue) % 5

"hobbi".hashValue
abs("hobbi".hashValue) % 5

// Playing with the hash table

var hashTable1 = HashTable2<String, String>(capacity: 5)

hashTable1["firstName"] = "Steve"
hashTable1["lastName"] = "Jobs"
hashTable1["hobbies"] = "Programming Swift"
hashTable1["hobbi"] = "sss"
//
print(hashTable1)
////print(hashTable1.debugDescription)
//
//hashTable1["firstName1"] = "Steve"
//hashTable1["lastName1"] = "Jobs"
//hashTable1["hobbies1"] = "Programming Swift"
//
//print(hashTable1)
////print(hashTable1.debugDescription)
////
////hashTable1["firstName2"] = "Steve"
////hashTable1["lastName2"] = "Jobs"
////hashTable1["hobbies2"] = "Programming Swift"
////
////print(hashTable1)
//////print(hashTable1.debugDescription)
////
////hashTable1["firstName3"] = "Steve"
////hashTable1["lastName3"] = "Jobs"
////hashTable1["hobbies3"] = "Programming Swift"
////
////print(hashTable1)
//////print(hashTable1.debugDescription)
////
////hashTable1["firstName4"] = "Steve"
////hashTable1["lastName4"] = "Jobs"
////hashTable1["hobbies4"] = "Programming Swift"
////
////print(hashTable1)
//////print(hashTable1.debugDescription)
////
////hashTable1["firstName5"] = "Steve"
////hashTable1["lastName5"] = "Jobs"
////hashTable1["hobbies5"] = "Programming Swift"
////
////print(hashTable1)
//////print(hashTable1.debugDescription)
////
////hashTable1["firstName6"] = "Steve"
////hashTable1["lastName6"] = "Jobs"
////hashTable1["hobbies6"] = "Programming Swift"
////
////print(hashTable1)
//////print(hashTable1.debugDescription)
////
//////assert(hashTable1["firstName6"] == "Steve")
//////assert(hashTable1["lastName6"] == "Jobs")
//////assert(hashTable1["hobbies6"] == "Programming Swift")
//////assert(hashTable1["firstName5"] == "Steve")
//////assert(hashTable1["lastName5"] == "Jobs")
//////assert(hashTable1["hobbies5"] == "Programming Swift")
//////assert(hashTable1["hobbi"] == nil)
////
//////print("\n\n\n")
//////print(hashTable1["hobbies6"])
//////print(hashTable1["lastName1"])
//////print(hashTable1["firstName4"])
//////
//////
//////hashTable1["hobbies6"] = "======="
//////print(hashTable1["hobbies6"])
//////hashTable1["hobbies6"] = "---------"
//////print(hashTable1["hobbies6"])
