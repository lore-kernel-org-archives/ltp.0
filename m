Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MOCfw-00057L-Fq
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:33:44 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOCfr-00014Q-T4
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:33:44 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n67FaoJM006433
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 11:36:50 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n67FWBfM1171618
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 11:32:12 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n67FW2oQ026630
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 09:32:02 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200907071038.n67Aciix025927@e33.co.us.ibm.com>
References: <200907071038.n67Aciix025927@e33.co.us.ibm.com>
Date: Tue, 07 Jul 2009 21:01:58 +0530
Message-Id: <1246980718.5539.40.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix failures of the clock_nanosleep01 test
Reply-To: subrata@linux.vnet.ibm.com
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2009-07-07 at 01:29 +0200, Jiri Palecek wrote: 
> The failures were caused by strange interpretation of POSIX by the test:
> 
>   - POSIX says CLOCK_THREAD_CPUTIME_ID is an invalid value for the
>     clock_id parameter, and results in an EINVAL
> 
>   - POSIX doesn't specify that the remaining time should be set in any
>     way (eg. zeroed) on successful completion
> 
> Also, the test deletes some of the superfluous uses of the TEST macro.
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks. It solved the problem for me atleast.

Regards--
Subrata

> ---
>  .../syscalls/clock_nanosleep/clock_nanosleep01.c   |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
> index 603201c..3c17a5c 100644
> --- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
> +++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
> @@ -211,7 +211,7 @@ static struct test_case tcase[] = {
>                  .flags          = 0,
>                  .sec            = 0,
>                  .nsec           = 500000000, // 500msec
> -                .ret            = ENOTSUP, // RHEL4U1 + 2.6.18 returns EINVAL
> +                .ret            = EINVAL, // RHEL4U1 + 2.6.18 returns EINVAL
>                  .err            = 0,
>          },
>          { // case05
> @@ -256,8 +256,8 @@ static int chk_difftime(struct timespec *bef, struct timespec *aft,
>                  t.tv_sec -= 1;
>                  t.tv_nsec += 1000000000;
>          }
> -        TEST(expect = (sec * 1000) + (nsec / 1000000));
> -        TEST(result = (t.tv_sec * 1000) + (t.tv_nsec / 1000000));
> +        expect = (sec * 1000) + (nsec / 1000000);
> +        result = (t.tv_sec * 1000) + (t.tv_nsec / 1000000);
>          tst_resm(TINFO,"check sleep time: (min:%ld) < %ld < (max:%ld) (msec)",expect - MAX_MSEC_DIFF, result, expect + MAX_MSEC_DIFF);
>          if (result < expect - MAX_MSEC_DIFF || result > expect + MAX_MSEC_DIFF)
>                  return -1;
> @@ -331,7 +331,7 @@ TEST_END:
>          if (tc->ttype == NORMAL || tc->ttype == SEND_SIGINT) {
>                  tst_resm(TINFO,"remain time: %ld %ld", rm.tv_sec, rm.tv_nsec);
>                  if (tc->ttype == NORMAL)
> -                        remain_ok = rm.tv_sec == 0 && rm.tv_nsec == 0;
> +                        remain_ok = 1;
>                  else
>                          remain_ok = rm.tv_sec != 0 || rm.tv_nsec != 0;
>          }


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
