Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VgDlU-0003sA-OS
	for ltp-list@lists.sourceforge.net; Tue, 12 Nov 2013 13:12:20 +0000
Date: Tue, 12 Nov 2013 14:12:08 +0100
From: chrubis@suse.cz
Message-ID: <20131112131208.GB27040@rei>
References: <1383883144.2945.1.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383883144.2945.1.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2] clock_getres/clock_getres01.c: cleanup
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
To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> -struct test_case {
> +static struct test_case {
> +	char *name;
>  	clockid_t clk_id;
>  	int ttype;
>  	int ret;
>  	int err;
> +} tcase[] = {
> +	{"CLOCK_REALTIME", CLOCK_REALTIME, NORMAL, 0, 0,},
> +	{"CLOCK_MONOTONIC", CLOCK_MONOTONIC, NORMAL, 0, 0,},
> +	{"CLOCK_PROCESS_CPUTIME_ID", CLOCK_PROCESS_CPUTIME_ID, NORMAL, 0, 0,},
> +	{"CLOCK_THREAD_CPUTIME_ID", CLOCK_THREAD_CPUTIME_ID, NORMAL, 0, 0,},
> +	{"-1", -1, NORMAL, -1, EINVAL, },
> +	{"CLOCK_REALTIME", CLOCK_REALTIME, NULL_POINTER, 0, 0,},
>  };

Remove comas at the end of the list too.

> +		for (i = 0; i < TST_TOTAL; ++i) {
> +			if (tcase->ttype == NULL_POINTER)
> +				TEST(clock_getres(tcase->clk_id, NULL));
> +			else
> +				TEST(clock_getres(tcase->clk_id, &res));
> +
> +			if (TEST_RETURN != 0) {
> +				if (TEST_ERRNO == EINVAL) {
> +					tst_resm(TCONF, "clock_getres %s not "
> +						 "supported", tcase[i].name);
> +				} else {
> +					tst_resm(TFAIL, "clock_getres %s"
> +						 "failed", tcase[i].name);
>  				}

The tcase->ttype and tcase->clk_id is wrong, it should be tcase[i].ttype
and tcase[i].clk_id, otherwise you are testing only the first structure
from the tcase array again and again while the tst_resm() testcases
lists different clock id names.

Moreover you should check against expected return value and expected
errno, i.e. tcase[i].ret and tcase[i].err. And return TCONF only in case
that the expected return value is 0 (success) and is not and errno is
set to EINVAL.

Also do not abort the test on first failure, (i.e. remove the cleanup
and exit if returned value does not match the expected one).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
