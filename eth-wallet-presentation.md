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

npm i --save      web3-eth-accounts
npm i --save      isomorphic-fetch es6-promise
```

optional:

```sh
npm i --save-dev  lerna
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
const Accounts = require('web3-eth-accounts')
const accounts = new Accounts()
```

&nbsp;

---

# Derive an ethereum address

&nbsp;

```js
const bitcore = require('bitcore-lib')
const PrivateKey = bitcore.PrivateKey

const Accounts = require('web3-eth-accounts')
const accounts = new Accounts()

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
const Accounts = require('web3-eth-accounts')
const accounts = new Accounts()
const account = accounts.create()
console.log(account.address)
```

https://runkit.com/makevoid/web3-eth-accounts-address

---

# Load the same key (Node) 1/2

&nbsp;


```js
const Accounts = require('web3-eth-accounts')
const accounts = new Accounts()
const account = accounts.create()
console.log(account.privateKey)
```


https://runkit.com/makevoid/web3-eth-accounts-private-key

Save key into `private-key.txt`

---

# Load the same key (Node) 2/2

&nbsp;

```js
const fs = require('fs')
const readFileSync = fs.readFileSync
const Accounts = require('web3-eth-accounts')
const accounts = new Accounts()

const key = readFileSync("private-key.txt")
const account = accounts.privateKeyToAccount(key)
console.log(account.address)
```


---

# Load the same key (Node)

&nbsp;

```js
const fs = require('fs')
const readFileSync = fs.readFileSync
const Accounts = require('web3-eth-accounts')
const accounts = new Accounts()

const key = readFileSync("private-key.txt")
const account = accounts.privateKeyToAccount(key)
console.log(account.address)
```

re-run it - it will return the same address! :D


---

# Receive Ethers

https://duckduckgo.com

!qr 0x1234...


---

# Check transaction on block explorer


https://etherscan.io/address/0x1234...


&nbpsp;

&nbpsp;


(https://kovan.etherscan.io/ for testnet)

---

# Check address balance

```js
require('isomorphic-fetch')

const getBalance = async (address) => {
  const balanceUrl = `https://api.etherscan.io/api?module=account&action=balance&address=${address}&tag=latest`
  let resp = await fetch(balanceUrl)
  resp = await resp.json()
  return Number(resp['result'] || 0)
}

(async () => {
  const balance = await getBalance("0x738d145faabb1e00cf5a017588a9c0f998318012")
  console.log(balance)
})()
```

https://runkit.com/makevoid/etherscan-getbalance


Etherscan API:
https://etherscan.io/apis#accounts


---

# Create Transaction - 1/2

&nbsp;

```js
const createTx = async ({recipient, account, value}) => {
  const txData = {
    value: value,
    to: recipient,
    gas: 21000,
    gasPrice: 5000000000, // 5 gwei
    from: account.address,
    // nonce: 1,
  }
  const tx = await account.signTransaction(txData)
  const txRaw = tx.rawTransaction
  console.log("TX RAW", txRaw)
  return txRaw
}
```

---

# Create Transaction - 2/2

```js
(async () => {
  const fs = require('fs')
  const readFileSync = fs.readFileSync
  const Accounts = require('web3-eth-accounts')
  const accounts = new Accounts()

  const key = readFileSync("private-key.txt")
  const account = accounts.privateKeyToAccount(key)

  createTx({
    account:    account,
    recipient:  "0xD9dDF72Ef671261Cb2266B9D924c5980C5186699",
    value:      100000000000000, // 100 szabo
  })
})()
```

https://ethgasstation.info -
https://converter.murkin.me

---

For reference:

```js
const createTx = async ({recipient, account, value}) => {
  const txData = {
    value: value,
    to: recipient,
    gas: 21000,
    gasPrice: 5000000000, // 5 gwei
    from: account.address,
    // nonce: 1,
  }
  const tx = await account.signTransaction(txData)
  const txRaw = tx.rawTransaction
  console.log("TX RAW", txRaw)
  return txRaw
}

(async () => {
  const fs = require('fs')
  const readFileSync = fs.readFileSync
  const Accounts = require('web3-eth-accounts')
  const accounts = new Accounts()

  const key = readFileSync("private-key.txt")
  const account = accounts.privateKeyToAccount(key)

  createTx({
    account:    account,
    recipient:  "0xD9dDF72Ef671261Cb2266B9D924c5980C5186699",
    value:      100000000000000, // 100 szabo
  })
})()
```

---


# Broadcast Transaction

&nbsp;

## https://etherscan.io/pushTx



---


# Broadcast Transaction

&nbsp;


```js
const broadcastTransaction = async (rawTx) => {
  const broadcastUrl = "https://api.etherscan.io/api"

  const data = new FormData()
  data.append('module', 'proxy')
  data.append('action', 'eth_sendRawTransaction')
  data.append('hex', rawTx)
  data.append('apikey', '3DQFQQZ51G4M18SW8RDKHIMERD79GYTVEA') // TODO: please fork and use your own APi key

  let resp = await fetch(broadcastUrl, {
    method: "post",
    body: data,
  })
  resp = await resp.json()
  c.log("etherscan broadcast:", resp)

  return resp
}


(async () => {
  const rawTx = "0xf86a0285012a05f20082520894d9ddf72ef671261cb2266b9d924c5980c5186699865af3107a40008026a0824d7b8b937437feff4ab206a556d599a70ce150ecc6ceeee7174bb5c679e0cea0643e49ae4bb8aae422245b6837997cff4a03714088043afc83deabf03043f253"

  await broadcastTransaction(rawTx)
})()
```


---

# Title

&nbsp;

```js

```


---

# Title

&nbsp;

```js

```


---

# Title

&nbsp;

```js

```


---

# Title

&nbsp;

```js

```


---

# Title

&nbsp;

```js

```


---

# Title

&nbsp;

```js

```


---

# Title

&nbsp;

```js

```


---

# Title

&nbsp;

```js

```


---

# Title

&nbsp;

```js

```


---

# Title

&nbsp;

```js

```


---

# Title

&nbsp;

```js

```


---

# Title

&nbsp;

```js

```


---

# Title

&nbsp;

```js

```


---

# Title

&nbsp;

```js

```


---

# Title

&nbsp;

```js

```


---

# Title

&nbsp;

```js

```


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
