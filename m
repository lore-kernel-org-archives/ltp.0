Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MryHl-0005is-Mv
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:15:49 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MryHh-0007dr-R7
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:15:49 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8RI6UU3004440
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 14:06:30 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8RIFeFs254356
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 14:15:40 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8RIFerC032341
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 14:15:40 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200909241421.n8OELZvo008862@e5.ny.us.ibm.com>
References: <200909241421.n8OELZvo008862@e5.ny.us.ibm.com>
Date: Sun, 27 Sep 2009 23:45:10 +0530
Message-Id: <1254075312.10457.23.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Add a test for race-free operation of ppoll
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

On Thu, 2009-07-30 at 12:17 +0200, Jiri Palecek wrote: 
> Hello,
> 
> after the previous patch, this patch adds a test to test a use of ppoll() without races (ie. the intended use of ppoll). It blocks the signal, schedules a signal to be delivered and expects ppoll to return EINTR (and never lose the signal.
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/ppoll/ppoll01.c |   53 ++++++++++++++++++++++++++--
>  1 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
> index a04935c..507eddc 100644
> --- a/testcases/kernel/syscalls/ppoll/ppoll01.c
> +++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
> @@ -155,6 +155,7 @@ enum test_type {
>          TIMEOUT,
>          FD_ALREADY_CLOSED,
>          SEND_SIGINT,
> +        SEND_SIGINT_RACE_TEST,
>          INVALID_NFDS,
>          INVALID_FDS,
>          MINUS_NSEC,
> @@ -219,22 +220,27 @@ static struct test_case tcase[] = {
>                  .err            = EINTR,
>          },
>          { // case05
> +                .ttype          = SEND_SIGINT_RACE_TEST,
> +                .ret            = -1,
> +                .err            = EINTR,
> +        },
> +        { // case06
>                  .ttype          = INVALID_NFDS,
>                  .ret            = -1,
>                  .err            = EINVAL,
>          },
> -        { // case06
> +        { // case07
>                  .ttype          = INVALID_FDS,
>                  .ret            = -1,
>                  .err            = EFAULT,
>          },
>  #if 0
> -        { // case07
> +        { // case08
>                  .ttype          = MINUS_NSEC,
>                  .ret            = -1,
>                  .err            = EINVAL, // RHEL4U1 + 2.6.18 returns SUCCESS
>          },
> -        { // case08
> +        { // case09
>                  .ttype          = TOO_LARGE_NSEC,
>                  .ret            = -1,
>                  .err            = EINVAL, // RHEL4U1 + 2.6.18 returns SUCCESS
> @@ -306,6 +312,29 @@ static int do_test(struct test_case *tc)
>                  if (pid < 0)
>                          return 1;
>                  break;
> +  case SEND_SIGINT_RACE_TEST:
> +    /* block the INT signal */
> +                sigemptyset(&sigmask);
> +                sigaddset(&sigmask, SIGINT);
> +                sigprocmask(SIG_SETMASK, &sigmask, NULL);
> +
> +                /* and let it be unblocked when the syscall runs */
> +                sigemptyset(&sigmask);
> +                p_sigmask = &sigmask;
> +                //sigsetsize = sizeof(sigmask);
> +                sigsetsize = 8;
> +                nfds = 0;
> +                ts.tv_sec = 0;
> +                ts.tv_nsec = 300000000; // 300msec => need to be enough for
> +                                        //   waiting the signal
> +                p_ts = &ts;
> +                nfds = 0;
> +                pid = create_sig_proc(0, SIGINT, 1);
> +                if (pid < 0) {
> +                  result=1;
> +                  goto cleanup;
> +                }
> +                break;
>          case INVALID_NFDS:
>                  //nfds = RLIMIT_NOFILE + 1; ==> RHEL4U1 + 2.6.18 returns SUCCESS
>                  nfds = -1;
> @@ -344,12 +373,28 @@ TEST_END:
>          /*
>           * Check results
>           */
> +        if(tc->ttype == SEND_SIGINT_RACE_TEST) {
> +          int sig;
> +          sigprocmask(SIG_SETMASK, NULL, &sigmask);
> +          for(sig=1; sig < SIGRTMAX; sig++) {
> +              TEST(sigismember(&sigmask, sig));
> +              if(TEST_RETURN < 0 && TEST_ERRNO == EINVAL && sig != SIGINT)
> +                continue; /* let's ignore errors if they are for other signal than SIGINT that we set */
> +              if((sig==SIGINT) != (TEST_RETURN!=0)) {
> +                tst_resm(TFAIL, "Bad value of signal mask, signal %d is %s", sig, TEST_RETURN ? "on" : "off");
> +                cmp_ok |=1;
> +              }
> +            }
> +        }
>          result |= (sys_errno != tc->err) || !cmp_ok;
>          PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno,
>                           cmp_ok);
> -
> + cleanup:
>          if (fd >= 0)
>                  cleanup_file(fpath);
> +
> +        sigemptyset(&sigmask);
> +        sigprocmask(SIG_SETMASK, &sigmask, NULL);
>          if (pid > 0) {
>                  int st;
>                  kill(pid, SIGTERM);


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
