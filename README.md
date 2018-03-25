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

V2 fix
---
* Update services implement strucutre
* Improve search time from 1 minute to 10-15 seconds
