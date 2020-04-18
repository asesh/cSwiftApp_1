//
//  main.swift
//  cSwiftApp_1
//
//  Created by Asesh Shrestha on 1/18/20.
//  Copyright © 2020 Asesh Shrestha. All rights reserved.
//

import Foundation

//enum WishList {
//  case "Hello", "World", "Can", "You", "See", "this", "message"
//}

let longString =
"""
  Hello world, this is a multi-line string
"""

//let list = ["iPhone", "iPad Pro", "iWatch"]

//print("Hello, World!")

//for item in list {
//  print("This is an \(item)")
//}

//func foo() -> Bool {
//  print("Foo from foo")
//  return true
//}
//
//func sum(number: Int) -> Int {
//  if number <= 0 {
//    return 0
//  }
//
//  return number + sum(number: number - 1)
//}
//var result = sum(number: 5)
//print("The result of sum is: \(result)")
//
//func factorial(number: Int) -> Int {
//  if number < 1 {
//    return 1
//  }
//
//  return number * factorial(number: number - 1)
//}
//var factorial_result = factorial(number: 5)
//print("The result of factorial is: \(factorial_result)")

protocol ExampleProtocol {
  var simpleDescription: String { get }
  mutating func adjust()
}

//struct SFoo : ExampleProtocol {
//  var simpleDescription: String = "foo"
//  
//  func adjust() {
//    simpleDescription = "modified"
//  }
//}

class CFoo: ExampleProtocol {
  var simpleDescription: String = "Hello world"
//  var simpleDescription: Int = 0
  
  init(_ value: String, _ anotherValue: String) {
    print("Constructor invoked with data: \(value), another value: \(anotherValue)")
  }
  
  func adjust() {
    simpleDescription = "modified from CFoo"
  }
  
  deinit {
    print("Destructor invoked")
  }
}

//var foo_ = CFoo("Can you see this?", "What about this one?")
//var backend_ = CBackend()

enum FooError : Error {
  case SomethingWentWrong
  case NothingWentWrong
}

func might_throw_error(input_text: String) throws -> String {
  if input_text != "Hello world" {
    throw FooError.SomethingWentWrong
  }
  
  return "Everything's good"
}

//let returned_string = try? might_throw_error(input_text: " world")
//if returned_string == nil {
//  print("is nil")
//}
//else {
//  print("The value of 'returned_string' is: \(returned_string!)")
//}

var foo_number : Int = 10
//assert(foo_number != 10, "The foo_number should be 10")
//do {
//  let returned_string = try might_throw_error(input_text: "foo")
//} catch {
//  print("Caught exception")
//}

class CUTCLabelRemover {
  init() {
    
  }
  
  deinit {
    
  }
  
  private let filename_regex = #"(^.*)(?=\s\()|(\(.+\))|(\.\S+$)"#
  
  func regex_matches(in input_string: String) -> [String] {
    do {
      let regex = try NSRegularExpression(pattern: filename_regex)
      let results = regex.matches(in: input_string,
                                  range: NSRange(input_string.startIndex..., in: input_string))
      return results.map {
        String(input_string[Range($0.range, in: input_string)!])
      }
    } catch let error {
      print("invalid regex: \(error.localizedDescription)")
      return []
    }
  }
  
  func rename_files_in_directory(directory: String) {
    
    print("Scanning this directory: \(directory)")
    
    let file_manager = FileManager.default
    
    var is_directory: ObjCBool = false
    
    do {
      let modified_directory_url = directory.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
      // Enumerate the contents of directory
      let directory_contents = try file_manager.contentsOfDirectory(at: URL(string: modified_directory_url!)!, includingPropertiesForKeys: nil)
      for content in directory_contents {
        if file_manager.fileExists(atPath: content.path, isDirectory: &is_directory) {
          if is_directory.boolValue {
            print("DIRECTORY: \(content.path)")
            rename_files_in_directory(directory: content.path)
          }
          else {
            print("Filename: \(content.lastPathComponent)")
            let matched_data = regex_matches(in: content.lastPathComponent)
//            print("Matched strings:")
            if matched_data.count > 1 {
              var filename = matched_data[0]
              if matched_data.count == 3 { // This filename has an extension
                filename += matched_data[2]
              }
              print("Final filename: \(filename)")
              
              let full_new_filepath = directory + "/\(filename)"
              print("Absolute path of the file to rename: \(full_new_filepath)")
              
//              var continue_loop = true
//              var number_counter = 0
              
              // Before renaming this file, let's a file with the same name already exists
              if file_manager.fileExists(atPath: full_new_filepath) {
                print("File to rename exists already in the directory, so let's skip this file")
                // Loop for adding (x) to a filename; where x is a number
//                repeat {
//                  var new_filename = directory + "/\(filename"
//                  number_counter += 1
//                } while continue_loop
              }
              else {
                print("File to rename doesn't exists in the directory")
                let existing_file_url = URL(fileURLWithPath: content.path)
                let new_file_url = URL(fileURLWithPath: full_new_filepath)
                do {
                  try file_manager.moveItem(at: existing_file_url, to: new_file_url)
                  print("Renamed file to: \(new_file_url)")
                }
                catch {
                  print(error)
                }
              }
            }
          }
        }
      }
    }
    catch {
      print("Encountered an error")
    }
  }
}

//let utc_label_remover = CUTCLabelRemover()
//utc_label_remover.rename_files_in_directory(directory: "/Users/aseshshrestha/Documents")


//var backend = CBackend()
//backend.foo()


//let foo = ["foo"]
//if let value = foo[1]? {
//
//}
//print("The value is: \(foo[1])")

@propertyWrapper
struct SWrappedProperty {
	var wrapped_property: Int = 0

	var wrappedValue : Int {
		get {
			return wrapped_property
		}
		
		set {
			wrapped_property = min(newValue, 12)
		}
	}
}

class CFoo2 {
//	private var my_number: Int?
	
//	private var number_array:Int
	
	var assigned_value: Int = 0
	
@SWrappedProperty var wrapper_value: Int
	
	init() {
//		optional_number = 0
		wrapper_value = 100
	}
	
	subscript(index: Int) -> Int {
		get {
			return self.assigned_value
		}
		set {
			self.assigned_value = newValue
		}
	}
	
	func foo() {
		print("The value of 'wrapper_value' is \(wrapper_value)")
//		print("The value is: \(self.my_number!)")
	}
	
	var optional_number: Int?
	var computed_properties : Int {
		get {
			return 12
		}

		set(some_number) {
			optional_number = some_number
		}
	}
}

// Optional chaining
//class COptionalChaining {
//	var foo_dep : CFooDependency?
//}
//
//class CFooDependency {
//	let my_number = 1
//}
//
//let foo = COptionalChaining()
//print("Number via optional chaining: \(foo.foo_dep?.my_number)")








// Type cast and type check operators
class CGeometry {
	var name: String
	init(geometry_name: String) {
		self.name = geometry_name
		
	}
}

class CTriangle: CGeometry {
	override init(geometry_name: String) {
		super.init(geometry_name: geometry_name)
	}
}

class CSquare: CGeometry {
	override init(geometry_name: String) {
		super.init(geometry_name: geometry_name)
	}
}

// Tests type-check operator
//func test_is() {
//	let triangle = CTriangle()
//	if triangle is CTriangle {
//		print("triangle is CTriangle")
//	}
//	if triangle is CSquare {
//
//	} else {
//		print("Triangle is not CSquare")
//	}
//	let square = CSquare()
//	if square is CGeometry {
//		print("square is CGeometry")
//	}
//}
//test_is()




// Test type-cast operator
func test_as() {
	var any_type = [Any] ()
	any_type.append(0)
	any_type.append(1)
	any_type.append(2.0)
	any_type.append("foo")
	for type in any_type {
		switch type {
		case 0 as Int:
			print("Found 0")
			
		case 1 as Int:
			print("Found 1")
			
		case 2.0 as Double:
			print("Found 2.0")
			
		case "foo" as String:
			print("Found Foo")
			
		default:
			print("Found nothing\n")
		}
	}
	
//	let geometry_array = [
//		CTriangle(geometry_name: "tri 1"),
//		CTriangle(geometry_name: "tri 2"),
//		CSquare(geometry_name: "square 1"),
//		CSquare(geometry_name: "square 2")
//	]
//
//	for geometry in geometry_array {
//		if let geometry_type = geometry as? CSquare {
//			print("Geometry of type square: \(geometry_type.name)")
//		} else if let geometry_type = geometry as? CTriangle {
//			print("Geometry of type triange: \(geometry_type.name)")
//		}
//	}
	
//	let square = CSquare(geometry_name: "square")
//	let triangle = CTriangle(geometry_name: "triangle")
//
//	// Let's see if typecasting from triangle to square succeeds
//	if let type_square = triangle as? CSquare {
//		print("triangle has been typecasted to square")
//	} else {
//		print("failed to typecast triangle to square")
//	}
	
	// Let's see if tyepcasting from square to geometry succeeds
//	if let type_triangle
}
//test_as()






//let formatted_string = String(format: "The new formatted string is: %@ %@ %0.0x", "foo: ", "another foo: ", 10)
//print(formatted_string)

//let foo_ = CFoo2()
//foo_.foo()
//foo_[12] = 200
//print("The value returned by subscript is: \(foo_[1])")
//let computed_number = foo_.computed_properties
//foo_.computed_properties = 100
//print("The value computer_properties: \(foo_.computed_properties)")
//print("The value of optional_number: \(foo_.optional_number!)")
