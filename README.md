# TEA

`Swift`语言`TEA`加密、解密

## Usage

### Initialization

```swift

	/**
     初始化
     
     - parameter    number:     加解密位数 0~7 原型 (1<<number)
     - parameter    key:        加解密KEY
     */
    public init(_ number: UInt32, key: (UInt32,UInt32,UInt32,UInt32))
    
    // MARK: Data Crypt
    
    /**
     加密
     
     - parameter    data:   数据
     */
    public func encrypt(_ data: Data) -> Data 
    
    /**
     解密
     
     - parameter    data:   数据
     */
    public func decrypt(_ data: Data) -> Data 
        
    // MARK: File Crypt
    
    /**
     加密
     
     - parameter    filePath:       文件路径
     - parameter    outFilePath:    输出加密文件路径
     */
    public func encrypt(_ filePath: String, outFilePath: String)
    
    /**
     解密
     
     - parameter    filePath:       文件路径
     - parameter    outFilePath:    输出解密文件路径
     */
    public func decrypt(_ filePath: String, outFilePath: String)
```

```swift
let tea = TEA.init(5, key: (arc4random(), arc4random(), arc4random(), arc4random()))

if let data = "1234567890".data(using: .utf8) {
    
    let enData = tea.encrypt(data)
    print("加密:")
    print((String.init(data: enData, encoding: .utf8) ?? ""))
    print(data.base64EncodedString())
    let deData = tea.decrypt(enData)
    print("解密:")
    print(String.init(data: deData, encoding: .utf8) ?? "")
}

if let url = URL.init(string: "http://baidu.com") {
    
    do {
        let data = try Data.init(contentsOf: url)
        let path = NSHomeDirectory() + "/Documents/test"
        try data.write(to: URL.init(fileURLWithPath: path))
        print("原数据:")
        print(String.init(data: data, encoding: .utf8) ?? "")
        print("加密:")
        tea.encrypt(path, outFilePath: path + "EN")
        let enData = try Data.init(contentsOf: URL.init(fileURLWithPath: path + "EN"))
        print((String.init(data: enData, encoding: .utf8) ?? ""))
        print(enData.base64EncodedString())
        print("解密:")
        tea.decrypt(path + "EN", outFilePath: path + "DE")
        let deString = try String.init(contentsOfFile: path + "DE")
        print(deString)
    } catch {
        print(error)
    }
}
```
