From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 18 Nov 2020 14:17:59 +0800
Subject: [LTP] [PATCH] pan/ltp-pan.c: fix file descriptors leaks
In-Reply-To: <5FAB4274.6090505@cn.fujitsu.com>
References: <1604925271-4811-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <20201109125938.GC9991@yuki.lan> <5FA9ED44.7080909@cn.fujitsu.com>
 <5FAA0151.3030002@cn.fujitsu.com> <20201110102641.GA11262@yuki.lan>
 <5FAB4274.6090505@cn.fujitsu.com>
Message-ID: <5FB4BC97.8030300@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr
> Hi Cyril
>> Hi!
>>>> Yes, musl-libc doesn't support "e" mode for fopen[1].
>>> Sorry, I ignore __fmodeflags function, musl libc supports "e" mode since
>>> 0.9.7 after this commit 8582a6e9f ("add 'e' modifier (close-on-exec) to
>>> fopen and fdopen").
>>>
>>> https://git.musl-libc.org/cgit/musl/commit/src?id=8582a6e9f25dd7b87d72961f58008052a4cac473
>>>
>>>
>>> It is about 8 years since musl libc fopen() supports "e". glibc2.7
>>> fopen() supports "e" is about 13 years. Maybe we can use "e" mode now?
>>
>> To be honest I haven't had used ltp-pan for last two years, so if that
>> change works for everyone still using it, then we can go ahead with it.
> OK. I will wait a week. If nobody has objection, I will merge it.
I plan to merge this patch today. Before it, I want to listen some 
advise from you( IMO, you know musl-libc a lot and other libc on 
embedded system).
>
> Best Regards
> Yang Xu
>>
>



