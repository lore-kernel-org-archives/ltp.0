Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2747C433FE
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 13:09:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A51333CAD34
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 14:09:14 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 614193CAC3E
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 14:09:03 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 17E3E1400060
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 14:09:01 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id CA7341F88E;
 Tue,  1 Nov 2022 13:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667308140;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BE9q1Y0boQXKkSH844qDJwxN9WFikqKlENEBxaGqaKA=;
 b=UcZSeecIW89TAvIFa68E2ZGxzS0KnTt69Q4+zg+J+PCOmiXcc6vHDtL5YaRuryd4b3/v05
 33OwMbFyCYm0DDE8ITuJ3oBFVxO7OCqivH0tNbNle9DJ7u4FSIP1KiPBsXlKlAjM+3qyZq
 YFjp0xsAe7NWQDx1IfztPLkUB5R4udw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667308140;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BE9q1Y0boQXKkSH844qDJwxN9WFikqKlENEBxaGqaKA=;
 b=9PZbKrM2abjEtTx9ofy/8LHJF6JFMW3eXV2xiSUFhbw4TrajAXVxFl0BXuKd21KQr/dyVx
 K69D1w+1cnTPAhBw==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B550C2C141;
 Tue,  1 Nov 2022 13:08:59 +0000 (UTC)
References: <20220816113142.25638-1-andrea.cervesato@suse.com>
 <20220816113142.25638-4-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 01 Nov 2022 12:54:43 +0000
Organization: Linux Private Site
In-reply-to: <20220816113142.25638-4-andrea.cervesato@suse.com>
Message-ID: <87mt9a95zx.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] Refactor pidns31 test using new LTP API
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/containers/pidns/pidns31.c | 347 +++++---------------
>  1 file changed, 74 insertions(+), 273 deletions(-)
>
> diff --git a/testcases/kernel/containers/pidns/pidns31.c b/testcases/kernel/containers/pidns/pidns31.c
> index 8821ec83c..20f6117fd 100644
> --- a/testcases/kernel/containers/pidns/pidns31.c
> +++ b/testcases/kernel/containers/pidns/pidns31.c
> @@ -1,330 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> -* Copyright (c) Bull S.A.S. 2008
> -* This program is free software; you can redistribute it and/or modify
> -* it under the terms of the GNU General Public License as published by
> -* the Free Software Foundation; either version 2 of the License, or
> -* (at your option) any later version.
> -* This program is distributed in the hope that it will be useful,
> -* but WITHOUT ANY WARRANTY; without even the implied warranty of
> -* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> -* the GNU General Public License for more details.
> -* You should have received a copy of the GNU General Public License
> -* along with this program; if not, write to the Free Software
> -* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> -*
> -***************************************************************************
> -* File: pidns31.c
> -*
> -*   Description:
> -*    This testcase checks if the si_pid is correctly set when a process
> -*    that has registered for notification on a posix mqueue is in an
> -*    ancestor namespace wrt the process that sends a message to that posix
> -*    mqueue.
> -*
> -*   Test Assertion & Strategy:
> -*    Parent                                   Child
> -*    --------------------------------------------------------------------------
> -*    Create a POSIX mqueue.
> -*    Create a PID namespace container.
> -*    Register for notification when a
> -*       message arrives in that mqueue
> -*    Install a handler for SIGUSR1.
> -*                                             Open that mqueue for writing
> -*                                             Write something to the mqueue.
> -*    Inside the handler, check that
> -*       si_pid is set to the child's pid
> -*
> -*   Usage: <for command-line>
> -*    pidns31
> -*
> -*   History:
> -*    DATE      NAME                             DESCRIPTION
> -*    04/12/08  Nadia Derbey               Creation of this test.
> -*              <Nadia.Derbey@bull.net>
> -*
> -******************************************************************************/
> -#ifndef _GNU_SOURCE
> -#define _GNU_SOURCE
> -#endif
> -#include <sys/wait.h>
> -#include <sys/types.h>
> -#include <signal.h>
> -#include <stdlib.h>
> -#include <unistd.h>
> -#include <stdio.h>
> -#include <mqueue.h>
> -#include "lapi/syscalls.h"
> -#include "pidns_helper.h"
> -#include "test.h"
> -
> -char *TCID = "pidns31";
> -int TST_TOTAL = 1;
> -
> -char *mqname = "mq1";
> -int result = TFAIL;
> -
> -int father_to_child[2];
> + * Copyright (c) Bull S.A.S. 2008
> + *               01/12/08  Nadia Derbey <Nadia.Derbey@bull.net>
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
>  
> -#define CHILD_PID       1
> -#define PARENT_PID      0
> +/*\
> + * [Description]
> + *
> + * Clone a process with CLONE_NEWPID flag, register notification on a posix
> + * mqueue and send a mqueue message from the child. Then check if signal
> + * notification contains si_pid of the child.
> + */
>  
> -#define MSG      "HOW ARE YOU"
> -#define MSG_PRIO 1
> +#define _GNU_SOURCE 1
> +#include <signal.h>
> +#include <mqueue.h>
> +#include "tst_test.h"
> +#include "tst_safe_posix_ipc.h"
> +#include "lapi/namespaces_constants.h"
>  
> -#define NO_STEP -1
> -#define F_STEP_0 0x00
> -#define F_STEP_1 0x01
> -#define F_STEP_2 0x02
> -#define F_STEP_3 0x03
> -#define C_STEP_0 0x10
> -#define C_STEP_1 0x11
> +#define MQNAME "/LTP_PIDNS30_MQ"
>  
>  struct notify_info {
>  	mqd_t mqd;
>  	pid_t pid;
>  };
>  
> -static void remove_pipe(int *fd)
> -{
> -	close(fd[0]);
> -	close(fd[1]);
> -}
> +static mqd_t mqd = -1;
> +static volatile int received;
>  
>  static void remove_mqueue(mqd_t mqd)
>  {
> -	mq_close(mqd);
> -	tst_syscall(__NR_mq_unlink, mqname);
> -}
> -
> -/*
> - * steps F_STEP_XX : called from main
> - * steps C_STEP_XX : called from child_fn
> - */
> -static void cleanup_resources(int step, mqd_t mqd)
> -{
> -	switch (step) {
> -	case C_STEP_1:
> -		close(father_to_child[0]);
> -		/* fall through */
> -	case C_STEP_0:
> -		mq_close(mqd);
> -		break;
> -
> -	case F_STEP_3:
> -		remove_mqueue(mqd);
> -		close(father_to_child[1]);
> -		break;
> -
> -	case F_STEP_2:
> -		tst_syscall(__NR_mq_notify, mqd, NULL);
> -		/* fall through */
> -	case F_STEP_1:
> -		remove_mqueue(mqd);
> -		/* fall through */
> -	case F_STEP_0:
> -		remove_pipe(father_to_child);
> -		break;
> -	default:
> -		tst_resm(TWARN, "Unknown code - no resource removed.");
> -		break;
> -	}
> -}
> -
> -/*
> - * cleanup_mqueue() - performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - * step == -1 means no local resource to remove.
> - */
> -void cleanup_mqueue(int result, int step, mqd_t mqd)
> -{
> -	if (step != NO_STEP)
> -		cleanup_resources(step, mqd);
> +	if (mqd != -1)
> +		SAFE_MQ_CLOSE(mqd);
>  
> -	tst_exit();
> +	mq_unlink(MQNAME);

Again we never check this.

>  }
>  
> -/*
> - * child_fn() - Inside container
> - */
> -int child_fn(void *arg)
> +static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LTP_ATTRIBUTE_UNUSED void *unused)
>  {
> -	pid_t pid, ppid;
> -	mqd_t mqd;
> -	char buf[5];
> -
> -	/* Set process id and parent pid */
> -	pid = getpid();
> -	ppid = getppid();
> -
> -	if (pid != CHILD_PID || ppid != PARENT_PID) {
> -		tst_resm(TBROK, "cinit: pidns is not created");
> -		cleanup_mqueue(TBROK, NO_STEP, 0);
> -	}
> +	struct notify_info *info;
>  
> -	/* Close the appropriate end of pipe */
> -	close(father_to_child[1]);
> +	received = 0;
>  
> -	/* Is parent ready to receive a message? */
> -	read(father_to_child[0], buf, 5);
> -	if (strcmp(buf, "f:ok")) {
> -		tst_resm(TBROK, "cinit: parent did not send the message!");
> -		cleanup_mqueue(TBROK, NO_STEP, 0);
> -	}
> -	tst_resm(TINFO, "cinit: my father is ready to receive a message");
> +	tst_res(TINFO, "Received signal %s from pid %d",
> tst_strsig(si->si_signo), si->si_pid);

Again, printing in a signal handler should be avoided. However it's
definitely good to have this information.

>  
> -	mqd = tst_syscall(__NR_mq_open, mqname, O_WRONLY, 0, NULL);
> -	if (mqd == (mqd_t) - 1) {
> -		tst_resm(TBROK, "cinit: mq_open() failed (%s)",
> -			 strerror(errno));
> -		cleanup_mqueue(TBROK, NO_STEP, 0);
> -	}
> -	tst_resm(TINFO, "cinit: mq_open succeeded");
> +	if (si->si_signo != SIGUSR1 || si->si_code != SI_MESGQ)
> +		return;
>  
> -	if (mq_send(mqd, MSG, strlen(MSG), MSG_PRIO) == (mqd_t) - 1) {
> -		tst_resm(TBROK, "cinit: mq_send() failed (%s)",
> -			 strerror(errno));
> -		cleanup_mqueue(TBROK, C_STEP_0, mqd);
> -	}
> -	tst_resm(TINFO, "cinit: mq_send() succeeded");
> +	info = (struct notify_info*)si->si_ptr;
>  
> -	/* Cleanup and exit */
> -	cleanup_resources(C_STEP_1, mqd);
> -	exit(0);
> +	if (si->si_pid == info->pid)
> +		received++;
>  }
>  
> -/*
> - * father_signal_handler()
> - */
> -static void father_signal_handler(int sig, siginfo_t * si, void *unused)
> +static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>  {
> -	char buf[256];
> -	struct mq_attr attr;
> -	struct notify_info *info;
> -
> -	if (si->si_signo != SIGUSR1) {
> -		tst_resm(TBROK, "father: received %s unexpectedly",
> -			 strsignal(si->si_signo));
> -		return;
> -	}
> +	pid_t cpid, ppid;
> +	mqd_t mqd_child;
>  
> -	if (si->si_code != SI_MESGQ) {
> -		tst_resm(TBROK, "father: expected signal code SI_MESGQ - "
> -			 "Got %d", si->si_code);
> -		return;
> -	}
> +	cpid = getpid();
> +	ppid = getppid();
>  
> -	if (!si->si_ptr) {
> -		tst_resm(TBROK, "father: expected si_ptr - Got NULL");
> -		return;
> +	if (cpid != 1 || ppid != 0) {
> +		tst_res(TFAIL, "got unexpected result of cpid=%d ppid=%d", cpid, ppid);
> +		return 0;

Again, could use TST_EXP_EQ... and/or put it in a function as it is
repeated 3+ times.

>  	}
>  
> -	info = (struct notify_info *)si->si_ptr;
> +	TST_CHECKPOINT_WAIT(0);
>  
> -	if (si->si_pid != info->pid) {
> -		tst_resm(TFAIL,
> -			 "father: expected signal originator PID = %d - Got %d",
> -			 info->pid, si->si_pid);
> -		return;
> -	}
> +	mqd_child = SAFE_MQ_OPEN(MQNAME, O_WRONLY, 0, NULL);
> +	SAFE_MQ_SEND(mqd_child, "pippo", 5, 1);
>  
> -	tst_resm(TPASS, "father: signal originator PID = %d", si->si_pid);
> -	result = TPASS;
> +	TST_CHECKPOINT_WAKE(0);
>  
> -	/*
> -	 * Now read the message - Be silent on errors since this is not the
> -	 * test purpose.
> -	 */
> -	if (!mq_getattr(info->mqd, &attr))
> -		mq_receive(info->mqd, buf, attr.mq_msgsize, NULL);
> +	return 0;
>  }
>  
> -static void setup(void)
> +static void cleanup(void)
>  {
> -	tst_require_root();
> -	check_newpid();
> +	remove_mqueue(mqd);
>  }
>  
> -/***********************************************************************
> -*   M A I N
> -***********************************************************************/
> -
> -int main(void)
> +static void run(void)
>  {
> -	pid_t cpid;
> -	mqd_t mqd;
> -	struct sigevent notif;
> +	int cpid, status;
>  	struct sigaction sa;
> -	int status;
> +	struct sigevent notif;
>  	struct notify_info info;
>  
> -	setup();
> -
> -	if (pipe(father_to_child) == -1) {
> -		tst_resm(TBROK, "parent: pipe() failed. aborting!");
> -		cleanup_mqueue(TBROK, NO_STEP, 0);
> -	}
> +	remove_mqueue(mqd);
>  
> -	tst_syscall(__NR_mq_unlink, mqname);
> -	mqd =
> -	    tst_syscall(__NR_mq_open, mqname, O_RDWR | O_CREAT | O_EXCL, 0777,
> -		    NULL);
> -	if (mqd == (mqd_t) - 1) {
> -		tst_resm(TBROK, "parent: mq_open() failed (%s)",
> -			 strerror(errno));
> -		cleanup_mqueue(TBROK, F_STEP_0, 0);
> -	}
> -	tst_resm(TINFO, "parent: successfully created posix mqueue");
> +	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
> +	if (cpid < 0)
> +		tst_brk(TBROK | TERRNO, "clone failed");
>  
> -	/* container creation on PID namespace */
> -	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
> -	if (cpid < 0) {
> -		tst_resm(TBROK, "parent: clone() failed(%s)", strerror(errno));
> -		cleanup_mqueue(TBROK, F_STEP_1, mqd);
> -	}
> -	tst_resm(TINFO, "parent: successfully created child (pid = %d)", cpid);
> +	mqd = SAFE_MQ_OPEN(MQNAME, O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
>  
> -	/* Register for notification on message arrival */
>  	notif.sigev_notify = SIGEV_SIGNAL;
>  	notif.sigev_signo = SIGUSR1;
>  	info.mqd = mqd;
>  	info.pid = cpid;
>  	notif.sigev_value.sival_ptr = &info;
> -	if (tst_syscall(__NR_mq_notify, mqd, &notif) == (mqd_t) -1) {
> -		tst_resm(TBROK, "parent: mq_notify() failed (%s)",
> -			 strerror(errno));
> -		cleanup_mqueue(TBROK, F_STEP_1, mqd);
> -	}
> -	tst_resm(TINFO, "parent: successfully registered for notification");
>  
> -	/* Define handler for SIGUSR1 */
> -	sa.sa_flags = SA_SIGINFO;
> -	sigemptyset(&sa.sa_mask);
> -	sa.sa_sigaction = father_signal_handler;
> -	if (sigaction(SIGUSR1, &sa, NULL) == -1) {
> -		tst_resm(TBROK, "parent: sigaction() failed(%s)",
> -			 strerror(errno));
> -		cleanup_mqueue(TBROK, F_STEP_2, mqd);
> -	}
> -	tst_resm(TINFO, "parent: successfully registered handler for SIGUSR1");
> +	SAFE_MQ_NOTIFY(mqd, &notif);
>  
> -	/* Close the appropriate end of pipe */
> -	close(father_to_child[0]);
> +	sa.sa_flags = SA_SIGINFO;
> +	SAFE_SIGEMPTYSET(&sa.sa_mask);
> +	sa.sa_sigaction = child_signal_handler;
> +	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
>  
> -	/* Tell the child a message can be sent */
> -	if (write(father_to_child[1], "f:ok", 5) != 5) {
> -		tst_resm(TBROK, "parent: pipe is broken(%s)", strerror(errno));
> -		cleanup_mqueue(TBROK, F_STEP_2, mqd);
> -	}
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  
> -	sleep(3);
> +	SAFE_WAITPID(cpid, &status, 0);
>  
> -	/* Wait for child to finish */
> -	if (wait(&status) == -1) {
> -		tst_resm(TBROK, "parent: wait() failed(%s)", strerror(errno));
> -		cleanup_mqueue(TBROK, F_STEP_1, mqd);
> +	if (received != 1) {
> +		tst_res(TFAIL, "Signal hasn't been received after mqueue
> event");

Again you actually increment received so could be > 1 and we can use
TST_EXP_EQ to simplify things.

> +		return;
>  	}
>  
> -	cleanup_mqueue(result, F_STEP_3, mqd);
> -
> -	tst_exit();
> +	tst_res(TPASS, "Signal has been received after mqueue event");
>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_checkpoints = 1,
> +};
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
