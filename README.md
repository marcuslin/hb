# Setting up

PhantomJS
---
* Using pahntomJS to handle some of the javascript part while crawling

  `brew install phantomjs`

API
---
##### [GET] /api/v1/search
Search item from Carrefour and RT mart

##### parameters
* required
```
{
	key_word: <String>
}
```
* Optional
	- This is used for sorting item by price, value can only be `asc` or `desc`, default will be `asc`
```
{
	sort_by: <String>
}
```

* Optional
	- There might be too many items in the search results which will lead to a 1+ minute total crawl time,
		so I decide to set default crawl item size by `30` in order to decrease crawl time.
		Please feel free to fill in any desired number for crawling more items.
```
{
	limit: <Integer>
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

