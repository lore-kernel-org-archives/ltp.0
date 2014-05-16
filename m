Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WlGhT-0001B5-UA
	for ltp-list@lists.sourceforge.net; Fri, 16 May 2014 11:53:19 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WlGhS-0004oD-GK
	for ltp-list@lists.sourceforge.net; Fri, 16 May 2014 11:53:19 +0000
Date: Fri, 16 May 2014 07:53:10 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <669312722.6827924.1400241190444.JavaMail.zimbra@redhat.com>
In-Reply-To: <1400211517-30970-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1400211517-30970-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1400211517-30970-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2 2/2] setpgid/setpgid01.c: add pid = 0 and pgid
 = 0	test
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Xiaoguang Wang" <wangxg.fnst@cn.fujitsu.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Friday, 16 May, 2014 5:38:37 AM
> Subject: [LTP] [PATCH v2 2/2] setpgid/setpgid01.c: add pid = 0 and pgid = 0	test
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/setpgid/setpgid01.c | 47
>  +++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)

Hi,

series look good to me.
I have only one small nit, see comment inline.

Regards,
Jan

> 
> diff --git a/testcases/kernel/syscalls/setpgid/setpgid01.c
> b/testcases/kernel/syscalls/setpgid/setpgid01.c
> index 700e573..23f0508 100644
> --- a/testcases/kernel/syscalls/setpgid/setpgid01.c
> +++ b/testcases/kernel/syscalls/setpgid/setpgid01.c
> @@ -36,12 +36,14 @@
>   * Description:
>   * Verify that:
>   *   1. Basic functionality test for setpgid(2).
> + *   2. Check functioning of setpgid(2) with pid = 0 and pgid = 0.
>   */
>  
>  #include <errno.h>
>  #include <string.h>
>  #include <signal.h>
>  #include <stdlib.h>
> +#include <sys/wait.h>
>  #include "test.h"
>  #include "usctest.h"
>  
> @@ -51,7 +53,8 @@ static void cleanup(void);
>  char *TCID = "setpgid01";
>  
>  static void setpgid_test1(void);
> -static void (*testfunc[])(void) = { setpgid_test1};
> +static void setpgid_test2(void);
> +static void (*testfunc[])(void) = { setpgid_test1, setpgid_test2};
>  int TST_TOTAL = ARRAY_SIZE(testfunc);
>  
>  int main(int ac, char **av)
> @@ -91,9 +94,49 @@ static void setpgid_test1(void)
>  	}
>  }
>  
> +static int wait4child(pid_t child)
> +{
> +	int status;
> +
> +	if (waitpid(child, &status, 0) == -1)
> +		tst_resm(TBROK|TERRNO, "waitpid");
> +	if (WIFEXITED(status))
> +		return WEXITSTATUS(status);
> +	else
> +		return status;
> +}
> +
> +static void setpgid_test2(void)
> +{
> +	int ret;
> +	pid_t pgid, pid;
> +
> +	pid = FORK_OR_VFORK();
> +	if (pid == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "fork()");
> +
> +	if (pid != 0) {
> +		ret = wait4child(pid);
> +	} else {
> +		pid = getpid();
> +		TEST(setpgid(0, 0));
> +		pgid = getpgrp();
> +		if (TEST_RETURN == -1 || pgid != pid)

^^ I'd suggest to add printf here with TEST_ERRNO. In unlikely
case it fails, it would good to know why.

> +			exit(1);
> +		else
> +			exit(0);
> +	}
> +
> +	if (ret == 0)
> +		tst_resm(TPASS, "test setpgid(0, 0) success");
> +	else
> +		tst_resm(TFAIL, "test setpgid(0, 0) fail");
> +}
> +
> +
>  static void setup(void)
>  {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
>  
>  	TEST_PAUSE;
>  }
> --
> 1.8.2.1
> 
> 
> ------------------------------------------------------------------------------
> "Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
> Instantly run your Selenium tests across 300+ browser/OS combos.
> Get unparalleled scalability from the best Selenium testing platform
> available
> Simple to use. Nothing to install. Get started now for free."
> http://p.sf.net/sfu/SauceLabs
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
