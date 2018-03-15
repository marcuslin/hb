# Setting up

PhantomJS
---
* Using pahntomJS to handle some of the javascript part while crawling,

  `brew install phantomjs`.

API
---
##### [GET] /api/:version/search
Search item from Carrefour and RT mart

##### parameters
* required
```
{
	key_word: <String>
}
```
* Optional
	* This is used for sorting item by price, value can be both `asc` or `desc`
```
{
	sort_by: <String>
}
```
