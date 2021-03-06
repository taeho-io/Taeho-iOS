// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: note/note.proto
//
// For information on using the generated types, please see the documenation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

enum Note_BodyType: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case text // = 0
  case html // = 1
  case markdown // = 2
  case UNRECOGNIZED(Int)

  init() {
    self = .text
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .text
    case 1: self = .html
    case 2: self = .markdown
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .text: return 0
    case .html: return 1
    case .markdown: return 2
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Note_BodyType: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Note_BodyType] = [
    .text,
    .html,
    .markdown,
  ]
}

#endif  // swift(>=4.2)

struct Note_CreateRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var noteID: String {
    get {return _storage._noteID}
    set {_uniqueStorage()._noteID = newValue}
  }

  var createdBy: Int64 {
    get {return _storage._createdBy}
    set {_uniqueStorage()._createdBy = newValue}
  }

  var bodyType: Note_BodyType {
    get {return _storage._bodyType}
    set {_uniqueStorage()._bodyType = newValue}
  }

  var title: String {
    get {return _storage._title}
    set {_uniqueStorage()._title = newValue}
  }

  var body: String {
    get {return _storage._body}
    set {_uniqueStorage()._body = newValue}
  }

  var createdAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _storage._createdAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_uniqueStorage()._createdAt = newValue}
  }
  /// Returns true if `createdAt` has been explicitly set.
  var hasCreatedAt: Bool {return _storage._createdAt != nil}
  /// Clears the value of `createdAt`. Subsequent reads from it will return its default value.
  mutating func clearCreatedAt() {_uniqueStorage()._createdAt = nil}

  var updatedAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _storage._updatedAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_uniqueStorage()._updatedAt = newValue}
  }
  /// Returns true if `updatedAt` has been explicitly set.
  var hasUpdatedAt: Bool {return _storage._updatedAt != nil}
  /// Clears the value of `updatedAt`. Subsequent reads from it will return its default value.
  mutating func clearUpdatedAt() {_uniqueStorage()._updatedAt = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct Note_CreateResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Note_GetRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var noteID: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Note_GetResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var noteID: String {
    get {return _storage._noteID}
    set {_uniqueStorage()._noteID = newValue}
  }

  var bodyType: Note_BodyType {
    get {return _storage._bodyType}
    set {_uniqueStorage()._bodyType = newValue}
  }

  var createdBy: Int64 {
    get {return _storage._createdBy}
    set {_uniqueStorage()._createdBy = newValue}
  }

  var title: String {
    get {return _storage._title}
    set {_uniqueStorage()._title = newValue}
  }

  var body: String {
    get {return _storage._body}
    set {_uniqueStorage()._body = newValue}
  }

  var createdAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _storage._createdAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_uniqueStorage()._createdAt = newValue}
  }
  /// Returns true if `createdAt` has been explicitly set.
  var hasCreatedAt: Bool {return _storage._createdAt != nil}
  /// Clears the value of `createdAt`. Subsequent reads from it will return its default value.
  mutating func clearCreatedAt() {_uniqueStorage()._createdAt = nil}

  var updatedAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _storage._updatedAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_uniqueStorage()._updatedAt = newValue}
  }
  /// Returns true if `updatedAt` has been explicitly set.
  var hasUpdatedAt: Bool {return _storage._updatedAt != nil}
  /// Clears the value of `updatedAt`. Subsequent reads from it will return its default value.
  mutating func clearUpdatedAt() {_uniqueStorage()._updatedAt = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct Note_NoteMessage {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var noteID: String {
    get {return _storage._noteID}
    set {_uniqueStorage()._noteID = newValue}
  }

  var bodyType: Note_BodyType {
    get {return _storage._bodyType}
    set {_uniqueStorage()._bodyType = newValue}
  }

  var createdBy: Int64 {
    get {return _storage._createdBy}
    set {_uniqueStorage()._createdBy = newValue}
  }

  var title: String {
    get {return _storage._title}
    set {_uniqueStorage()._title = newValue}
  }

  var body: String {
    get {return _storage._body}
    set {_uniqueStorage()._body = newValue}
  }

  var createdAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _storage._createdAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_uniqueStorage()._createdAt = newValue}
  }
  /// Returns true if `createdAt` has been explicitly set.
  var hasCreatedAt: Bool {return _storage._createdAt != nil}
  /// Clears the value of `createdAt`. Subsequent reads from it will return its default value.
  mutating func clearCreatedAt() {_uniqueStorage()._createdAt = nil}

  var updatedAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _storage._updatedAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_uniqueStorage()._updatedAt = newValue}
  }
  /// Returns true if `updatedAt` has been explicitly set.
  var hasUpdatedAt: Bool {return _storage._updatedAt != nil}
  /// Clears the value of `updatedAt`. Subsequent reads from it will return its default value.
  mutating func clearUpdatedAt() {_uniqueStorage()._updatedAt = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct Note_ListRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var offset: Int64 = 0

  var limit: Int64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Note_ListResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var notes: [Note_NoteMessage] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Note_UpdateRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var noteID: String {
    get {return _storage._noteID}
    set {_uniqueStorage()._noteID = newValue}
  }

  var bodyType: Note_BodyType {
    get {return _storage._bodyType}
    set {_uniqueStorage()._bodyType = newValue}
  }

  var title: String {
    get {return _storage._title}
    set {_uniqueStorage()._title = newValue}
  }

  var body: String {
    get {return _storage._body}
    set {_uniqueStorage()._body = newValue}
  }

  var updatedAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _storage._updatedAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_uniqueStorage()._updatedAt = newValue}
  }
  /// Returns true if `updatedAt` has been explicitly set.
  var hasUpdatedAt: Bool {return _storage._updatedAt != nil}
  /// Clears the value of `updatedAt`. Subsequent reads from it will return its default value.
  mutating func clearUpdatedAt() {_uniqueStorage()._updatedAt = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct Note_UpdateResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Note_DeleteRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var noteID: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Note_DeleteResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "note"

extension Note_BodyType: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "TEXT"),
    1: .same(proto: "HTML"),
    2: .same(proto: "MARKDOWN"),
  ]
}

extension Note_CreateRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".CreateRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "note_id"),
    2: .standard(proto: "created_by"),
    3: .standard(proto: "body_type"),
    4: .same(proto: "title"),
    5: .same(proto: "body"),
    6: .standard(proto: "created_at"),
    7: .standard(proto: "updated_at"),
  ]

  fileprivate class _StorageClass {
    var _noteID: String = String()
    var _createdBy: Int64 = 0
    var _bodyType: Note_BodyType = .text
    var _title: String = String()
    var _body: String = String()
    var _createdAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
    var _updatedAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _noteID = source._noteID
      _createdBy = source._createdBy
      _bodyType = source._bodyType
      _title = source._title
      _body = source._body
      _createdAt = source._createdAt
      _updatedAt = source._updatedAt
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularStringField(value: &_storage._noteID)
        case 2: try decoder.decodeSingularInt64Field(value: &_storage._createdBy)
        case 3: try decoder.decodeSingularEnumField(value: &_storage._bodyType)
        case 4: try decoder.decodeSingularStringField(value: &_storage._title)
        case 5: try decoder.decodeSingularStringField(value: &_storage._body)
        case 6: try decoder.decodeSingularMessageField(value: &_storage._createdAt)
        case 7: try decoder.decodeSingularMessageField(value: &_storage._updatedAt)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if !_storage._noteID.isEmpty {
        try visitor.visitSingularStringField(value: _storage._noteID, fieldNumber: 1)
      }
      if _storage._createdBy != 0 {
        try visitor.visitSingularInt64Field(value: _storage._createdBy, fieldNumber: 2)
      }
      if _storage._bodyType != .text {
        try visitor.visitSingularEnumField(value: _storage._bodyType, fieldNumber: 3)
      }
      if !_storage._title.isEmpty {
        try visitor.visitSingularStringField(value: _storage._title, fieldNumber: 4)
      }
      if !_storage._body.isEmpty {
        try visitor.visitSingularStringField(value: _storage._body, fieldNumber: 5)
      }
      if let v = _storage._createdAt {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
      }
      if let v = _storage._updatedAt {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Note_CreateRequest, rhs: Note_CreateRequest) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._noteID != rhs_storage._noteID {return false}
        if _storage._createdBy != rhs_storage._createdBy {return false}
        if _storage._bodyType != rhs_storage._bodyType {return false}
        if _storage._title != rhs_storage._title {return false}
        if _storage._body != rhs_storage._body {return false}
        if _storage._createdAt != rhs_storage._createdAt {return false}
        if _storage._updatedAt != rhs_storage._updatedAt {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Note_CreateResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".CreateResponse"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Note_CreateResponse, rhs: Note_CreateResponse) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Note_GetRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "note_id"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.noteID)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.noteID.isEmpty {
      try visitor.visitSingularStringField(value: self.noteID, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Note_GetRequest, rhs: Note_GetRequest) -> Bool {
    if lhs.noteID != rhs.noteID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Note_GetResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "note_id"),
    2: .standard(proto: "body_type"),
    3: .standard(proto: "created_by"),
    4: .same(proto: "title"),
    5: .same(proto: "body"),
    6: .standard(proto: "created_at"),
    7: .standard(proto: "updated_at"),
  ]

  fileprivate class _StorageClass {
    var _noteID: String = String()
    var _bodyType: Note_BodyType = .text
    var _createdBy: Int64 = 0
    var _title: String = String()
    var _body: String = String()
    var _createdAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
    var _updatedAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _noteID = source._noteID
      _bodyType = source._bodyType
      _createdBy = source._createdBy
      _title = source._title
      _body = source._body
      _createdAt = source._createdAt
      _updatedAt = source._updatedAt
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularStringField(value: &_storage._noteID)
        case 2: try decoder.decodeSingularEnumField(value: &_storage._bodyType)
        case 3: try decoder.decodeSingularInt64Field(value: &_storage._createdBy)
        case 4: try decoder.decodeSingularStringField(value: &_storage._title)
        case 5: try decoder.decodeSingularStringField(value: &_storage._body)
        case 6: try decoder.decodeSingularMessageField(value: &_storage._createdAt)
        case 7: try decoder.decodeSingularMessageField(value: &_storage._updatedAt)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if !_storage._noteID.isEmpty {
        try visitor.visitSingularStringField(value: _storage._noteID, fieldNumber: 1)
      }
      if _storage._bodyType != .text {
        try visitor.visitSingularEnumField(value: _storage._bodyType, fieldNumber: 2)
      }
      if _storage._createdBy != 0 {
        try visitor.visitSingularInt64Field(value: _storage._createdBy, fieldNumber: 3)
      }
      if !_storage._title.isEmpty {
        try visitor.visitSingularStringField(value: _storage._title, fieldNumber: 4)
      }
      if !_storage._body.isEmpty {
        try visitor.visitSingularStringField(value: _storage._body, fieldNumber: 5)
      }
      if let v = _storage._createdAt {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
      }
      if let v = _storage._updatedAt {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Note_GetResponse, rhs: Note_GetResponse) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._noteID != rhs_storage._noteID {return false}
        if _storage._bodyType != rhs_storage._bodyType {return false}
        if _storage._createdBy != rhs_storage._createdBy {return false}
        if _storage._title != rhs_storage._title {return false}
        if _storage._body != rhs_storage._body {return false}
        if _storage._createdAt != rhs_storage._createdAt {return false}
        if _storage._updatedAt != rhs_storage._updatedAt {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Note_NoteMessage: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".NoteMessage"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "note_id"),
    2: .standard(proto: "body_type"),
    3: .standard(proto: "created_by"),
    4: .same(proto: "title"),
    5: .same(proto: "body"),
    6: .standard(proto: "created_at"),
    7: .standard(proto: "updated_at"),
  ]

  fileprivate class _StorageClass {
    var _noteID: String = String()
    var _bodyType: Note_BodyType = .text
    var _createdBy: Int64 = 0
    var _title: String = String()
    var _body: String = String()
    var _createdAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
    var _updatedAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _noteID = source._noteID
      _bodyType = source._bodyType
      _createdBy = source._createdBy
      _title = source._title
      _body = source._body
      _createdAt = source._createdAt
      _updatedAt = source._updatedAt
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularStringField(value: &_storage._noteID)
        case 2: try decoder.decodeSingularEnumField(value: &_storage._bodyType)
        case 3: try decoder.decodeSingularInt64Field(value: &_storage._createdBy)
        case 4: try decoder.decodeSingularStringField(value: &_storage._title)
        case 5: try decoder.decodeSingularStringField(value: &_storage._body)
        case 6: try decoder.decodeSingularMessageField(value: &_storage._createdAt)
        case 7: try decoder.decodeSingularMessageField(value: &_storage._updatedAt)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if !_storage._noteID.isEmpty {
        try visitor.visitSingularStringField(value: _storage._noteID, fieldNumber: 1)
      }
      if _storage._bodyType != .text {
        try visitor.visitSingularEnumField(value: _storage._bodyType, fieldNumber: 2)
      }
      if _storage._createdBy != 0 {
        try visitor.visitSingularInt64Field(value: _storage._createdBy, fieldNumber: 3)
      }
      if !_storage._title.isEmpty {
        try visitor.visitSingularStringField(value: _storage._title, fieldNumber: 4)
      }
      if !_storage._body.isEmpty {
        try visitor.visitSingularStringField(value: _storage._body, fieldNumber: 5)
      }
      if let v = _storage._createdAt {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
      }
      if let v = _storage._updatedAt {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Note_NoteMessage, rhs: Note_NoteMessage) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._noteID != rhs_storage._noteID {return false}
        if _storage._bodyType != rhs_storage._bodyType {return false}
        if _storage._createdBy != rhs_storage._createdBy {return false}
        if _storage._title != rhs_storage._title {return false}
        if _storage._body != rhs_storage._body {return false}
        if _storage._createdAt != rhs_storage._createdAt {return false}
        if _storage._updatedAt != rhs_storage._updatedAt {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Note_ListRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".ListRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "offset"),
    2: .same(proto: "limit"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularInt64Field(value: &self.offset)
      case 2: try decoder.decodeSingularInt64Field(value: &self.limit)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.offset != 0 {
      try visitor.visitSingularInt64Field(value: self.offset, fieldNumber: 1)
    }
    if self.limit != 0 {
      try visitor.visitSingularInt64Field(value: self.limit, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Note_ListRequest, rhs: Note_ListRequest) -> Bool {
    if lhs.offset != rhs.offset {return false}
    if lhs.limit != rhs.limit {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Note_ListResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".ListResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "notes"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedMessageField(value: &self.notes)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.notes.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.notes, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Note_ListResponse, rhs: Note_ListResponse) -> Bool {
    if lhs.notes != rhs.notes {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Note_UpdateRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".UpdateRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "note_id"),
    2: .standard(proto: "body_type"),
    3: .same(proto: "title"),
    4: .same(proto: "body"),
    5: .standard(proto: "updated_at"),
  ]

  fileprivate class _StorageClass {
    var _noteID: String = String()
    var _bodyType: Note_BodyType = .text
    var _title: String = String()
    var _body: String = String()
    var _updatedAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _noteID = source._noteID
      _bodyType = source._bodyType
      _title = source._title
      _body = source._body
      _updatedAt = source._updatedAt
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        switch fieldNumber {
        case 1: try decoder.decodeSingularStringField(value: &_storage._noteID)
        case 2: try decoder.decodeSingularEnumField(value: &_storage._bodyType)
        case 3: try decoder.decodeSingularStringField(value: &_storage._title)
        case 4: try decoder.decodeSingularStringField(value: &_storage._body)
        case 5: try decoder.decodeSingularMessageField(value: &_storage._updatedAt)
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if !_storage._noteID.isEmpty {
        try visitor.visitSingularStringField(value: _storage._noteID, fieldNumber: 1)
      }
      if _storage._bodyType != .text {
        try visitor.visitSingularEnumField(value: _storage._bodyType, fieldNumber: 2)
      }
      if !_storage._title.isEmpty {
        try visitor.visitSingularStringField(value: _storage._title, fieldNumber: 3)
      }
      if !_storage._body.isEmpty {
        try visitor.visitSingularStringField(value: _storage._body, fieldNumber: 4)
      }
      if let v = _storage._updatedAt {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Note_UpdateRequest, rhs: Note_UpdateRequest) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._noteID != rhs_storage._noteID {return false}
        if _storage._bodyType != rhs_storage._bodyType {return false}
        if _storage._title != rhs_storage._title {return false}
        if _storage._body != rhs_storage._body {return false}
        if _storage._updatedAt != rhs_storage._updatedAt {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Note_UpdateResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".UpdateResponse"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Note_UpdateResponse, rhs: Note_UpdateResponse) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Note_DeleteRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".DeleteRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "note_id"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.noteID)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.noteID.isEmpty {
      try visitor.visitSingularStringField(value: self.noteID, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Note_DeleteRequest, rhs: Note_DeleteRequest) -> Bool {
    if lhs.noteID != rhs.noteID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Note_DeleteResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".DeleteResponse"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Note_DeleteResponse, rhs: Note_DeleteResponse) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
