From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 28 Mar 2019 17:40:25 +0800
Subject: [LTP] [PATCH] syscalls/stime: Use 3 variants via
	test_multiplex()
In-Reply-To: <20190328065243.GB11011@x230>
References: <1553668210-6141-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20190328065243.GB11011@x230>
Message-ID: <5C9C9689.8060508@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/03/28 14:52, Petr Vorel wrote:
> Hi Xiao,
>
>> diff --git a/testcases/kernel/syscalls/stime/stime01.c b/testcases/kernel/syscalls/stime/stime01.c
> ...
>> +static int do_stime(time_t *ntime)
>> +{
>> +	switch (tst_variant) {
>> +	case 0:
>> +#ifdef __ANDROID__
>> +		tst_brk(TCONF, "libc stime() is not implemented for Android");
> IMHO this is not optimal. 1) That might change in the future, 2) Why not to fix
> it for other foo libc implementations, which might suffer the same problem.
> Therefore IMHO autotools check should be used.
>
Hi Petr,

Sorry, i pushed roughly. :-(
I have sent a patch set as you suggested, so could you help me review it?

Best Regards,
Xiao Yang
>> +#else
>> +		return stime(ntime);
>> +#endif
>> +	case 1:
>> +		return tst_syscall(__NR_stime, ntime);
>> +	case 2: {
>> +		struct timeval tv;
>> +
>> +		tv.tv_sec = *ntime;
>> +		tv.tv_usec = 0;
>> +
>> +		return tst_syscall(__NR_settimeofday,&tv, (struct timezone *) 0);
>> +	}
>> +	}
> Kind regards,
> Petr
>
>
>



