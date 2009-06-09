Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1ME61F-00041G-7n
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:25:57 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1ME61B-0006Eh-Jm
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:25:57 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n59IMBnv024766
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 12:22:11 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n59IPkZI169654
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 12:25:48 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n59IPkMh008022
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 12:25:46 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906081325.24357.jpalecek@web.de>
References: <200906081325.24357.jpalecek@web.de>
Date: Tue, 09 Jun 2009 23:55:05 +0530
Message-Id: <1244571907.5497.23.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Change syscall numbers to symbolic constants
	in	rt_sigprocmask01
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

On Mon, 2009-06-08 at 13:25 +0200, Jiri Palecek wrote: 
> Hello,
> 
> this patch changes the syscall numbers in rt_sigprocmask01 test to symbolic constants, to make it functional on other architectures than i386.
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> 
> ---
>  .../syscalls/rt_sigprocmask/rt_sigprocmask01.c     |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
> index c3251ab..6398a28 100644
> --- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
> +++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
> @@ -163,14 +163,14 @@ int main(int ac, char **av) {
>  			
>  			/* call rt_sigaction() */
>  			act.sa_handler = sig_handler;
> -                        TEST(syscall(174, 33, &act, &oact, 8));
> +                        TEST(syscall(__NR_rt_sigaction, 33, &act, &oact, 8));
>  			if(TEST_RETURN != 0){
>  				tst_resm(TFAIL,"Call to rt_sigaction() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>                          	cleanup();
>  				tst_exit();
>  			}
>  			/* call rt_sigprocmask() to block signal#33 */
> -                        TEST(syscall(175, SIG_BLOCK, &set, &oset, 8));
> +                        TEST(syscall(__NR_rt_sigprocmask, SIG_BLOCK, &set, &oset, 8));
>  			if(TEST_RETURN == -1){
>  				tst_resm(TFAIL,"Call to rt_sigprocmask()**** Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>                          	cleanup();
> @@ -192,7 +192,7 @@ int main(int ac, char **av) {
>  				}
>  				else {
>  					/* call rt_sigpending() */
> -					TEST(syscall(176, &oset, 8));
> +					TEST(syscall(__NR_rt_sigpending, &oset, 8));
>  					if(TEST_RETURN == -1){
>  						tst_resm(TFAIL,"call rt_sigpending() failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>                          			cleanup();
> @@ -205,7 +205,7 @@ int main(int ac, char **av) {
>  						tst_exit();
>  					}
>  					/* call rt_sigprocmask() to unblock signal#33 */
> -					TEST(syscall(175, SIG_UNBLOCK, &set, &oset, 8));
> +					TEST(syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, &set, &oset, 8));
>  					if(TEST_RETURN == -1){
>  						tst_resm(TFAIL,"Call to rt_sigprocmask() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>                          			cleanup();


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
