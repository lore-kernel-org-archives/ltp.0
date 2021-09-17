From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Fri, 17 Sep 2021 09:59:23 +0000
Subject: [LTP] [PATCH v3 4/5] syscalls/dup2/dup205: Convert to new API
In-Reply-To: <OSZPR01MB64547BE94AEC979C8E0AFF1FF7DD9@OSZPR01MB6454.jpnprd01.prod.outlook.com>
References: <20210916104933.33409-1-qi.fuli@fujitsu.com>
 <20210916104933.33409-5-qi.fuli@fujitsu.com>
 <bcc00ba4-2e7d-8ec3-2856-6cde6d45b587@163.com>
 <OSZPR01MB64547BE94AEC979C8E0AFF1FF7DD9@OSZPR01MB6454.jpnprd01.prod.outlook.com>
Message-ID: <61446711.4020101@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All
>> Subject: Re: [LTP] [PATCH v3 4/5] syscalls/dup2/dup205: Convert to new API

>>> +
>>> +	if (TST_ERR != EBADF)
>>> +		tst_res(TFAIL, "bad errno on dup2 failure");
>>
>> Hi Qi,
>>
>> Why do you only check EBADF? The old test checks three errno.
>
> Thanks for the comments.
> Both Xu and I got the failures with EBADF,
> so I think that checking EINVAL and ENFILE is not necessary.
Yes, My machine fails with EBADF.
Look this case history, it said nothing about why need three checks.
But kernel code in 4e1e018ecc6f ("PATCH] fix RLIM_NOFILE handling
") ,

it seems old kernel will return EINVAL when rlimit set to 0.
Then will return ENFILE when rlimit set to 0.


And now it looks only fails with EBADF from kernel fs/file.c code.

> I wonder your opinion.
>>
>>> +
>>> +	if (ifile<  min)
>>> +		tst_res(TFAIL, "Not enough files duped");
>>> +	else if (ifile>  min)
>>> +		tst_res(TFAIL, "Too many files duped");
>>> +	else
>>> +		tst_res(TPASS, "Test passed.");
>>> +
>>> +	SAFE_CLOSE(fildes[0]);
>>
>> Why do you close only fildes[0]?
>
> I did try close all fildes[ifile], and it occurred close(-1).
> After talking with Xu, we think that close oldfd is enough.
I think we don't need to close all filedes because dup2 can close newfd
before reuse.  We should close them in cleanup function.

Best Regards
Yang Xu
>
> Best,
> QI
>
>>
>> Best Regards,
>>
>> Xiao Yang
>>
>>> +	SAFE_UNLINK(pfilname);
>>> +}
>>> +
>>> +static struct tst_test test = {
>>> +	.needs_tmpdir = 1,
>>> +	.test_all = run,
>>> +	.setup = setup,
>>> +	.cleanup = cleanup,
>>> +};
>
