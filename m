From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 Jun 2020 10:05:29 +0200
Subject: [LTP] [PATCH v2] LIB: Use INTERNAL_LIB for ltp lib
In-Reply-To: <78176e41-03c4-e75b-594b-20731b2d4dfd@cn.fujitsu.com>
References: <57a1c19e-d8e5-4389-8565-20e49f144657@G08CNEXMBPEKD05.g08.fujitsu.local>
 <78176e41-03c4-e75b-594b-20731b2d4dfd@cn.fujitsu.com>
Message-ID: <20200610080529.GA19781@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> Hi Petr

> Nothing blocks this simple patch, I guess we can directly push this
> patch(don't forget jan's acked-by).

I guess you missed librealtime.a in (testcases/realtime/lib/Makefile).

Maybe removing libdir could be in separate commit, it looks to me as unrelated
change.

And you haven't replied to my question:
https://lists.linux.it/pipermail/ltp/2020-June/017495.html

But newer mind :). Maybe it's just me, but "Also include Android_libpthread and
android_librt." is not clear to me. I'd phrase it: "Also change Android_libpthread and
android_librt" (because include is ambiguous, when we're trying not to
install/include these statically linked libraries.

BTW if you ack it, I can do this changes before merge.

Kind regards,
Petr
