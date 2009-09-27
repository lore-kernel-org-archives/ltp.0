Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MryHV-0006oK-N0
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:15:33 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MryHQ-0001N5-V6
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:15:33 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8RI58Yo029228
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:05:08 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8RIFN06258258
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:15:23 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8RIFMMK030151
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:15:23 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200909241326.n8ODQ5FA030559@e36.co.us.ibm.com>
References: <200909241326.n8ODQ5FA030559@e36.co.us.ibm.com>
Date: Sun, 27 Sep 2009 23:45:02 +0530
Message-Id: <1254075304.10457.21.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Add a count parameter to create_sig_proc
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

On Wed, 2009-07-08 at 16:34 +0200, Jiri Palecek wrote: 
> Hello,
> 
> there were complaints about some tests (ppoll01) hanging sometimes. I've created this patch to address the issue.
> 
>  This should allow testing inherently racy conditions, such as a
>  syscall returning EINTR upon signal handler execution. The problem
>  here is that the signal could actually arrive before the syscall gets
>  executed, which results in the test waiting for it forever. The
>  solution is adding a parameter that would allow to specify how much
>  signals a particular test expects - a racy test would ask for a large
>  number of signals sent, so it will get one even if some were
>  missed. Tests, which test behavior, which is not racy
>  (eg. pselect()) should only request a single signal.
> 
>  Note that you need to manually kill the child process delivering the
>  signals when you don't need them, if you ordered more signals than
>  you actually handle.
> 
>  Also, this patch resets signal handling in child process created in
>  create_sig_proc. This should avoid the child calling the parent's
>  signal handlers and interfering with parent's cleanup process.
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  .../syscalls/clock_nanosleep/clock_nanosleep01.c   |    4 +-
>  .../syscalls/mq_timedreceive/mq_timedreceive01.c   |    4 +-
>  .../kernel/syscalls/mq_timedsend/mq_timedsend01.c  |    4 +-
>  testcases/kernel/syscalls/ppoll/ppoll01.c          |    2 +-
>  testcases/kernel/syscalls/utils/common_j_h.c       |   34 ++++++++++++++++---
>  testcases/kernel/syscalls/utils/include_j_h.h      |    2 +-
>  6 files changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
> index ece479a..444a5a4 100644
> --- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
> +++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
> @@ -285,8 +285,8 @@ static int do_test(struct test_case *tc)
>           * Check before sleep time
>           */
>          if (tc->ttype == SEND_SIGINT) {
> -                TEST(pid = create_sig_proc(500000, SIGINT));
> -                if (TEST_RETURN < 0)
> +                pid = create_sig_proc(500000, SIGINT, UINT_MAX);
> +                if (pid < 0)
>                          return 1;
>          }
> 
> diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
> index d6604d7..2d41a48 100644
> --- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
> +++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
> @@ -350,8 +350,8 @@ switch (tc->ttype) {
>                  }
> 
>  		 if (tc->ttype == SEND_SIGINT) {
> -                        TEST(pid = create_sig_proc(200000, SIGINT));
> -                        if (TEST_RETURN < 0) {
> +                        pid = create_sig_proc(200000, SIGINT, UINT_MAX);
> +                        if (pid < 0) {
>                                  result = 1;
>                                  goto EXIT;
>                          }
> diff --git a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
> index fee1a7f..b2cc7fc 100644
> --- a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
> +++ b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
> @@ -351,8 +351,8 @@ static int do_test(struct test_case *tc)
>                                  }
>                          }
>  			if (tc->ttype == SEND_SIGINT) {
> -                                TEST(pid = create_sig_proc(200000, SIGINT));
> -                                if (TEST_RETURN < 0) {
> +                                pid = create_sig_proc(200000, SIGINT, UINT_MAX);
> +                                if (pid < 0) {
>                                          result = 1;
>                                          goto EXIT;
>                                  }
> diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
> index 1d96e04..a04935c 100644
> --- a/testcases/kernel/syscalls/ppoll/ppoll01.c
> +++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
> @@ -302,7 +302,7 @@ static int do_test(struct test_case *tc)
>                  // fallthrough
>  	case SEND_SIGINT:
>                  nfds = 0;
> -                TEST(pid = create_sig_proc(100000, SIGINT)); // 100msec
> +                pid = create_sig_proc(100000, SIGINT, UINT_MAX); // 100msec
>                  if (pid < 0)
>                          return 1;
>                  break;
> diff --git a/testcases/kernel/syscalls/utils/common_j_h.c b/testcases/kernel/syscalls/utils/common_j_h.c
> index 2b90cad..c460d85 100644
> --- a/testcases/kernel/syscalls/utils/common_j_h.c
> +++ b/testcases/kernel/syscalls/utils/common_j_h.c
> @@ -37,7 +37,18 @@
>  #include <errno.h>
>  #include <mqueue.h>
>  #include "include_j_h.h"
> -
> +#include "test.h"
> +
> +#define barrier() __asm__ __volatile__("": : :"memory")
> +#define WITH_SIGNALS_BLOCKED(code) {											\
> +		sigset_t held_sigs_;																	\
> +		sigfillset(&held_sigs_);															\
> +		sigprocmask(SIG_SETMASK, &held_sigs_, &held_sigs_);	\
> +		barrier(); \
> +		code;																									\
> +		barrier(); \
> +		sigprocmask(SIG_SETMASK, &held_sigs_, NULL);					\
> +	}
> 
>  /*
>   * Change user ID
> @@ -97,20 +108,31 @@ int cleanup_euid(uid_t old_uid)
>  	return 0;
>  }
> 
> -
> +static void sigterm_handler(int sig)
> +{
> +	_exit(0);
> +}
>  /*
>   * Generate a child process which will send a signal
>   */
> -pid_t create_sig_proc(unsigned long usec, int sig)
> +pid_t create_sig_proc(unsigned long usec, int sig, unsigned count)
>  {
>  	pid_t pid, cpid;
> 
>  	pid = getpid();
> -	cpid = fork();
> +	WITH_SIGNALS_BLOCKED(
> +			if((cpid = fork()) == 0) {
> +				tst_sig(NOFORK, SIG_DFL, NULL);
> +				signal(SIGTERM, sigterm_handler);
> +			}
> +	);
>  	switch (cpid) {
>  	case 0:
> -		usleep(usec);
> -		kill(pid, sig);
> +		while(count-- > 0) {
> +			usleep(usec);
> +			if(kill(pid, sig) == -1)
> +				break;
> +		}
>  		_exit(0);
>  		break;
>  	case -1:
> diff --git a/testcases/kernel/syscalls/utils/include_j_h.h b/testcases/kernel/syscalls/utils/include_j_h.h
> index 571b541..0123a3f 100644
> --- a/testcases/kernel/syscalls/utils/include_j_h.h
> +++ b/testcases/kernel/syscalls/utils/include_j_h.h
> @@ -137,7 +137,7 @@ int setup_uid(char *uname);
>  int setup_euid(char *uname, uid_t *old_uid);
>  int cleanup_euid(uid_t old_uid);
> 
> -pid_t create_sig_proc(unsigned long usec, int sig);
> +pid_t create_sig_proc(unsigned long usec, int sig, unsigned count);
> 
>  int _setup_file(char *testdir, char *fname, char *path, int flags, mode_t mode);
>  int setup_file(char *testdir, char *fname, char *path);


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
