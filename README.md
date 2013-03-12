# JSONConfig

Java-like JSON-backed configuration/preferences system. Synopsis:

```js
// Require the module:
var Config = require('jsonconfig');

// Create a config object:
var config = new Config({
  a: {
    a1: 123,
    a2: 234
  },
  b: {
    b1: "abc",
    b2: "bcd"
  }
});

// Use the get() method to retrieve configuration information as plain JS data:
var foo = config.get("a");    // foo is { a1: 123, a2: 234 }
var bar = config.get("b.b1"); // bar is "abc"

// Use the chaining set() method to update the configuration:
config.set("a.a1", 345).set("b", "xyz");
// config is now { a: { a1: 345, a2: 234 }, b: "xyz" }
```
