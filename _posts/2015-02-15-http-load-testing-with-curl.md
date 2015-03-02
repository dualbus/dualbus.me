---
layout: post
title: HTTP load testing with curl
categories: curl linux
---

It's easy to use the curl command to load test a website. We'll (ab)use the
-K/--config option, to pass a configuration file like this:

    silent = 1
    output = "/dev/null"
    write-out = "%{http_code} %{time_total}\n"
    url = "http://dualbus.me/{,}{,}{,}{,,,,}{,,,,}{,,,,}"

The interesting part is the `url`. We're requesting the same URL 1,000 times.
(2x2x2x5x5x5). An easy way to compute that string:

    dualbus@hp ~ % factor 1000
    1000: 2 2 2 5 5 5

Now, you can use GNU xargs to do some requests in parallel (assuming you placed
the configuration in `config.txt`):

    printf '%.0sconfig.txt\n' {1..20} | xargs -P 20 -n 1 curl -K

Enjoy.

* * *

## Updates

2015-02-15: [This answer](http://serverfault.com/a/358464) from Ian Purton
shows a different way of doing it (with ranges instead of alternations), so you
can do: `curl 'http://domain.name/#[1-100]'`.
