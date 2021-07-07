From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Wed, 7 Jul 2021 04:30:22 +0000
Subject: [LTP] [PATCH] shmget03: fix test when some shm segments already
 exist
In-Reply-To: <CAEemH2fKXJmgKAr4JXW5y+dcgEwL1taobXLY7OdTWBzLXGVOYg@mail.gmail.com>
References: <20210706105758.43220-1-aleksei.kodanev@bell-sw.com>
 <CAEemH2cOm+1BMWE7oWVFttXNOeQsYk9veXePS+ctxAABk2rCWQ@mail.gmail.com>
 <c2c7ff46-df28-c7b6-49dd-c891d9655d00@bell-sw.com>
 <381b8420-3dba-d7c1-027c-e2e2adc719de@bell-sw.com>
 <60E50890.9040903@fujitsu.com>
 <CAEemH2fKXJmgKAr4JXW5y+dcgEwL1taobXLY7OdTWBzLXGVOYg@mail.gmail.com>
Message-ID: <60E52E00.8020105@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li
> Hi Xu,
>
> xuyang2018.jy@fujitsu.com <mailto:xuyang2018.jy@fujitsu.com>
> <xuyang2018.jy@fujitsu.com <mailto:xuyang2018.jy@fujitsu.com>> wrote:
>
>     If we use this old format, then we can not ensure whether we trigger
>     the
>     ENOSPC errer correctly when reaching the expected nums.
>
>     So to avoid the existed memory segments error, I think we should alter
>     get_used_queus api to count the existed memory segments by adding a
>     file argument.
>
>
> Just as Alex pointed, if there are some resources be freedafter invoking
> get_used_queus, then the value of existed_cntwill be imprecise, how do
> you think that affects the test result?

We can move this count api and the create phase into verify* function, 
but still exist the chance to free resource after invoking get_used_queues.

We can't avoid it because /proc/sys/kernel/shmmni is designed for all 
user instead of the calling process.

I think it is common in ltp because user also can set a different value 
after we use ltp api to set proc value.

But if we only use for loop to trigger the ENOSPC error, it goes against 
the test's aim(see old shmget03.c, it also does the same thing as I do, 
it doesn't trigger error because it uses a big value than default 4096).

Since this case only wastes a little time when run, I don't think we 
should avoid rare race to give up to test the ENOSPC error when reaching 
the expected num.

Also, Let's listen advise from other maintainers.
@Cyril,Petr

Best Regards
Yang Xu

>
>
> --
> Regards,
> Li Wang
