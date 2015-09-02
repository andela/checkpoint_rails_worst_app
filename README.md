### This is one of the worst performing Rails apps ever.

Currently, the home page takes this long to load:

```bash
Rendered author/index.html.erb within layouts/application (12392.4ms)
Completed 200 OK in 12677ms (Views: 6560.1ms | ActiveRecord: 6108.7ms)
```

The view takes 6 seconds to load. The AR querying takes 6 seconds to load. The page takes 12 seconds to load. That's not great.

What can we do?

Well, let's focus on improving the view and the querying!

Complete this tutorial first:
[Jumpstart Lab Tutorial on Querying](http://tutorials.jumpstartlab.com/topics/performance/queries.html)
