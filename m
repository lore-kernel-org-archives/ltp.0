From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 10 Jun 2020 16:21:22 +0800
Subject: [LTP] [PATCH v2] LIB: Use INTERNAL_LIB for ltp lib
In-Reply-To: <20200610080529.GA19781@dell5510>
References: <57a1c19e-d8e5-4389-8565-20e49f144657@G08CNEXMBPEKD05.g08.fujitsu.local>
 <78176e41-03c4-e75b-594b-20731b2d4dfd@cn.fujitsu.com>
 <20200610080529.GA19781@dell5510>
Message-ID: <2845dc64-cce0-47df-1005-4cc508bd9388@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr

> Hi Xu,
> 
>> Hi Petr
> 
>> Nothing blocks this simple patch, I guess we can directly push this
>> patch(don't forget jan's acked-by).
> 
> I guess you missed librealtime.a in (testcases/realtime/lib/Makefile).
Yes.
> 
> Maybe removing libdir could be in separate commit, it looks to me as unrelated
> change.
> 
Agree.
> And you haven't replied to my question:
> https://lists.linux.it/pipermail/ltp/2020-June/017495.html
> 
> But newer mind :). Maybe it's just me, but "Also include Android_libpthread and
> android_librt." is not clear to me. I'd phrase it: "Also change Android_libpthread and
> android_librt" (because include is ambiguous, when we're trying not to
> install/include these statically linked libraries.
Yes, My meaning is that v1 does not modify 
Android_libpthread/android_librt, and v2 does this. Using modify is better.

> 
> BTW if you ack it, I can do this changes before merge.
acked.

Best Regards
Yang Xu
> 
> Kind regards,
> Petr
> 
> 


