Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WDE5A-0001oO-7m
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 14:13:04 +0000
Date: Tue, 11 Feb 2014 15:12:21 +0100
From: chrubis@suse.cz
Message-ID: <20140211141221.GA9577@rei.suse.cz>
References: <52B2F462.5070507@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52B2F462.5070507@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] msgrcv/msgrcv07.c: add MSG_EXCEPT,
 MSG_NOERROR flag test
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

Hi!
> create a new case to test MSG_EXCEPT, MSG_NOERROR flag for msgrcv(2)
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  runtest/ltplite                                 |   1 +
>  runtest/stress.part3                            |   1 +
>  runtest/syscalls                                |   1 +
>  runtest/syscalls-ipc                            |   1 +
>  testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c | 227 ++++++++++++++++++++++++
>  5 files changed, 231 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> 
> diff --git a/runtest/ltplite b/runtest/ltplite
> index c90bc48..d22008a 100644
> --- a/runtest/ltplite
> +++ b/runtest/ltplite
> @@ -488,6 +488,7 @@ msgrcv03 msgrcv03
>  msgrcv04 msgrcv04
>  msgrcv05 msgrcv05
>  msgrcv06 msgrcv06
> +msgrcv07 msgrcv07
>  
>  msgsnd01 msgsnd01
>  msgsnd02 msgsnd02
> diff --git a/runtest/stress.part3 b/runtest/stress.part3
> index eac28d0..b833c68 100644
> --- a/runtest/stress.part3
> +++ b/runtest/stress.part3
> @@ -411,6 +411,7 @@ msgrcv03 msgrcv03
>  msgrcv04 msgrcv04
>  msgrcv05 msgrcv05
>  msgrcv06 msgrcv06
> +msgrcv07 msgrcv07
>  
>  msgsnd01 msgsnd01
>  msgsnd02 msgsnd02
> diff --git a/runtest/syscalls b/runtest/syscalls
> index c5bbe8f..1eb23d2 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -639,6 +639,7 @@ msgrcv03 msgrcv03
>  msgrcv04 msgrcv04
>  msgrcv05 msgrcv05
>  msgrcv06 msgrcv06
> +msgrcv07 msgrcv07
>  
>  msgsnd01 msgsnd01
>  msgsnd02 msgsnd02
> diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
> index f57a96e..ea1447c 100644
> --- a/runtest/syscalls-ipc
> +++ b/runtest/syscalls-ipc
> @@ -21,6 +21,7 @@ msgrcv03 msgrcv03
>  msgrcv04 msgrcv04
>  msgrcv05 msgrcv05
>  msgrcv06 msgrcv06
> +msgrcv07 msgrcv07
>  
>  msgsnd01 msgsnd01
>  msgsnd02 msgsnd02
> diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> new file mode 100644
> index 0000000..576f2ff
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> @@ -0,0 +1,227 @@
> +/*
> + * Copyright (c) 2013 Fujitsu Ltd.
> + * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +/*
> + * Description:
> + *     Basic test for msgrcv(2) using MSG_EXCEPT, MSG_NOERROR
> + */
> +
> +#define  _GNU_SOURCE
> +#include <sys/wait.h>
> +#include "test.h"
> +#include "usctest.h"
> +#include "ipcmsg.h"
> +
> +
> +#define MSGTYPE1	1
> +#define MSGTYPE2	2
> +#define MSG1	"message type1"
> +#define MSG2	"message type2"
> +
> +static void wait4child(pid_t child, int index);
> +static void creat_msg_queue(void);

The definition for creat_msg_queue is not needed here (the function code
is before the code that calls it).

> +static void setup_msg_except(void);
> +static void test_msg_except(int index);
> +static void cleanup_msg_except(void);
> +
> +static void setup_msg_noerror(void);
> +static void test_msg_noerror(int index);
> +static void cleanup_msg_noerror(void);
> +
> +static int msgq_id;
> +MSGBUF rcv_buf, snd_buf1, snd_buf2;
> +static int tst_result;
> +
> +static struct test_case_t {
> +	int msgflg;
> +	void (*setup)(void);
> +	void (*testfunc)(int index);
> +	void (*cleanup)(void);
> +	char *des;
> +} test_cases[] = {
> +	{MSG_EXCEPT, setup_msg_except, test_msg_except, cleanup_msg_except,
> +	 "MSG_EXCEPT"},
> +	{MSG_NOERROR, setup_msg_noerror, test_msg_noerror,
> +	 cleanup_msg_noerror, "MSG_NOERROR"},
> +};
> +
> +char *TCID = "msgrcv07";
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	char *msg;
> +	int i;
> +
> +	msg = parse_opts(ac, av, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for (i = 0; i < TST_TOTAL; i++) {
> +			if (test_cases[i].setup)
> +				test_cases[i].setup();
> +			if (test_cases[i].testfunc)
> +				test_cases[i].testfunc(i);
> +			if (test_cases[i].cleanup)
> +				test_cases[i].cleanup();

		       It looks to me like splitting the test to setup,
		       testfunc and cleanup is artificial. Keep things
		       simple only testfunc would do here. Also passing
		       a pointer test_case_t structure or the flag
		       directly is a bit cleaner solution than passing
		       an array index.

> +		}
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +void setup(void)
> +{
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	tst_tmpdir();

There is no need to create temporary directory if test does not work
with files.

> +	TEST_PAUSE;
> +
> +	snd_buf1.mtype = MSGTYPE1;
> +	strcpy(snd_buf1.mtext, MSG1);
> +	snd_buf2.mtype = MSGTYPE2;
> +	strcpy(snd_buf2.mtext, MSG2);

You can initialize these statically as:

MSGBUF snd_buf1 = {.mtype = MSGTYPE1, .mtext = MSG1};

> +}
> +
> +void creat_msg_queue(void)
> +{
> +	msgkey = getipckey();
> +
> +	/* create a message queue with read/write permission */
> +	msgq_id = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);

You can use IPC_PRIVATE.

> +	if (msgq_id == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Can't create message queue");
> +}
> +
> +void setup_msg_except(void)
> +{
> +	creat_msg_queue();
> +
> +	/* put the MSG1 on the queue */
> +	if (msgsnd(msgq_id, &snd_buf1, MSGSIZE, 0) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Can't enqueue message");
> +
> +	/* put the MSG2 on the queue */
> +	if (msgsnd(msgq_id, &snd_buf2, MSGSIZE, 0) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Can't enqueue message");
> +}
> +
> +void test_msg_except(int index)
> +{
> +	pid_t child_pid;
> +
> +	fflush(stdout);
> +	child_pid = FORK_OR_VFORK();

Don't use FORK_OR_VFORK() in code that is not ported to uClinux and do
not flush the output manually, use tst_fork() instead.

> +	if (child_pid == -1) {
> +		tst_brkm(TBROK, cleanup, "fork failed");
> +	} else if (child_pid > 0) {
> +		wait4child(child_pid, index);
> +	} else {
> +		TEST(msgrcv(msgq_id, &rcv_buf, MSGSIZE, MSGTYPE2,
> +		     test_cases[index].msgflg));
> +		if (TEST_RETURN == -1) {
> +			fprintf(stderr, "msgrcv failed\n");
> +			exit(TBROK);
> +		}
> +		/* check the received message */
> +		if (strcmp(rcv_buf.mtext, MSG1) == 0)
> +			tst_result = TPASS;
> +		else
> +			tst_result = TFAIL;

What about checking the message type here as well?

> +		exit(tst_result);
> +	}
> +}
> +
> +static void cleanup_msg_except(void)
> +{
> +	rm_queue(msgq_id);
> +}
> +
> +static void setup_msg_noerror(void)
> +{
> +	creat_msg_queue();
> +
> +	/* put the MSG1 on the queue */
> +	if (msgsnd(msgq_id, &snd_buf1, MSGSIZE, 0) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Can't enqueue message");
> +}
> +
> +static void test_msg_noerror(int index)
> +{
> +	pid_t child_pid;
> +	int msg_len;
> +
> +	fflush(stdout);
> +	child_pid = FORK_OR_VFORK();

The same here.

> +	if (child_pid == -1) {
> +		tst_brkm(TBROK, cleanup, "fork failed");
> +	} else if (child_pid > 0) {
> +		wait4child(child_pid, index);
> +	} else {
> +		msg_len = sizeof(MSG1) / 2;
> +		TEST(msgrcv(msgq_id, &rcv_buf, msg_len, MSGTYPE1,
> +		     test_cases[index].msgflg));

What about checking the message type and that the half of the message is
correct here?

> +		if (TEST_RETURN == -1)
> +			tst_result = TFAIL;
> +		else
> +			tst_result = TPASS;
> +		exit(tst_result);
> +	}
> +}
> +
> +static void cleanup_msg_noerror(void)
> +{
> +	rm_queue(msgq_id);
> +}
> +
> +static void wait4child(pid_t child, int index)
> +{
> +	int status;
> +	int ret;
> +
> +	if (waitpid(child, &status, 0) == -1)
> +		tst_resm(TBROK | TERRNO, "waitpid");
> +	if (WIFEXITED(status))
> +		ret = WEXITSTATUS(status);
> +	else
> +		ret = status;

		I would just add the tst_resm and brkm directly to these
		ifs, setting variable in a few ifs and then branching on
		the very same value seems like pointless work.

> +	if (ret == 0) {
> +		tst_resm(TPASS, "test %s success", test_cases[index].des);
> +	} else if (ret == 1) {
> +		tst_resm(TFAIL, "test %s failed, status: %d",
> +			 test_cases[index].des, status);
> +	} else {
> +		tst_brkm(TBROK | TERRNO, cleanup, "msgrcv failed unexpectedly");
> +	}
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
