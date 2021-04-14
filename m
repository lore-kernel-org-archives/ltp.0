From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 14 Apr 2021 09:04:19 +0100
Subject: [LTP] [PATCH v2] controllers/memcg: Add testcase for
 kmem_limit_in_bytes of memory cgroup
In-Reply-To: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B507A@dggeml531-mbx.china.huawei.com>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B507A@dggeml531-mbx.china.huawei.com>
Message-ID: <87im4p2sxo.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

zhaogongyi <zhaogongyi@huawei.com> writes:

> Hi Richard,
>
> Thanks so much for your review!
>
>> >> > +	pid = SAFE_FORK();
>> >> > +	if (!pid) {
>> >> > +		SAFE_SETPGID(0, 0);
>> >> > +
>> >> > +		SAFE_FILE_PRINTF(KMEM_LIMIT_IN_BYTES, "%d", 0);
>> >> > +
>> >> > +		SAFE_FILE_PRINTF(CGROUP_PROCS, "%d", getpgid(getpid()));
>> >>
>> >> After setting this we should avoid doing any work in this process
>> >> except calling fork. AFAIK there is no guarantee that some other
>> >> syscall or tasklet etc. Won't try to allocate memory and also fail.
>> >>
>> >
>> > It seems that we would not be afraid since there is no asynchronous
>> > operation in the test process.
>> 
>> IIRC one of the problems with tasklets is they can run in any process. Also,
>> in theory stdout can point to anything. So write() might allocate memory.
>> 
>> Why not do something like:
>> 
>> SAFE_FILE_PRINTF(CGROUP_PROCS, "%d", getpgid(getpid())); errno = 0;
>> fork(); exit(errno);
>> 
>> Then check that errno == ENOMEM, in the parent process?
>>
>>
>>> > +		TEST(fork());
>>> > +		if (TST_RET == -1) {
>>> > +			if (TST_ERR == ENOMEM)
>>> > +				tst_res(TPASS, "fork fail as expected");
>>> > +			else
>>> > +				tst_brk(TFAIL | TTERRNO,
>>> > +					"fork fail as unexpected");
>
> As far as my personal understanding, after setpgid, the controlled process is the sub process whose process id is pid, excluded from the parent process, and the functions tst_res or tst_brk
> Is executed in its parent process.

setpgid(0, 0) sets the process group id (pgid) to be the same as the
(pid), which creates a new process group. This probably has the effect
that the calling process will not recieve signals from the
terminal. Also it should receive SIGTTOU when calling tst_res and
tst_brk, if stdout/stderr point to a terminal with the right
configuration.

AFAICT process groups are for shells and affect where signals are
sent. Nothing else.

>
> In this case, is it no affection to this test?
>
>
> Best Regards,
> Gongyi


-- 
Thank you,
Richard.
