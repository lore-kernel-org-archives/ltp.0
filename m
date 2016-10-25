From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 25 Oct 2016 14:08:55 +0800
Subject: [LTP] [PATCH 1/2] syscalls/quotatcl01.c: Rewrite && Convert to
 new API
In-Reply-To: <20161024104928.GA19167@rei.lan>
References: <1477032835-11570-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20161024104928.GA19167@rei.lan>
Message-ID: <580EF6F7.5090507@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2016/10/24 18:49, Cyril Hrubis wrote:
> Hi!
>> -	tst_parse_opts(ac, av, (option_t *) opts, NULL);
>> +	pid = SAFE_FORK();
>> +	if (!pid)
>> +		create_qf();
>>
>> -	setup();
>> +	SAFE_WAITPID(pid, NULL, 0);
> Just use tst_run_cmd() instead of the fork(), execlp(), wait() combo and
> remove the forks_child flag.
>
>> -	for (lc = 0; TEST_LOOPING(lc); ++lc) {
>> +	test_id = geteuid();
>>
>> -		tst_count = 0;
>> +	sprintf(usr_path, "%s/%s", mntpoint, usr_qf);
>> +	sprintf(grp_path, "%s/%s", mntpoint, grp_qf);
> Well these strings could be compile time constants. If you do:
>
> #define MNTPOINT "mntpoint"
>
> #ifdef HAVE_QUOTAV2
> # define USR_PATH MNTPOINT "aquota.user"
> ...
> #else
> # define USR_PATH MNTPOINT "quota.user"
> ...
> #endif
>
> But that is a minor issue.
>
> And yes, the inner block of #ifdef should ideally be indented with
> single space per block as in the example snipped above, but that is even
> more minor.
>
Hi Cyril,

Thanks for your review, I will rewrite it as you said.

Thanks,
Xiao Yang


