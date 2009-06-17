Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <njoly@pasteur.fr>) id 1MH2tx-0000fm-N8
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 21:42:37 +0000
Received: from munster3.sis.pasteur.fr ([157.99.64.214])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MH2to-0004Yi-Hw
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 21:42:35 +0000
Date: Wed, 17 Jun 2009 23:42:20 +0200
From: Nicolas Joly <njoly@pasteur.fr>
Message-ID: <20090617214220.GA227500@medusa.sis.pasteur.fr>
References: <f5a7b3810906171320p432db48l92fc6a42cddfa6df@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f5a7b3810906171320p432db48l92fc6a42cddfa6df@mail.gmail.com>
Subject: Re: [LTP] [FIX PATCH] ltp-rt_sigprocmask
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Oleg Nesterov <oleg@redhat.com>, Manas Kumar Nayak <maknayak@in.ibm.com>, rohit.170309@gmail.com

On Thu, Jun 18, 2009 at 01:50:12AM +0530, naresh kamboju wrote:
> Hi,
> 
> I have noticed following failures and fixed.
> 1. rt_sigprocmask01.c
> 2. rt_sigprocmask02.c
[...]
> diff -Naurb a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
> b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
> --- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c	2009-05-21
> 23:53:00.000000000 +0530
> +++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c	2009-06-17
> 23:06:24.000000000 +0530
> @@ -163,14 +163,14 @@
>  			
>  			/* call rt_sigaction() */
>  			act.sa_handler = sig_handler;
> -                        TEST(syscall(174, 33, &act, &oact, 8));
> +                        TEST(syscall(__NR_tkill, 33, &act, &oact, 8));

This one looks wrong ... Shouldn't it be __NR_rt_sigaction ?

>  			if(TEST_RETURN != 0){
>  				tst_resm(TFAIL,"Call to rt_sigaction() Failed, errno=%d :
> %s",TEST_ERRNO, strerror(TEST_ERRNO));
>                          	cleanup();
>  				tst_exit();
>  			}
>  			/* call rt_sigprocmask() to block signal#33 */
> -                        TEST(syscall(175, SIG_BLOCK, &set, &oset, 8));
> +                        TEST(syscall(__NR_rt_sigprocmask, SIG_BLOCK,
> &set, &oset, 8));
>  			if(TEST_RETURN == -1){
>  				tst_resm(TFAIL,"Call to rt_sigprocmask()**** Failed, errno=%d :
> %s",TEST_ERRNO, strerror(TEST_ERRNO));
>                          	cleanup();
> @@ -192,7 +192,7 @@
>  				}
>  				else {
>  					/* call rt_sigpending() */
> -					TEST(syscall(176, &oset, 8));
> +					TEST(syscall(__NR_rt_sigpending, &oset, 8));
>  					if(TEST_RETURN == -1){
>  						tst_resm(TFAIL,"call rt_sigpending() failed, errno=%d :
> %s",TEST_ERRNO, strerror(TEST_ERRNO));
>                          			cleanup();
> @@ -205,7 +205,7 @@
>  						tst_exit();
>  					}
>  					/* call rt_sigprocmask() to unblock signal#33 */
> -					TEST(syscall(175, SIG_UNBLOCK, &set, &oset, 8));
> +					TEST(syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, &set, &oset, 8));
>  					if(TEST_RETURN == -1){
>  						tst_resm(TFAIL,"Call to rt_sigprocmask() Failed, errno=%d :
> %s",TEST_ERRNO, strerror(TEST_ERRNO));
>                          			cleanup();
> diff -Naurb a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
> b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
> --- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c	2009-05-21
> 23:54:15.000000000 +0530
> +++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c	2009-06-17
> 23:30:42.000000000 +0530
> @@ -176,7 +176,7 @@
> 
>  			for(i=0; i<test_count; i++)
>  		        {
> -				TEST(syscall(175, SIG_BLOCK, &s, test_cases[i].ss, test_cases[i].sssize));
> +				TEST(syscall(__NR_rt_sigprocmask, SIG_BLOCK, &s,
> test_cases[i].ss, test_cases[i].sssize));
>  				if(TEST_RETURN == 0){
>  					tst_resm(TFAIL,"Call to rt_sigprocmask()succeeded,but should
> failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>  					fail++;

-- 
Nicolas Joly

Biological Software and Databanks.
Institut Pasteur, Paris.

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
