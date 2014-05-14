Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WkW4y-0007Ou-4B
	for ltp-list@lists.sourceforge.net; Wed, 14 May 2014 10:06:28 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WkW4w-0002ik-FH
	for ltp-list@lists.sourceforge.net; Wed, 14 May 2014 10:06:28 +0000
Date: Wed, 14 May 2014 06:05:57 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <27774731.5088145.1400061957755.JavaMail.zimbra@redhat.com>
In-Reply-To: <1399874987-24926-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1399874987-24926-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/2] setpgid/setpgid01.c: cleanup
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
> Sent: Monday, 12 May, 2014 8:09:46 AM
> Subject: [LTP] [PATCH 1/2] setpgid/setpgid01.c: cleanup
> 
> Delete some useless comments.
> Do some code re-arrangement.
> Some cleanup.
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/setpgid/setpgid01.c | 204
>  +++++++-------------------
>  1 file changed, 57 insertions(+), 147 deletions(-)
> 

> -	/*
> -	 * Make sure current process is NOT a session or pgrp leader
> -	 */
> +static void setpgid_test1(void)
> +{
> +	int ret;
> +	pid_t pgid, pid;
>  
>  	pgid = getpgrp();
>  	pid = getpid();
>  

Hi,

> +	/*
> +	 * Make sure current process is NOT a session or pgrp leader
> +	 */
>  	if (pgid == pid) {

What if we dropped the condition above and always make a child?
If we do that, then setpgid_test1() and setpgid_test2() are almost the same,
with the difference of arguments you pass to setpgid(), so there's a chance
to re-use some code.

Thinking about it a bit more, is there any reason we need a child process?

If it is pgrp leader, we create a child, which inherits parent's PGID and then
calls setpgid(0, pgid_of_parent)
If it's not a pgrp leader, we call setpgid(pid, current_pgid).

We always seem to call setpgid with same pgid as current PGID. Can that
fail in any scenario? Does it matter if it's a pgrp leader or not?

$ cat a.c
int main()
{
	printf("%d %d\n", getpid(), getpgrp());
	printf("%d\n", setpgid(getpid(), getpgrp()));
	return 0;
}

$ ./a.out 
22721 22721
0

Am I missing something?

Regards,
Jan

>  		if ((pid = FORK_OR_VFORK()) == -1) {
> -			tst_brkm(TBROK, cleanup,
> -				 "fork() in setup() failed - errno %d", errno);
> +			tst_brkm(TBROK | TERRNO, cleanup, "fork()");
>  		}
>  
> -		if (pid != 0) {	/* parent - sits and waits */
> -			wait(&status);
> -			exit(WEXITSTATUS(status));
> -		} else {	/* child - continues with test */
> +		if (pid != 0) {
> +			ret = wait4child(pid);
> +		} else {
>  			pid = getpid();
> +			TEST(setpgid(pid, pgid));
> +			if (TEST_RETURN == -1 || getpgrp() != pgid)
> +				exit(1);
> +			else
> +				exit(0);
>  		}
> +	} else {
> +		TEST(setpgid(pid, pgid));
> +		if (TEST_RETURN == -1 || getpgrp() != pgid)
> +			ret = 1;
> +		else
> +			ret = 0;
>  	}
> +
> +	if (ret == 0)
> +		tst_resm(TPASS, "test setpgid(%d, %d) success", pid, pgid);
> +	else
> +		tst_resm(TFAIL, "test setpgid(%d, %d) fail", pid, pgid);
>  }
>  
> -/***************************************************************
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *		completion or premature exit.
> - ***************************************************************/
> -void cleanup(void)
> +static void setup(void)
>  {
> -	/*
> -	 * print timing stats if that option was specified.
> -	 * print errno log if that option was specified.
> -	 */
> -	TEST_CLEANUP;
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
>  
> +	TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
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
