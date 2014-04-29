Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WfAch-0005xw-U7
	for ltp-list@lists.sourceforge.net; Tue, 29 Apr 2014 16:11:11 +0000
Date: Tue, 29 Apr 2014 18:10:16 +0200
From: chrubis@suse.cz
Message-ID: <20140429161016.GF12523@rei>
References: <1395991214.5017.2.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395991214.5017.2.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] read/read02.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> -#ifndef UCLINUX
> -	    /* Skip since uClinux does not implement memory protection */
> -	    /* the buffer is invalid - EFAULT */
> -	{
> -	&fd3, (void *)-1, EFAULT}
> -#endif
> +	{&badfd, buf, EBADF},
> +	{&fd2, buf, EISDIR},
> +	{&fd3, (void *)-1, EFAULT},
>  };

Removing the ifdefs breaks the testcases on uClinux, please keep them
there.

> -#if !defined(UCLINUX)
> -	bad_addr = mmap(0, 1, PROT_NONE,
> -			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
> -	if (bad_addr == MAP_FAILED) {
> -		tst_brkm(TBROK, cleanup, "mmap failed");
> +
> +	TEST_ERROR_LOG(TEST_ERRNO);
> +
> +	if (TEST_ERRNO == test->exp_error) {
> +		tst_resm(TPASS | TTERRNO, "expected failure - errno = %d : %s",
> +			 TEST_ERRNO, strerror(TEST_ERRNO));
> +	} else {
> +		tst_resm(TFAIL | TTERRNO,
> +			 "unexpected error - %d : %s - expected %d",
> +			 TEST_ERRNO, strerror(TEST_ERRNO), test->exp_error);
>  	}
> -	TC[2].buf = bad_addr;
> -#endif

And removing the mmap() possibly breaks the testcases on platforms where
there is something mapped on address (void*)-1. Looking at the git log,
this may be case for some 64 bit machines (at least this is what the
patch from 2002 says).

Given that we have quite a lot of testcases that passes addresses that
are expected to generate EFAULT to various syscalls we should unify the
way these are generated.

I would go for creating tst_bad_addr() function that would replace all
the adhoc (and posibly wrong) definitions. I will look into that asap.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
