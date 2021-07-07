From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Wed, 7 Jul 2021 01:59:49 +0000
Subject: [LTP] [PATCH] shmget03: fix test when some shm segments already
 exist
In-Reply-To: <CAEemH2fcubrbMpeoeSJJoZtD+xaiRrs_upG_+KQXB_8C9m3eQg@mail.gmail.com>
References: <20210706105758.43220-1-aleksei.kodanev@bell-sw.com>
 <CAEemH2cOm+1BMWE7oWVFttXNOeQsYk9veXePS+ctxAABk2rCWQ@mail.gmail.com>
 <c2c7ff46-df28-c7b6-49dd-c891d9655d00@bell-sw.com>
 <381b8420-3dba-d7c1-027c-e2e2adc719de@bell-sw.com>
 <CAEemH2fcubrbMpeoeSJJoZtD+xaiRrs_upG_+KQXB_8C9m3eQg@mail.gmail.com>
Message-ID: <60E50AB4.7050404@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, Alexey
> Alexey Kodanev <aleksei.kodanev@bell-sw.com
> <mailto:aleksei.kodanev@bell-sw.com>> wrote:
>
>
>     It's also possible that some resources will be freed during
>     the tests... perhaps, moving the loop to verify_*() is the
>     better option?
>
>
> Yes, good point, that would be more precise for ENOSPC testing.
AFAIK, ltp doesn't support parallel test now. I think parallel test 
maybe a future plan that is why we use docparase to collect each case's 
used resources(so we can convert many groups, like pid, memory, disk 
space..., then we can run pid group and memory groups test case parallelly).

This is my understanding. If wrong, please correct me.

Best Regards
Yang Xu
>
>
> --
> Regards,
> Li Wang
