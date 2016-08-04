
/*
 * with return type
 */
func helloWorld(name: String) -> String
{
    return "Hello, " + name
}

helloWorld("Marabesi")

/*
 * without return type
 */
func helloWorldWithoutReturn(name:String)
{
    print("Hello, " + name)
}

helloWorldWithoutReturn("Matheus")

/*
 * as many paramenters as possible
 */
func avg(numbers: Float...) -> Float
{
    var total:Float = 0.0;
    
    for number in numbers {
        total += number;
    }
    
    return total/Float(numbers.count);
}

print("avg: \(avg(1.2, 2.0, 3.0, 5))")

/*
 * closures
 */

let value = { number in 3 * number }

print(value(3))

