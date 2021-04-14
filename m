From: zhaogongyi <zhaogongyi@huawei.com>
Date: Wed, 14 Apr 2021 12:18:08 +0000
Subject: [LTP] [PATCH v2] controllers/memcg: Add testcase for
 kmem_limit_in_bytes of memory cgroup
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B5467@dggeml531-mbx.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

That's right. I have a Misunderstanding of cgroup.procs. Actrually, we can write pid or tgid to cgroup.procs instead of pgid.

I'll update the code as:

	SAFE_FILE_PRINTF(CGROUP_PROCS, "%d", getpid());

BTW I find that the testcase run passed on my local system, it seems that tst_* will not trig memory allocation:

tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
memcg_kmem_limit_in_bytes.c:58: TPASS: fork fail as expected
memcg_kmem_limit_in_bytes.c:73: TPASS: kmem alloc is controled by memory.kmem.limit_in_bytes

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0


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
> > Calling setpgid in this testcase is aim to make the task group be
> controlled by memory.kmem.limit_in_bytes since we have set the pgid to
> cgroup.procs.
> >
> 
> Please see cgroup_procs_write_start in cgroup/cgroup.c. It calls
> find_task_by_vpid which interprets pid as PIDTYPE_PID not PIDTYPE_PGID.
> 
> --
> Thank you,
> Richard.
