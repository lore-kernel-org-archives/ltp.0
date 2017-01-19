From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Jan 2017 16:21:37 +0100
Subject: [LTP] [PATCH 2/2] ipc/msgsnd0*: cleanup && convert to new API
In-Reply-To: <1481860457-23035-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1481860457-23035-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1481860457-23035-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170119152136.GD9193@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void cleanup(void)
>  {
> -	/* if it exists, remove the message queue if it exists */
> -	rm_queue(msg_q_1);
> -
> -	tst_rmdir();
> -
> +	if (queue_id != -1 && msgctl(queue_id, IPC_RMID, NULL)) {

You should initialized the queue_id to -1, since otherwise you may
attempt to remove queue id 0 if cleanup is executed before msgget()
returns and queue_id is initialized.

> +		tst_res(TWARN | TERRNO, "failed to delete message queue %i",
> +			queue_id);
> +	}
>  }
> +
> +static struct tst_test test = {
> +	.tid = "msgsnd01",
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = verify_msgsnd,
> +	.needs_tmpdir = 1
> +}

Otherwise it looks fine.

> diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
> index 6547ab2..9367775 100644

...

> +static key_t msgkey;
> +static int queue_id = -1;
> +static int bad_id = -1;
> +static struct passwd *pw;
> +static struct buf {
> +	long type;
> +	char text[MSGSIZE];
> +} snd_buf = {1, "hello, world"};
> +
> +static struct tcase {
> +	int *id;
> +	struct buf *buffer;
> +	long mtype;
> +	int msgsz;
> +	int exp_err;
> +	/*1: nobody expected  0: root expected */
> +	int exp_user;
> +} tcases[] = {
> +	{&queue_id, &snd_buf, 1, MSGSIZE, EACCES, 1},
> +	{&queue_id, NULL, 1, MSGSIZE, EFAULT, 0},
> +	{&bad_id, &snd_buf, 1, MSGSIZE, EINVAL, 0},
> +	{&queue_id, &snd_buf, 0, MSGSIZE, EINVAL, 0},
> +	{&queue_id, &snd_buf, -1, MSGSIZE, EINVAL, 0},
> +	{&queue_id, &snd_buf, 1, -1, EINVAL, 0}
> +};
> +
> +static void verify_msgsnd(struct tcase *tc)
>  {
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();		/* global setup */
> -
> -	/* The following loop checks looping state if -i option given */
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		/* reset tst_count in case we are looping */
> -		tst_count = 0;
> -
> -		/*
> -		 * loop through the test cases
> -		 */
> +	snd_buf.type = tc->mtype;

This is kind of hack. Why can't we create three struct buf variables and
assign them to the tcases structure instead of modyfing it this way?


Otherwise it looks fine.

> diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
> index 16d62f8..0d13065 100644
> --- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
> +++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
> @@ -1,234 +1,125 @@
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
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * You should have received a copy of the GNU General Public License
> + * along with this program.
>   */
>  
>  /*
> - * NAME
> - *	msgsnd05.c
> - *
>   * DESCRIPTION
> - *	msgsnd05 - test for EINTR error
> - *
> - * ALGORITHM
> - *	create a message queue with read/write permissions
> - *	initialize a message buffer with a known message and type
> - *	enqueue the message in a loop until the queue is full
> - *	loop if that option was specified
> - *	fork a child process
> - *	child attempts to enqueue a message to the full queue and sleeps
> - *	parent sends a SIGHUP to the child then waits for the child to complete
> - *	child get a return from msgsnd()
> - *	check the errno value
> - *	  issue a PASS message if we get EINTR
> - *	otherwise, the tests fails
> - *	  issue a FAIL message
> - *	child exits, parent calls cleanup
> - *
> - * USAGE:  <for command-line>
> - *  msgsnd05 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -P x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	03/2001 - Written by Wayne Boyer
> - *      14/03/2008 Matthieu Fertr?? (Matthieu.Fertre@irisa.fr)
> - *      - Fix concurrency issue. Due to the use of usleep function to
> - *        synchronize processes, synchronization issues can occur on a loaded
> - *        system. Fix this by using pipes to synchronize processes.
> - *
> - * RESTRICTIONS
> - *	none
> + * 1) test for EAGAIN error
> + * 2) test for EINTR error
>   */
>  
> -#include "test.h"
> -
> -#include "ipcmsg.h"
> -
> +#include <errno.h>
> +#include <stdlib.h>
>  #include <sys/types.h>
> -#include <sys/wait.h>
> -
> -void do_child(void);
> -void cleanup(void);
> -void setup(void);
> -#ifdef UCLINUX
> -#define PIPE_NAME	"msgsnd05"
> -void do_child_uclinux(void);
> -#endif
> -
> -char *TCID = "msgsnd05";
> -int TST_TOTAL = 1;
> -
> -int msg_q_1 = -1;		/* The message queue id created in setup */
> -
> -MSGBUF msg_buf;
> -
> -int main(int ac, char **av)
> +#include <sys/ipc.h>
> +#include <sys/msg.h>
> +
> +#include "tst_test.h"
> +#include "libnewipc.h"
> +
> +static key_t msgkey;
> +static int queue_id = -1;
> +static struct buf {
> +	long type;
> +	char text[MSGSIZE];
> +} snd_buf = {1, "hello, world"};
> +
> +static struct tcase {
> +	int flag;
> +	int exp_err;
> +	/*1: nobody expected  0: root expected */
> +	int exp_user;
> +} tcases[] = {
> +	{IPC_NOWAIT, EAGAIN, 0},
> +	{0, EINTR, 1}
> +};
> +
> +static void verify_msgsnd(struct tcase *tc)
>  {
> -	int lc;
> -	pid_t c_pid;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -#ifdef UCLINUX
> -	maybe_run_child(&do_child_uclinux, "d", &msg_q_1);
> -#endif
> -
> -	setup();		/* global setup */
> -
> -	/* The following loop checks looping state if -i option given */
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		/* reset tst_count in case we are looping */
> -		tst_count = 0;
> -
> -		/*
> -		 * fork a child that will attempt to write a message
> -		 * to the queue without IPC_NOWAIT
> -		 */
> -		if ((c_pid = FORK_OR_VFORK()) == -1) {
> -			tst_brkm(TBROK, cleanup, "could not fork");
> -		}
> -
> -		if (c_pid == 0) {	/* child */
> -			/*
> -			 * Attempt to write another message to the full queue.
> -			 * Without the IPC_NOWAIT flag, the child sleeps
> -			 */
> -
> -#ifdef UCLINUX
> -			if (self_exec(av[0], "d", msg_q_1) < 0) {
> -				tst_brkm(TBROK, cleanup, "could not self_exec");
> -			}
> -#else
> -			do_child();
> -#endif
> -		} else {
> -			TST_PROCESS_STATE_WAIT(cleanup, c_pid, 'S');
> -
> -			/* send a signal that must be caught to the child */
> -			if (kill(c_pid, SIGHUP) == -1)
> -				tst_brkm(TBROK, cleanup, "kill failed");
> -
> -			waitpid(c_pid, NULL, 0);
> -		}
> -	}
> -
> -	cleanup();
> -
> -	tst_exit();
> -}
> -
> -/*
> - * do_child()
> - */
> -void do_child(void)
> -{
> -	TEST(msgsnd(msg_q_1, &msg_buf, MSGSIZE, 0));
> -
> +	TEST(msgsnd(queue_id, &snd_buf, MSGSIZE, tc->flag));
>  	if (TEST_RETURN != -1) {
> -		tst_resm(TFAIL, "call succeeded when error expected");
> -		exit(-1);
> +		tst_res(TFAIL, "msgsnd() succeeded unexpectedly");
> +		return;
>  	}
>  
> -	switch (TEST_ERRNO) {
> -	case EINTR:
> -		tst_resm(TPASS, "expected failure - errno = %d : %s",
> -			 TEST_ERRNO, strerror(TEST_ERRNO));
> -		break;
> -	default:
> -		tst_resm(TFAIL,
> -			 "call failed with an unexpected error - %d : %s",
> -			 TEST_ERRNO, strerror(TEST_ERRNO));
> -		break;
> +	if (TEST_ERRNO == tc->exp_err) {
> +		tst_res(TPASS | TTERRNO, "msgsnd() failed as expected");
> +	} else {
> +		tst_res(TFAIL | TTERRNO, "msgsnd() failed unexpectedly,"
> +			" expected %s", tst_strerrno(tc->exp_err));
>  	}
> -
> -	exit(0);
>  }
>  
> -void sighandler(int sig)
> +static void sighandler(int sig)
>  {
>  	if (sig == SIGHUP)
>  		return;
>  	else
> -		tst_brkm(TBROK, NULL, "received unexpected signal %d", sig);
> +		tst_brk(TBROK, "received unexpected signal %d", sig);

Using tst_brk() in signal handler is NOT safe.

Looking at the code the best solution would be to just call
_exit(TBROK); here instead, which is one of the things you can do safely
in a signal handler.

Otherwise it looks fine.

> diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
> index 42f6e79..737fc7f 100644
> --- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
> +++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
> @@ -1,222 +1,92 @@
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
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * You should have received a copy of the GNU General Public License
> + * along with this program.
>   */
>  
>  /*
> - * NAME
> - *	msgsnd06.c
> - *
>   * DESCRIPTION
> - *	msgsnd06 - test for EIDRM error
> - *
> - * ALGORITHM
> - *	loop if that option was specified
> - *	create a message queue with read/write permissions
> - *	initialize a message buffer with a known message and type
> - *	enqueue messages in a loop until the queue is full
> - *	fork a child process
> - *	child attempts to enqueue a message to the full queue and sleeps
> - *	parent removes the queue and then exits
> - *	child get a return from msgsnd()
> - *	check the errno value
> - *	  issue a PASS message if we get EIDRM
> - *	otherwise, the tests fails
> - *	  issue a FAIL message
> - *	call cleanup
> - *
> - * USAGE:  <for command-line>
> - *  msgsnd06 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -P x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	03/2001 - Written by Wayne Boyer
> - *      14/03/2008 Matthieu Fertr?? (Matthieu.Fertre@irisa.fr)
> - *      - Fix concurrency issue. Due to the use of usleep function to
> - *        synchronize processes, synchronization issues can occur on a loaded
> - *        system. Fix this by using pipes to synchronize processes.
> - *
> - * RESTRICTIONS
> - *	none
> + * test for EIDRM error

This may be a bit more detailed, i.e. something as:

Tests if EIDRM is returned when message queue was removed while msgsnd()
was trying to send a message.

> -#include <sys/wait.h>
> -#include "test.h"
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <sys/ipc.h>
> +#include <sys/msg.h>
>  
> -#include "ipcmsg.h"
> +#include "tst_test.h"
> +#include "libnewipc.h"
>  
> -void cleanup(void);
> -void setup(void);
> -void do_child(void);
> +static key_t msgkey;
> +static int queue_id = -1;
> +static struct buf {
> +	long type;
> +	char text[MSGSIZE];
> +} snd_buf = {1, "hello, world"};
>  
> -char *TCID = "msgsnd06";
> -int TST_TOTAL = 1;
> -
> -int msg_q_1 = -1;		/* The message queue id created in setup */
> -
> -MSGBUF msg_buf;
> -
> -int main(int ac, char **av)
> +static void verify_msgsnd(void)
>  {
> -	int lc;
> -	pid_t c_pid;
> -	int status, e_code;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -#ifdef UCLINUX
> -#define PIPE_NAME	"msgsnd06"
> -	maybe_run_child(&do_child, "d", &msg_q_1);
> -#endif
> -
> -	setup();		/* global setup */
> -
> -	/* The following loop checks looping state if -i option given */
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		/* reset tst_count in case we are looping */
> -		tst_count = 0;
> -
> -		msgkey = getipckey();
> -
> -		/* create a message queue with read/write permission */
> -		if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW))
> -		    == -1) {
> -			tst_brkm(TBROK, cleanup, "Can't create message queue");
> -		}
> -
> -		/* initialize the message buffer */
> -		init_buf(&msg_buf, MSGTYPE, MSGSIZE);
> -
> -		/* write messages to the queue until it is full */
> -		while (msgsnd(msg_q_1, &msg_buf, MSGSIZE, IPC_NOWAIT) != -1) {
> -			msg_buf.mtype += 1;
> -		}
> -
> -		/*
> -		 * fork a child that will attempt to write a message
> -		 * to the queue without IPC_NOWAIT
> -		 */
> -		if ((c_pid = FORK_OR_VFORK()) == -1) {
> -			tst_brkm(TBROK, cleanup, "could not fork");
> -		}
> -
> -		if (c_pid == 0) {	/* child */
> -
> -#ifdef UCLINUX
> -			if (self_exec(av[0], "d", msg_q_1) < 0) {
> -				tst_brkm(TBROK, cleanup, "could not self_exec");
> -			}
> -#else
> -			do_child();
> -#endif
> -		} else {
> -			TST_PROCESS_STATE_WAIT(cleanup, c_pid, 'S');
> -
> -			/* remove the queue */
> -			rm_queue(msg_q_1);
> -
> -			/* wait for the child to finish */
> -			wait(&status);
> -			/* make sure the child returned a good exit status */
> -			e_code = status >> 8;
> -			if (e_code != 0) {
> -				tst_resm(TFAIL, "Failures reported above");
> -			}
> -		}
> +	TEST(msgsnd(queue_id, &snd_buf, MSGSIZE, 0));
> +	if (TEST_RETURN != -1) {
> +		tst_res(TFAIL, "msgsnd() succeeded unexpectedly");
> +		return;
>  	}
>  
> -	cleanup();
> -
> -	tst_exit();
> +	if (TEST_ERRNO == EIDRM) {
> +		tst_res(TPASS | TTERRNO, "msgsnd() failed as expected");
> +	} else {
> +		tst_res(TFAIL | TTERRNO,
> +			"msgsnd() failed unexpectedly, expected EIDRM");
> +	}
>  }
>  
> -/*
> - * do_child()
> - */
> -void do_child(void)
> +static void do_test(void)
>  {
> -	int retval = 0;
> +	pid_t pid;
>  
> -#ifdef UCLINUX
> -	/* initialize the message buffer */
> -	init_buf(&msg_buf, MSGTYPE, MSGSIZE);
> +	queue_id = CREATE_MSG(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
>  
> -#endif
> -	/*
> -	 * Attempt to write another message to the full queue.
> -	 * Without the IPC_NOWAIT flag, the child sleeps
> -	 */
> -	TEST(msgsnd(msg_q_1, &msg_buf, MSGSIZE, 0));
> +	while (msgsnd(queue_id, &snd_buf, MSGSIZE, IPC_NOWAIT) != -1)
> +		snd_buf.type += 1;
>  
> -	if (TEST_RETURN != -1) {
> -		retval = 1;
> -		tst_resm(TFAIL, "call succeeded when error expected");
> -		exit(retval);
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		verify_msgsnd();
> +		exit(0);
>  	}
>  
> -	switch (TEST_ERRNO) {
> -	case EIDRM:
> -		tst_resm(TPASS, "expected failure - errno = %d : %s",
> -			 TEST_ERRNO, strerror(TEST_ERRNO));
> +	TST_PROCESS_STATE_WAIT(pid, 'S');
>  
> -		/* mark the queue as invalid as it was removed */
> -		msg_q_1 = -1;
> -		break;
> -	default:
> -		retval = 1;
> -		tst_resm(TFAIL,
> -			 "call failed with an unexpected error - %d : %s",
> -			 TEST_ERRNO, strerror(TEST_ERRNO));
> -		break;
> +	if (queue_id != -1 && msgctl(queue_id, IPC_RMID, NULL)) {
> +		tst_res(TWARN | TERRNO, "failed to delete message queue %i",
> +				queue_id);

Uh, the queue_id canot be -1 here, right?

Also this is tst_brk(TBROK | TERRNO, ...) not TWARN, we are not in
cleanup here.

And the queue_id should be reset to -1 right after it was removed
succesfully and there should be a cleanup that removes the queue if
queue_id is not set to -1, because the test may still call tst_brk()
somewhere between the creation and removal of the queue. We have to be
careful with System V queues since these are global persistent objects
that can outlive the test easily.

>  	}
> -	exit(retval);
> -}
> -
> -/*
> - * setup() - performs all the ONE TIME setup for this test.
> - */
> -void setup(void)
> -{
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
>  
> -	/*
> -	 * Create a temporary directory and cd into it.
> -	 * This helps to ensure that a unique msgkey is created.
> -	 * See ../lib/libipc.c for more information.
> -	 */
> -	tst_tmpdir();
> +	tst_reap_children();
>  }
>  
> -/*
> - * cleanup() - performs all the ONE TIME cleanup for this test at completion
> - * 	       or premature exit.
> - */
> -void cleanup(void)
> +static void setup(void)
>  {
> -
> -	tst_rmdir();
> -
> +	msgkey = GETIPCKEY();
>  }
> +
> +static struct tst_test test = {
> +	.tid = "msgsnd06",
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.setup = setup,
> +	.test_all = do_test
> +};
> -- 
> 1.8.3.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
