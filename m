From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 19 Jul 2017 16:02:39 +0200
Subject: [LTP] [PATCH v3 7/9] Test for CVE-2017-5669 in shmat
In-Reply-To: <20170719131953.GI1015@rei.lan>
References: <20170623122211.29575-1-rpalethorpe@suse.com>
 <20170623122211.29575-8-rpalethorpe@suse.com> <20170719131953.GI1015@rei.lan>
Message-ID: <871spcr0cg.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Cyril,

Cyril Hrubis writes:

> Hi!
>> +static void cleanup(void)
>> +{
>> +	if (shm_addr)
>> +		SAFE_SHMDT(shm_addr);
>> +	shm_addr = 0;
>> +
>> +	if (shm_id)
>> +		SAFE_SHMCTL(shm_id, IPC_RMID, 0);
>> +	shm_id = 0;
>> +}
>> +
>> +static void run(void)
>> +{
>> +	shm_id = SAFE_SHMGET(IPC_PRIVATE, getpagesize(), 0777);
>
> Shouldn't be this done once in the test setup()?

Yes.

>
>> +	tst_res(TINFO, "Attempting to attach shared memory to null page");
>> +	shm_addr = shmat(shm_id, ((void *)1), SHM_RND);
>> +	if (shm_addr == (void *)-1) {
>> +		if (errno == EINVAL) {
>> +			tst_res(TPASS, "shmat returned EINVAL");
>> +			shm_addr = 0;
>> +			return;
>> +		}
>> +		tst_brk(TBROK | TERRNO,
>> +			"The bug was not triggered, but the shmat error is unexpected");
>> +	}
>> +
>> +	tst_res(TINFO, "Mapped shared memory to %p", shm_addr);
>> +
>> +	if (!((size_t)shm_addr & (~0U << 16)))
>> +		tst_res(TFAIL,
>> +			"We have mapped a VM address within the first 64Kb");
>> +	else
>> +		tst_res(TPASS,
>> +			"The kernel assigned a different VM address");
>> +
>> +	((char *)shm_addr)[0] = 'P';
>
> Why do we try to write to the addres at all?
>
> We do PASS/FAIL decision based only on the addres returned from
> shmat().

To see if anything interesting happens, like a segfault. I don't think
anything is likely to happen, but it seemed worth leaving in at the
time.

>
> Also we should detach the memory here in case that the test was called
> with -i parameter.

OK.

-- 
Thank you,
Richard.
