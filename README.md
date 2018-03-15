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
	* This is used for sorting item by price, value can only be `asc` or `desc`, default will be `asc`
```
{
	sort_by: <String>
}
```
##### response
```
{
  <searched_key_word>: 
    {
      rt_mart_results:
        [
          {
            item_name: <String>,
            item_price: <Integer>,
            img_src: <String>
          }
        ],
      carrefour_results:
        [
          {
            item_name: <String>,
            item_price: <Integer>,
            img_src: <String>
          }
        ]
    }
}
```

