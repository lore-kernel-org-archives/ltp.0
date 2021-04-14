From: zhaogongyi <zhaogongyi@huawei.com>
Date: Wed, 14 Apr 2021 06:40:53 +0000
Subject: [LTP] [PATCH v2] controllers/memcg: Add testcase for
 kmem_limit_in_bytes of memory cgroup
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B507A@dggeml531-mbx.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

Thanks so much for your review!

> >> > +	pid = SAFE_FORK();
> >> > +	if (!pid) {
> >> > +		SAFE_SETPGID(0, 0);
> >> > +
> >> > +		SAFE_FILE_PRINTF(KMEM_LIMIT_IN_BYTES, "%d", 0);
> >> > +
> >> > +		SAFE_FILE_PRINTF(CGROUP_PROCS, "%d", getpgid(getpid()));
> >>
> >> After setting this we should avoid doing any work in this process
> >> except calling fork. AFAIK there is no guarantee that some other
> >> syscall or tasklet etc. Won't try to allocate memory and also fail.
> >>
> >
> > It seems that we would not be afraid since there is no asynchronous
> > operation in the test process.
> 
> IIRC one of the problems with tasklets is they can run in any process. Also,
> in theory stdout can point to anything. So write() might allocate memory.
> 
> Why not do something like:
> 
> SAFE_FILE_PRINTF(CGROUP_PROCS, "%d", getpgid(getpid())); errno = 0;
> fork(); exit(errno);
> 
> Then check that errno == ENOMEM, in the parent process?
>
>
>> > +		TEST(fork());
>> > +		if (TST_RET == -1) {
>> > +			if (TST_ERR == ENOMEM)
>> > +				tst_res(TPASS, "fork fail as expected");
>> > +			else
>> > +				tst_brk(TFAIL | TTERRNO,
>> > +					"fork fail as unexpected");

As far as my personal understanding, after setpgid, the controlled process is the sub process whose process id is pid, excluded from the parent process, and the functions tst_res or tst_brk
Is executed in its parent process.

In this case, is it no affection to this test?


Best Regards,
Gongyi
