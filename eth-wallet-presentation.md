class: center, middle

# Ethereum Web Wallet

&nbsp;

&nbsp;

Francesco Canessa

Lead Software Developer

&nbsp;

Applied Blockchain

&nbsp;

Rise London 2018 - Blockchain Week Development Workshop

---

# Ethereum Web Wallet

&nbsp;

1. Setup

<!-- node (or runkit), git repo with node and browserify -->

2. Generate a Private Key

3. Derive an Ethereum address

4. Get the address balance

5. Sign transansaction

6. Broadcast transaction

---

# Setup

&nbsp;


Node installed 7.6+ - Upgrade or use github:yortus/asyncawait

https://github.com/yortus/asyncawait#6-quick-start


Last resource is runkit (https://runkit.com)


&nbsp;


---

# Setup

&nbsp;

```sh
$ node -v

v7.6+
```

---


# Setup

&nbsp;

```
https://runkit.com/makevoid/check-async-support
```

---



# Hello Node

&nbsp;

```js
console.log("hello world")
```

&nbsp;


---


# Generate a Private Key

&nbsp;

You don't need to type/follow on this one

```js
const bitcore = require('bitcore-lib')
const PrivateKey = bitcore.PrivateKey

const privateKey = new PrivateKey()
console.log(privateKey.toString())
```

&nbsp;

https://runkit.com/makevoid/bitcore-lib-privatekey

&nbsp;

---

# Derive the PublicKey

&nbsp;

```js
const bitcore = require('bitcore-lib')
const PrivateKey = bitcore.PrivateKey

const privateKey = new PrivateKey("711fd1eeecec8bb8c912129466504de109a17e764060c7e5e5b56d3ea0a8aa3b")
const publicKey  = privateKey.toPublicKey()
console.log(publicKey.toString())
```

&nbsp;

https://runkit.com/makevoid/bitcore-lib-address

---

# Generate an address (bitcoin)

&nbsp;

```js
const bitcore = require('bitcore-lib')
const PrivateKey = bitcore.PrivateKey

const privateKey = new PrivateKey()
const publicKey  = privateKey.toPublicKey()
console.log(publicKey.toString())
const address    = publicKey.toAddress().toString()
console.log(address)
```

&nbsp;

https://runkit.com/makevoid/bitcore-lib-address

---

# Setup Web3

&nbsp;

```js
const Web3 = require('web3')
const web3 = new Web3("https://mainnet.infura.io")
```

http://web3js.readthedocs.io/en/1.0/web3.html

&nbsp;

---

# Setup Web3

&nbsp;

```sh
npm init -fy

npm i --save-dev  lerna
npm i --save      web3-eth-accounts
npm i --save      ethereum/web3.js#1.0
```

&nbsp;

---

# Setup Web3

&nbsp;

```js
const Web3 = require('web3')
const web3 = new Web3("https://kovan.infura.io")
```

&nbsp;

---


# Setup Web3

&nbsp;

```js
const Web3 = require('web3')
const provUrl  = "https://mainnet.infura.io"
const provider = new Web3.providers.HttpProvider(provUrl)
const web3 = new Web3(provider)
```

&nbsp;

---


# Setup Web3 (accounts)

&nbsp;

```js
const Accounts = require('web3-eth-accounts');
const accounts = new Accounts();
```

&nbsp;

---

# Derive an ethereum address

&nbsp;

```js
const bitcore = require('bitcore-lib')
const PrivateKey = bitcore.PrivateKey

const Accounts = require('web3-eth-accounts');
const accounts = new Accounts();

const privateKey = new PrivateKey()
const key = `0x${privateKey.toString()}`
const account = accounts.privateKeyToAccount(key)
console.log(account.address)
```


https://runkit.com/makevoid/bitcore-lib-web3-accounts

&nbsp;

---

# Generate an ethereum "account"

&nbsp;

```js
const Accounts = require('web3-eth-accounts');
const accounts = new Accounts();
const account = accounts.create()
console.log(account.address)
```

https://runkit.com/makevoid/web3-eth-accounts-address

---

# Load the same key (Node)

&nbsp;


---

# Load the same key (Node)

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Title

&nbsp;


---

# Thanks!

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;



```coffee
@makevoid
```

Applied Blockchain


Please don't share / upload these slides on social media. Thanks.
