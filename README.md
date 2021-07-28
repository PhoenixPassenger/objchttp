# objchttp

[![CI Status](https://img.shields.io/travis/32482081/objchttp.svg?style=flat)](https://travis-ci.org/32482081/objchttp)
[![Version](https://img.shields.io/cocoapods/v/objchttp.svg?style=flat)](https://cocoapods.org/pods/objchttp)
[![License](https://img.shields.io/cocoapods/l/objchttp.svg?style=flat)](https://cocoapods.org/pods/objchttp)
[![Platform](https://img.shields.io/cocoapods/p/objchttp.svg?style=flat)](https://cocoapods.org/pods/objchttp)

## How to use

### Common HTTP Requests
To use objchttp you have to implement an object of the class httpReques iniciating that object with the schema `http or https` and the `host`, following this example

```
httpRequest * requester = [httpRequest alloc];
requester.schema = @"https";
requester.host = @"://jsonplaceholder.typicode.com";
```

To make the http call simply use that object with the method you what, in the following example its a `GET` call

```
[requester fetchData: @"/posts/1"
          completion:^(NSString * result) {
    [self printString: result];
}];
```

 Where `fetchData` is the name of the function, them you pass the endpoint of the API and a completion, in this case we are calling the `printString` function from our ViewController.
 The result in question is a NSString containing a JSON Object with the response.
 
There is four simple http requests, being : 

* fetchData : for the GET method.
* postData : for the POST method.
* putData : for the PUT method.
* deleteData : for the DELETE method.

In the `postData` and the `putData` functions you also have to pass a dictionary containing the body of your http request, see the following example to see how can you do it.

```
NSMutableDictionary *uDictionary = [[NSMutableDictionary alloc] init];
[uDictionary setValue:@"Rogrido" forKey:@"name"];
[uDictionary setValue:@"iOS Developer" forKey:@"job"];
```

And the function looks like this

```    
[requester postData:uDictionary :@"/posts" completion:^(NSString * result) {
[self printString: result];
}];
```

Where `uDictionary` is a NSMutableDictionary where you will pass the json and `@"/posts"` is the endpoint for the request. 
### Custom HTTP Requests
The method `requestWithMethod` you can pass the method to the request
```
[requester requestWithMethod:@"POST" :@"/posts" completion:^(NSString * result) {
    [self printString: result];
}];
```
Where `requestWithMethod` is the name of the function ,`@:"POST"` is the method and `@"/posts"` is the endpoint, them you pass the endpoint of the API and a completion, in this case we are calling the `printString` function from our ViewController.
The result here is a NSString containing a JSON Object with the response.

The method `requestWithMethod` you can pass the method to the request and a body to the function
```
[requester requestWithMethodAndBody:@"POST":uDictionary:@"/posts" completion:^(NSString * result) {
  [self printString: result];
}];
```
Where `requestWithMethodAndBody` is the name of the function ,`@:"POST"`  is the method , `uDictionary` is a NSMutableDictionary with the JSON Object and `@"/posts"` is the endpoint, them you pass the endpoint of the API and a completion, in this case we are calling the `printString` function from our ViewController.
The result will be a NSString containing a JSON Object with the response.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

objchttp is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'objchttp'
```

## Author

32482081, Rodrigo.ato@hotmail.com

## License

objchttp is available under the MIT license. See the LICENSE file for more info.
