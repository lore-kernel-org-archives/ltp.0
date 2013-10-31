Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Vbn5q-0001g1-Nv
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 07:55:02 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vbn5o-0001oM-L8
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 07:55:02 +0000
Message-ID: <52720CC8.7070000@oracle.com>
Date: Thu, 31 Oct 2013 11:54:48 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <955388781.15408075.1383042634142.JavaMail.root@redhat.com>
	<1383124058-13133-3-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1608129004.16193796.1383140734531.JavaMail.root@redhat.com>
In-Reply-To: <1608129004.16193796.1383140734531.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH V2 2/2] setpgid03: use SIGUSR1 instead of sleep
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
To: Jan Stancek <jstancek@redhat.com>
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net


On 10/30/2013 05:45 PM, Jan Stancek wrote:
> Hi,
>
> I think I still see a possible race, try running it with following change:
> diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c b/testcases/kernel/syscalls/setpgid/setpgid03.c
> index 34975b7..1d478cb 100644
> --- a/testcases/kernel/syscalls/setpgid/setpgid03.c
> +++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
> @@ -221,6 +221,7 @@ static void do_child(void)
>          }
>
>          kill(getppid(), SIGUSR1);
> +       sleep(1);
>
>          sigemptyset(&set);
>          sigaddset(&set, SIGUSR1);
It seems that this helps:
diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c 
b/testcases/kernel/syscalls/setpgid/setpgid03.c
index 34975b7..e5bf1cd 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid03.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
@@ -36,6 +36,7 @@ char *TCID = "setpgid03";
  int TST_TOTAL = 1;

  static pid_t pid = -1;
+static volatile int exit_child;

  static void do_child(void);
  static void sigusr_handler(int signum);
@@ -230,13 +231,15 @@ static void do_child(void)
                 exit(1);
         }

-       pause();
+       while(!exit_child) {
+       }

         exit(exno);
  }

  static void sigusr_handler(int signum)
  {
+       exit_child = 1;
  }


> I also noticed that test2 can now call setpgid() on process which
> can be zombie at that time. It worked fine on my system (RHEL6.4),
> but it made me wonder if we can rely on this behavior. If we can,
> then also test1's do_child() can be simplified.
I tried to do exit() in do_child() before setpgid() was executed in 
parent and
setpgid() returned EPERM. I.e. test1 succeeds in that scenario.

But I'm not sure if we can rely on that. I would prefer not to rely...

Maybe It would be better to write a standalone program (instead of 
/bin/kill)
which will send SIGUSR1 signal to its parent and then wait to get 
SIGUSR1 signal from
parent and do exit() after that.

How do you think?

Thank you.

> Regards,
> Jan
>
> ----- Original Message -----
>> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
>> To: ltp-list@lists.sourceforge.net
>> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>
>> Sent: Wednesday, 30 October, 2013 10:07:38 AM
>> Subject: [LTP] [PATCH V2 2/2] setpgid03: use SIGUSR1 instead of sleep
>>
>> I came accross the following rare issue:
>>
>> setpgid03    1  TPASS  :  setpgid SUCCESS to set errno to EPERM
>> setpgid03    2  TFAIL  :  setpgid FAILED, expect EACCES got 1
>>
>> I suppose It may happen if the test host is under stress.
>>
>> To prevent this It would be better to use SIGUSR1 for parent-child
>> synchronisations.
>>
>> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
>> ---
>>   testcases/kernel/syscalls/setpgid/setpgid03.c |  123
>>   +++++++++++++++++++++++--
>>   1 files changed, 115 insertions(+), 8 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c
>> b/testcases/kernel/syscalls/setpgid/setpgid03.c
>> index 2c47bc4..34975b7 100644
>> --- a/testcases/kernel/syscalls/setpgid/setpgid03.c
>> +++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
>> @@ -1,5 +1,6 @@
>>   /*
>>    * Copyright (c) International Business Machines  Corp., 2001
>> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
>>    *
>>    * This program is free software;  you can redistribute it and/or modify
>>    * it under the terms of the GNU General Public License as published by
>> @@ -34,15 +35,20 @@
>>   char *TCID = "setpgid03";
>>   int TST_TOTAL = 1;
>>   
>> +static pid_t pid = -1;
>> +
>>   static void do_child(void);
>> +static void sigusr_handler(int signum);
>> +static void term_handler(int signum);
>>   static void setup(void);
>>   static void cleanup(void);
>>   
>>   int main(int ac, char **av)
>>   {
>> -	int pid;
>>   	int rval;
>>   	int status;
>> +	sigset_t sig_set;
>> +	struct sigaction sa;
>>   
>>   	int lc;
>>   	char *msg;
>> @@ -56,12 +62,42 @@ int main(int ac, char **av)
>>   
>>   	setup();
>>   
>> +	/* We need to block these signals before fork()
>> +	 * because our children may terminate either
>> +	 * normally (parent receives both SIGUSR1 and SIGCHLD) or
>> +	 * abnormally (parent receives SIGCHLD only)
>> +	 */
>> +	sigemptyset(&sig_set);
>> +	sigaddset(&sig_set, SIGUSR1);
>> +	sigaddset(&sig_set, SIGCHLD);
>> +
>> +	/* Since we use SIGUSR1 as a control signal It should not
>> +	 * be an "unexpected" one
>> +	 */
>> +	memset(&sa, 0, sizeof(sa));
>> +	sa.sa_handler = sigusr_handler;
>> +	if (sigaction(SIGUSR1, &sa, NULL) < 0)
>> +		tst_brkm(TFAIL | TERRNO, cleanup, "sigaction(SIGUSR1) failed");
>> +
>> +	/* But for SIGINT, SIGTERM we should kill our children */
>> +	sa.sa_handler = term_handler;
>> +	if (sigaction(SIGTERM, &sa, NULL) < 0)
>> +		tst_brkm(TFAIL | TERRNO, cleanup, "sigaction(SIGTERM) failed");
>> +	if (sigaction(SIGINT, &sa, NULL) < 0)
>> +		tst_brkm(TFAIL | TERRNO, cleanup, "sigaction(SIGINT) failed");
>> +
>>   	for (lc = 0; TEST_LOOPING(lc); lc++) {
>>   
>>   		tst_count = 0;
>>   
>>   //test1:
>>   		/* sid of the calling process is not same */
>> +
>> +		if (sigprocmask(SIG_BLOCK, &sig_set, NULL) < 0)
>> +			tst_brkm(TFAIL | TERRNO, cleanup,
>> +				"sigprocmask(SIG_BLOCK) in test 1 failed");
>> +
>> +
>>   		if ((pid = FORK_OR_VFORK()) == -1) {
>>   			tst_brkm(TBROK, cleanup, "fork() failed");
>>   		}
>> @@ -76,7 +112,14 @@ int main(int ac, char **av)
>>   #endif
>>   		}
>>   
>> -		sleep(1);
>> +		if (sigwaitinfo(&sig_set, NULL) < 0)
>> +			tst_brkm(TFAIL | TERRNO, cleanup,
>> +				"sigwaitinfo() failed");
>> +
>> +		if (sigprocmask(SIG_UNBLOCK, &sig_set, NULL) < 0)
>> +			tst_brkm(TFAIL | TERRNO, cleanup,
>> +				"sigprocmask(SIG_UNBLOCK) in test 2 failed");
>> +
>>   		rval = setpgid(pid, getppid());
>>   		if (errno == EPERM) {
>>   			tst_resm(TPASS,
>> @@ -86,11 +129,14 @@ int main(int ac, char **av)
>>   				"setpgid FAILED, expect %d, return %d",
>>   				EPERM, errno);
>>   		}
>> -		sleep(1);
>> +
>> +		kill(pid, SIGUSR1);
>>   
>>   		if (wait(&status) < 0)
>>   			tst_resm(TFAIL | TERRNO, "wait() for child 1 failed");
>>   
>> +		pid = -1;
>> +
>>   		if (!(WIFEXITED(status)) || (WEXITSTATUS(status) != 0))
>>   			tst_resm(TFAIL, "child 1 failed with status %d",
>>   				WEXITSTATUS(status));
>> @@ -100,18 +146,47 @@ int main(int ac, char **av)
>>   		 * Value of pid matches the pid of the child process and
>>   		 * the child process has exec successfully. Error
>>   		 */
>> +
>> +		if (sigprocmask(SIG_BLOCK, &sig_set, NULL) < 0)
>> +			tst_brkm(TFAIL | TERRNO, cleanup,
>> +				"sigprocmask(SIG_BLOCK) in test 2 failed");
>> +
>>   		if ((pid = FORK_OR_VFORK()) == -1) {
>>   			tst_resm(TFAIL, "Fork failed");
>>   
>>   		}
>>   		if (pid == 0) {
>> -			if (execlp("sleep", "sleep", "3", NULL) < 0) {
>> -				perror("exec failed");
>> +			char buf[10];
>> +			int ret;
>> +
>> +			ret = snprintf(buf, 10, "%d", getppid());
>> +			if ((ret >= 10) || (ret <= 0)) {
>> +				printf("snprintf() failed\n");
>> +
>> +				exit(126);
>>   			}
>> +
>> +			const char *args[4 + 1];
>> +			args[0] = "kill";
>> +			args[1] = "-s";
>> +			args[2] = "SIGUSR1";
>> +			args[3] = buf;
>> +			args[4] = NULL;
>> +
>> +			if (execvp(args[0], (char *const *)args) < 0)
>> +				perror("execvp() failed\n");
>> +
>>   			exit(127);
>>   		}
>>   
>> -		sleep(1);
>> +		if (sigwaitinfo(&sig_set, NULL) < 0)
>> +			tst_brkm(TFAIL | TERRNO, cleanup,
>> +				"sigwaitinfo() failed");
>> +
>> +		if (sigprocmask(SIG_UNBLOCK, &sig_set, NULL) < 0)
>> +			tst_brkm(TFAIL | TERRNO, cleanup,
>> +				"sigprocmask(SIG_UNBLOCK) in test 2 failed");
>> +
>>   		rval = setpgid(pid, getppid());
>>   		if (errno == EACCES) {
>>   			tst_resm(TPASS,
>> @@ -124,6 +199,8 @@ int main(int ac, char **av)
>>   		if (wait(&status) < 0)
>>   			tst_resm(TFAIL | TERRNO, "wait() for child 2 failed");
>>   
>> +		pid = -1;
>> +
>>   		if (!(WIFEXITED(status)) || (WEXITSTATUS(status) != 0))
>>   			tst_resm(TFAIL, "child 2 failed with status %d",
>>   				WEXITSTATUS(status));
>> @@ -136,18 +213,48 @@ int main(int ac, char **av)
>>   static void do_child(void)
>>   {
>>   	int exno = 0;
>> +	sigset_t set;
>>   
>>   	if (setsid() < 0) {
>>   		printf("setsid() failed, errno: %d\n", errno);
>>   		exno = 1;
>>   	}
>> -	sleep(2);
>> +
>> +	kill(getppid(), SIGUSR1);
>> +
>> +	sigemptyset(&set);
>> +	sigaddset(&set, SIGUSR1);
>> +	if (sigprocmask(SIG_UNBLOCK, &set, NULL) < 0) {
>> +		printf("sigprocmask() in child failed: %d\n", errno);
>> +
>> +		exit(1);
>> +	}
>> +
>> +	pause();
>> +
>>   	exit(exno);
>>   }
>>   
>> -static void setup(void)
>> +static void sigusr_handler(int signum)
>>   {
>> +}
>> +
>> +static void term_handler(int signum)
>> +{
>> +	if (pid == 0) {
>> +		printf("Child received signal %d\n", signum);
>>   
>> +		exit(1);
>> +	} else {
>> +		if (pid > 0)
>> +			kill(pid, signum);
>> +
>> +		tst_brkm(TFAIL, cleanup, "Signal %d received. Exiting", signum);
>> +	}
>> +}
>> +
>> +static void setup(void)
>> +{
>>   	tst_sig(FORK, DEF_HANDLER, cleanup);
>>   
>>   	umask(0);
>> --
>> 1.7.1
>>
>>
>> ------------------------------------------------------------------------------
>> Android is increasing in popularity, but the open development platform that
>> developers love is also attractive to malware creators. Download this white
>> paper to learn more about secure code signing practices that can help keep
>> Android apps secure.
>> http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>


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
