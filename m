Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Vb6ZP-0007nj-Qi
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 10:30:43 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vb6ZM-0003t2-5K
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 10:30:43 +0000
Date: Tue, 29 Oct 2013 06:30:34 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <955388781.15408075.1383042634142.JavaMail.root@redhat.com>
In-Reply-To: <1383033332-932-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1383033332-932-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] setpgid03: use SIGUSR1 instead of sleep
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net

Hi,

it looks race-y after patch too. For example, let assume child runs first:

diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c b/testcases/kernel/syscalls/setpgid/setpgid03.c
index 17fd16f..91f9940 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid03.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
@@ -82,6 +82,7 @@ int main(int ac, char **av)
 #endif
                }

+               sleep(1);
                if (sigwaitinfo(&sigusr_set, NULL) < 0)
                        tst_brkm(TFAIL | TERRNO, cleanup,
                                "sigwaitinfo() failed");

# ./setpgid03
setpgid03    1  TBROK  :  unexpected signal 10 received (pid = 6763).
setpgid03    2  TBROK  :  Remaining cases broken

It might be easier to use "checkpoint" system, see include/tst_checkpoint.h,
and lib/tests/tst_checkpoint_* for examples.

Regards,
Jan

----- Original Message -----
> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>
> Sent: Tuesday, 29 October, 2013 8:55:32 AM
> Subject: [LTP] [PATCH] setpgid03: use SIGUSR1 instead of sleep
> 
> I came accross the following rare issue:
> 
> setpgid03    1  TPASS  :  setpgid SUCCESS to set errno to EPERM
> setpgid03    2  TFAIL  :  setpgid FAILED, expect EACCES got 1
> 
> I suppose It may happen if the test host is under stress.
> To prevent this It would be better to use SIGUSR1 for parent-child
> synchronisations.
> 
> Also fixed error passing from children and performed a minor cleanup.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  testcases/kernel/syscalls/setpgid/setpgid03.c |  200
>  ++++++++++++-------------
>  1 files changed, 98 insertions(+), 102 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c
> b/testcases/kernel/syscalls/setpgid/setpgid03.c
> index 4429fe4..17fd16f 100644
> --- a/testcases/kernel/syscalls/setpgid/setpgid03.c
> +++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
> @@ -1,34 +1,23 @@
>  /*
> + * Copyright (c) International Business Machines  Corp., 2001
>   *
> - *   Copyright (c) International Business Machines  Corp., 2001
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
>   *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
>   *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA
> + * You should have received a copy of the GNU General Public License
> + * along with this program;  if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301
> USA
>   */
>  
>  /*
> - * NAME
> - * 	setpgid03.c
> - *
> - * DESCRIPTION
> - * 	Test to check the error and trivial conditions in setpgid system call
> - *
> - * USAGE
> - * 	setuid03
> - *
> - * RESTRICTIONS
> - * 	This test is not completely written in the LTP format - PLEASE FIX!
> + * Test to check the error and trivial conditions in setpgid system call
>   */
>  
>  #define DEBUG 0
> @@ -47,16 +36,16 @@
>  char *TCID = "setpgid03";
>  int TST_TOTAL = 1;
>  
> -void do_child(void);
> -void setup(void);
> -void cleanup(void);
> +static void do_child(void);
> +static void setup(void);
> +static void cleanup(void);
>  
>  int main(int ac, char **av)
>  {
>  	int pid;
> -	int rval, fail = 0;
> -	int ret, status;
> -	int exno = 0;
> +	int rval;
> +	int status;
> +	sigset_t sigusr_set;
>  
>  	int lc;
>  	char *msg;
> @@ -68,14 +57,13 @@ int main(int ac, char **av)
>  	maybe_run_child(&do_child, "");
>  #endif
>  
> -	/*
> -	 * perform global setup for the test
> -	 */
>  	setup();
>  
> +	sigemptyset(&sigusr_set);
> +	sigaddset(&sigusr_set, SIGUSR1);
> +
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
>  
> -		/* reset tst_count in case we are looping */
>  		tst_count = 0;
>  
>  //test1:
> @@ -84,7 +72,7 @@ int main(int ac, char **av)
>  			tst_brkm(TBROK, cleanup, "fork() failed");
>  		}
>  
> -		if (pid == 0) {	/* child */
> +		if (pid == 0) {
>  #ifdef UCLINUX
>  			if (self_exec(av[0], "") < 0) {
>  				tst_brkm(TBROK, cleanup, "self_exec failed");
> @@ -92,35 +80,33 @@ int main(int ac, char **av)
>  #else
>  			do_child();
>  #endif
> -		} else {	/* parent */
> -			sleep(1);
> -			rval = setpgid(pid, getppid());
> -			if (errno == EPERM) {
> -				tst_resm(TPASS, "setpgid SUCCESS to set "
> -					 "errno to EPERM");
> -			} else {
> -				tst_resm(TFAIL, "setpgid FAILED, "
> -					 "expect %d, return %d", EPERM, errno);
> -				fail = 1;
> -			}
> -			sleep(1);
> -			if ((ret = wait(&status)) > 0) {
> -				if (DEBUG)
> -					tst_resm(TINFO, "Test {%d} exited "
> -						 "status 0x%0x", ret, status);
> -
> -				if (status != 0) {
> -					fail = 1;
> -				}
> -			}
>  		}
> -		if (DEBUG) {
> -			if (fail || exno) {
> -				tst_resm(TINFO, "Test test 1: FAILED");
> -			} else {
> -				tst_resm(TINFO, "Test test 1: PASSED");
> -			}
> +
> +		if (sigwaitinfo(&sigusr_set, NULL) < 0)
> +			tst_brkm(TFAIL | TERRNO, cleanup,
> +				"sigwaitinfo() failed");
> +
> +		rval = setpgid(pid, getppid());
> +		if (errno == EPERM) {
> +			tst_resm(TPASS,
> +				"setpgid SUCCESS to set errno to EPERM");
> +		} else {
> +			tst_resm(TFAIL,
> +				"setpgid FAILED, expect %d, return %d",
> +				EPERM, errno);
> +		}
> +
> +		if (wait(&status) < 0)
> +			tst_resm(TFAIL | TERRNO, "wait() failed");
> +
> +		if (!(WIFEXITED(status)) || (WEXITSTATUS(status) != 0)) {
> +			if (DEBUG)
> +				tst_resm(TINFO, "child exited with status %d",
> +					WEXITSTATUS(status));
> +
> +			tst_resm(TFAIL, "child failed");
>  		}
> +
>  //test2:
>  		/*
>  		 * Value of pid matches the pid of the child process and
> @@ -131,39 +117,59 @@ int main(int ac, char **av)
>  
>  		}
>  		if (pid == 0) {
> -			if (execlp("sleep", "sleep", "3", NULL) < 0) {
> -				perror("exec failed");
> +			char buf[10];
> +			int ret;
> +
> +			ret = snprintf(buf, 10, "%d", getppid());
> +			if ((ret >= 10) || (ret <= 0)) {
> +				printf("snprintf() failed\n");
> +
> +				exit(126);
>  			}
> +
> +			const char *args[4 + 1];
> +			args[0] = "kill";
> +			args[1] = "-s";
> +			args[2] = "SIGUSR1";
> +			args[3] = buf;
> +			args[4] = NULL;
> +
> +			if (execvp(args[0], (char *const *)args) < 0)
> +				perror("exec failed\n");
> +
>  			exit(127);
> +		}
> +
> +		if (sigwaitinfo(&sigusr_set, NULL) < 0)
> +			tst_brkm(TFAIL | TERRNO, cleanup,
> +				"sigwaitinfo() failed");
> +
> +		rval = setpgid(pid, getppid());
> +		if (errno == EACCES) {
> +			tst_resm(TPASS,
> +				"setpgid SUCCEEDED to set errno to EACCES");
>  		} else {
> -			sleep(1);
> -			rval = setpgid(pid, getppid());
> -			if (errno == EACCES) {
> -				tst_resm(TPASS, "setpgid SUCCEEDED to set "
> -					 "errno to EACCES");
> -			} else {
> -				tst_resm(TFAIL, "setpgid FAILED, expect EACCES "
> -					 "got %d", errno);
> -			}
> -			if ((ret = wait(&status)) > 0) {
> -				if (DEBUG)
> -					tst_resm(TINFO, "Test {%d} exited "
> -						 "status 0x%0x", ret, status);
> -				if (status != 0) {
> -					fail = 1;
> -				}
> -			}
> +			tst_resm(TFAIL,
> +				"setpgid FAILED, expect EACCES got %d", errno);
> +		}
> +
> +		if (wait(&status) < 0)
> +			tst_resm(TFAIL | TERRNO, "wait() failed");
> +
> +		if ((!WIFEXITED(status)) || (WEXITSTATUS(status) != 0)) {
> +			if (DEBUG)
> +				tst_resm(TINFO, "child exited with status %d",
> +					WEXITSTATUS(status));
> +
> +			tst_resm(TFAIL, "child failed");
>  		}
>  	}
> +
>  	cleanup();
>  	tst_exit();
> -
>  }
>  
> -/*
> - * do_child()
> - */
> -void do_child()
> +static void do_child(void)
>  {
>  	int exno = 0;
>  
> @@ -171,15 +177,15 @@ void do_child()
>  		tst_resm(TFAIL, "setsid failed, errno :%d", errno);
>  		exno = 1;
>  	}
> +
> +	kill(getppid(), SIGUSR1);
> +
>  	sleep(2);
> +
>  	exit(exno);
>  }
>  
> -/*
> - * setup()
> - * 	performs all ONE TIME setup for this test
> - */
> -void setup(void)
> +static void setup(void)
>  {
>  
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
> @@ -189,17 +195,7 @@ void setup(void)
>  	TEST_PAUSE;
>  }
>  
> -/*
> - * cleanup()
> - * 	performs all the ONE TIME cleanup for this test at completion
> - * 	or premature exit
> - */
> -void cleanup(void)
> +static void cleanup(void)
>  {
> -	/*
> -	 * print timing status if that option was specified
> -	 * print errno log if that option was specified
> -	 */
>  	TEST_CLEANUP;
> -
>  }
> --
> 1.7.1
> 
> 
> ------------------------------------------------------------------------------
> Android is increasing in popularity, but the open development platform that
> developers love is also attractive to malware creators. Download this white
> paper to learn more about secure code signing practices that can help keep
> Android apps secure.
> http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
