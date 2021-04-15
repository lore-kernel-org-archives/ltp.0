From: zhaogongyi <zhaogongyi@huawei.com>
Date: Thu, 15 Apr 2021 03:30:52 +0000
Subject: [LTP] [PATCH v2] controllers/memcg: Add testcase for
 kmem_limit_in_bytes of memory cgroup
Message-ID: <7d9792a7d9d742efbbbc567b316417d2@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard, Cyril,

Thanks for your review!

1) I can't agree with you more that correctly written test depends on valid assumptions we can make about the operation system the test is supposed to run on

2)when we use tst_res/tst_brk to print information to STDIO, it seems have not trig kmem allocation, I have checked the kernel log,
there is only one malloc failed log in dmesg info. And we can see the STDIO info is printed as expected. 

3)when we use tst_res/tst_brk to print information to other file, it might trig memory alloction. So, we need remove the calling of tst_res/tst_brk for safety.

I have resubmit the patch according to your review, please see: https://patchwork.ozlabs.org/project/ltp/patch/20210415032911.7542-1-zhaogongyi@huawei.com/


Thanks very much!

Best Regards,
Gongyi

> 
> Hello,
> 
> zhaogongyi <zhaogongyi@huawei.com> writes:
> 
> > Hi Richard,
> >
> > That's right. I have a Misunderstanding of cgroup.procs. Actrually, we can
> write pid or tgid to cgroup.procs instead of pgid.
> >
> > I'll update the code as:
> >
> > 	SAFE_FILE_PRINTF(CGROUP_PROCS, "%d", getpid());
> >
> > BTW I find that the testcase run passed on my local system, it seems
> > that tst_* will not trig memory allocation:
> 
> After a short search I found do_tty_write can return ENOMEM due to a
> call to kmalloc with GFP_KERNEL.
> 
> As I said previously stderr can point to many things with different write
> implementations. Some of these are likely to trigger memory allocation.
> Please see my previous reply and suggestion.
> 
> Also please note the warning message in the kernel log when using
> memory.kmem.limit_in_bytes.
> 
> >
> > tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
> > memcg_kmem_limit_in_bytes.c:58: TPASS: fork fail as expected
> > memcg_kmem_limit_in_bytes.c:73: TPASS: kmem alloc is controled by
> > memory.kmem.limit_in_bytes
> >
> > Summary:
> > passed   2
> > failed   0
> > broken   0
> > skipped  0
> > warnings 0
> >
> >
> > Thanks very much!
> >
> > Best Regards,
> > Gongyi
> >
> >>
> >> Hello,
> >>
> >> zhaogongyi <zhaogongyi@huawei.com> writes:
> >>
> >> > Hi Richard,
> >> >
> >> > Calling setpgid in this testcase is aim to make the task group be
> >> controlled by memory.kmem.limit_in_bytes since we have set the pgid
> >> to cgroup.procs.
> >> >
> >>
> >> Please see cgroup_procs_write_start in cgroup/cgroup.c. It calls
> >> find_task_by_vpid which interprets pid as PIDTYPE_PID not
> PIDTYPE_PGID.
> >>
> >> --
> >> Thank you,
> >> Richard.
> 
> 
> --
> Thank you,
> Richard.
