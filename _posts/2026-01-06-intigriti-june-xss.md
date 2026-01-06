---
layout: post
title: "Intigriti June XSS Challenge: Reflected XSS Write-up"
date: 2026-01-06 00:01:00 +0000
categories: [writeups]
tags: [xss, web-security, javascript, writeup]
---

## Preface

Intigriti hosts Capture The Flag (CTF) events throughout the year. Each month, a new challenge is released with a seven-day completion window. The objective for the [June 0622 challenge](https://challenge-0622.intigriti.io/) was to execute `alert(document.domain)`.

![Screenshot of the challenge landing page](/assets/img/intigriti-june/landing-page.png)

## Reconnaissance

The application surface area was limited to three specific functions: **Milk**, **Cookie**, and **Alert**.

### Alert

Its function is used to create alert boxes. This initially piqued my interest, as the objective is to trigger an alert and this function appeared to be doing half the work.

However, standard vectors were neutralized; any input containing JavaScript or HTML characters was systematically capitalised or encoded. It did not appear to be a viable attack vector worth pursuing deeper.

### Milk

This function calculated the amount of cups and buckets of milk.

In the 'cups' input, the application handled hash characters (`#`) by URL encoding them. This differed from the 'buckets' input, where they were not encoded at all. Despite this inconsistency, the inputs were strictly evaluated as integers, preventing arbitrary code execution.

```javascript
<script>
    var total = eval(0.000000+0.000000*4);
    document.getElementById("total").value=total;
</script>
```

### Cookie

The Cookie function sets a browser cookie based on provided information. Initially, there appeared to be no direct user-controlled input. However, an analysis of the source code revealed a parsing anomaly.

```javascript
function cookie_spawn(eggs, chocolate, vendor, location, price){
    const cookie_value = 'eggs:' + eggs.toString() +
        ', chocolate:' + chocolate.toString() +
        ', price:10, vendor:' + vendor.toString() + '; ';
    document.cookie = 'cookieshop= ' + cookie_value
};
```

While the parameters appeared hard-coded, I noticed the `location` parameter was being passed into the function but remained unused in the logic. This unmapped parameter warranted further investigation.

## Exploitation

Exploitation presented challenges due to input handling quirks. I frequently encountered a `ReferenceError: challenge is not defined`.

This error revealed that the application was attempting to **mathematically evaluate the path string**. specifically, it was trying to divide `challenge` by `index.php`. Since `challenge` was undefined, the script execution halted.

### Step 1: Breaking Out

To escape the restricted context, I needed to close the argument list of `cookie_spawn` and break out of the `create` function. This allows the injection of a payload without it being stripped by the internal logic.

We can achieve this by injecting a closing parenthesis, a curly brace, and a semi-colon:

```text
[https://challenge-0622.intigriti.io/challenge/index.php?1](https://challenge-0622.intigriti.io/challenge/index.php?1))};a={//&choice=cookie&nl=
```

However, this resulted in a syntax error: `missing : in conditional expression`.

### Step 2: The Operator

The syntax error suggested the parser was expecting a conditional (ternary) operator. This required a re-evaluation of JavaScript operator precedence. I needed an operator that would take precedence over the division operation of `challenge / index.php`.

The URL structure required a question mark (`?`) for the query string. This narrowed the options to operators that utilise this character:

1. **Ternary Operator (`? :`)**: An alternative to `if...else`.
2. **Nullish Coalescing Operator (`??`)**: Returns the right-hand side operand when the left-hand side is `null` or `undefined`.

Since both `challenge` and `index` are undefined in the global scope, the **Nullish Coalescing Operator** was the ideal candidate.

### The Solution

By using `??`, we can force the JavaScript engine to ignore the undefined `challenge` variable and evaluate our payload instead.

We construct the URL to inject the operator, close the function, and execute the alert:

```javascript
// The logical flow:
// undefined ?? 1 -> returns 1
// )}; -> closes the function
// alert(document.domain) -> executes XSS
```

**Final Payload:**

```text
[https://challenge-0622.intigriti.io/challenge/index.php??1](https://challenge-0622.intigriti.io/challenge/index.php??1))};alert(document.domain);a={//&choice=cookie&nl=```

This successfully bypasses the logic error and executes the JavaScript, as can be seen below:

![Screenshot of the final successful alert](/assets/img/intigriti-june/success-alert.png)

For an easy break down of how this payload works:

![Payload Diagram](/assets/img/intigriti-june/diagram.png)
