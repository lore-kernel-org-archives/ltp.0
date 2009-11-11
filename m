Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1N820N-0007Ne-VK
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 01:28:15 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N820F-0004Pz-Nm
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 01:28:15 +0000
Message-ID: <4AFA133F.3020808@cn.fujitsu.com>
Date: Wed, 11 Nov 2009 09:28:31 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <4AF93496.3030408@cn.fujitsu.com>
In-Reply-To: <4AF93496.3030408@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] syscalls: fix some failure on arch X86_64
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
To: ltp-list@lists.sourceforge.net, maknayak@in.ibm.com

Hi,
On 11/10/2009 05:38 PM, liubo wrote:
> 1) rt_sigaction
>     "sigaction" has the structure:
>  
>  struct sigaction {
>          __sighandler_t sa_handler;
>          unsigned long sa_flags;
>   #ifdef SA_RESTORER
>           __sigrestore_t sa_restorer;
>   #endif
>           sigset_t sa_mask;               /* mask last for extensibility */
>  };
>
>     However, on arch x86_64, if we directly get to call rt_sigaction,
> the argument "sa_restorer" will not be fulfilled, and this will lead
>  to segment fault.
>     on arch x86_64, if sa_restorer is not set, kernel will lead to segment fault. 
> In other arch, if sa_restorer is not set, kernel can do the correct work.
>     To avoid this segment fault, we use glibc function
> "int sigaction(...);" instead, which can fulfill the argument "sa_restorer".
>
> 2) rt_sigprocmask
>     This failure contains two aspects,
> the first is the segment fault as described in 1),
> the second is that testcase uses a unknown signal 33 for test,
> and this will lead sigaction cannot bind signal 33 to the action.
>
>     So, we attempt to use a known signal instead, such as 34.
>
>   

  I am sure signal 32 and 33 cannot be used in rt_sigprocmask test
  on arch x86_64, but I'm not sure which signal else should be used
  here, Is there anyone can provide suggestions?

> This patch fixed these failures.
>
> Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>
>
> ---
>  .../kernel/syscalls/rt_sigaction/rt_sigaction01.c  |    4 ++++
>  .../syscalls/rt_sigprocmask/rt_sigprocmask01.c     |   12 ++++++++----
>  .../syscalls/rt_sigsuspend/rt_sigsuspend01.c       |    4 ++++
>  3 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
> index 27af970..1522ac4 100644
> --- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
> +++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
> @@ -154,7 +154,11 @@ set_handler(int sig, int sig_to_mask, int mask_flags)
>                  sa.sa_flags = mask_flags;
>                  sigemptyset(&sa.sa_mask);
>                  sigaddset(&sa.sa_mask, sig_to_mask);
> +		#ifndef __x86_64__
>                  TEST(syscall(__NR_rt_sigaction,sig, &sa, &oldaction,SIGSETSIZE));
> +		#else
> +		TEST(sigaction(sig, &sa, &oldaction));
> +		#endif
>          if (TEST_RETURN == 0) {
>                  return 0;
>          } else {
> diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
> index 6398a28..31258e9 100644
> --- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
> +++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
> @@ -154,7 +154,7 @@ int main(int ac, char **av) {
>                          	cleanup();
>  				tst_exit();
>  			}
> -			TEST(sigaddset(&set, 33));
> +			TEST(sigaddset(&set, 34));
>  			if(TEST_RETURN == -1){
>  				tst_resm(TFAIL,"Call to sigaddset() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>                          	cleanup();
> @@ -163,7 +163,11 @@ int main(int ac, char **av) {
>  			
>  			/* call rt_sigaction() */
>  			act.sa_handler = sig_handler;
> -                        TEST(syscall(__NR_rt_sigaction, 33, &act, &oact, 8));
> +			#ifndef __x86_64__
> +                        TEST(syscall(__NR_rt_sigaction, 34, &act, &oact, 8));
> +			#else
> +			TEST(sigaction(34, &act, &oact));
> +			#endif
>  			if(TEST_RETURN != 0){
>  				tst_resm(TFAIL,"Call to rt_sigaction() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>                          	cleanup();
> @@ -178,7 +182,7 @@ int main(int ac, char **av) {
>  			}
>  			
>  			else {
> -				TEST(kill(getpid(), 33));
> +				TEST(kill(getpid(), 34));
>  				if(TEST_RETURN != 0){
>  					tst_resm(TFAIL,"Call to kill() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>                          		cleanup();
> @@ -198,7 +202,7 @@ int main(int ac, char **av) {
>                          			cleanup();
>  						tst_exit();
>  					}
> -					TEST(sigismember(&oset, 33));
> +					TEST(sigismember(&oset, 34));
>  					if(TEST_RETURN == 0 ){
>  						tst_resm(TFAIL,"call sigismember() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>                          			cleanup();
> diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
> index 416a7c9..6132622 100644
> --- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
> +++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
> @@ -142,7 +142,11 @@ int main(int ac, char **av) {
>  			struct sigaction act, oact;
>  		        act.sa_handler = sig_handler;
>  			
> +			#ifndef __x86_64__
>  			TEST(syscall(__NR_rt_sigaction, SIGALRM, &act, &oact, 8));
> +			#else
> +			TEST(sigaction(SIGALRM, &act, &oact));
> +			#endif
>  			if(TEST_RETURN == -1){
>  		        	tst_resm(TFAIL,"rt_sigaction() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>  				cleanup();
>   


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
