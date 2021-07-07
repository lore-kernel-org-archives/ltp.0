From: Li Wang <liwang@redhat.com>
Date: Wed, 7 Jul 2021 10:21:02 +0800
Subject: [LTP] [PATCH] shmget03: fix test when some shm segments already
 exist
In-Reply-To: <60E50890.9040903@fujitsu.com>
References: <20210706105758.43220-1-aleksei.kodanev@bell-sw.com>
 <CAEemH2cOm+1BMWE7oWVFttXNOeQsYk9veXePS+ctxAABk2rCWQ@mail.gmail.com>
 <c2c7ff46-df28-c7b6-49dd-c891d9655d00@bell-sw.com>
 <381b8420-3dba-d7c1-027c-e2e2adc719de@bell-sw.com>
 <60E50890.9040903@fujitsu.com>
Message-ID: <CAEemH2fKXJmgKAr4JXW5y+dcgEwL1taobXLY7OdTWBzLXGVOYg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com> wrote:


> If we use this old format, then we can not ensure whether we trigger the
> ENOSPC errer correctly when reaching the expected nums.
>
> So to avoid the existed memory segments error, I think we should alter
> get_used_queus api to count the existed  memory segments by adding a
> file argument.
>

Just as Alex pointed, if there are some resources be freed after invoking
get_used_queus, then the value of existed_cnt will be imprecise, how do
you think that affects the test result?


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210707/4126b872/attachment.htm>
