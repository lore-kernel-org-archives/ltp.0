Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06059C05027
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 13:29:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 465823CD019
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 14:29:30 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 451393CB190
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 14:29:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 94E0B1401128
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 14:29:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A88D3EBA1;
 Fri, 10 Feb 2023 13:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676035755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G9z6TvH3tRXi+LIYIQrNZocorZaGKtVoBUzNDludpk0=;
 b=bdLCL/M14k3viwyssMaRcQyfbdYnL4DRqEv4Km/Fg0phUrv/AKs0Ncb/75NGydZRqnWCi2
 HtJRcshf0/26imrzbMWZLTvMLjmTTyh7rBfwxKXcbIO7CgrH9shjXA1ziKsbz69vBBw8pZ
 U0JVDjP0HKTFUNOhhkMbQfFDh7YsJBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676035755;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G9z6TvH3tRXi+LIYIQrNZocorZaGKtVoBUzNDludpk0=;
 b=5e+Y2Q24TFh/nbqunGStwzQEwW8aeoL1ReYcbp0P6fS6QxKJ9tOE6bI1mV5hEJmABnElgs
 hDZk9wqWU10ayHBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5676B1325E;
 Fri, 10 Feb 2023 13:29:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id K1QWFatG5mOKKwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Feb 2023 13:29:15 +0000
Date: Fri, 10 Feb 2023 14:30:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Y+ZHBcFBE3wbbMdZ@yuki>
References: <20230208094641.21560-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230208094641.21560-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Refactor pidns31 test using new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Usage of TST_* macros
> Usage of SAFE_CLONE
> Moved signal check out of signal handler
> Better TINFO message
> 
>  testcases/kernel/containers/pidns/pidns31.c | 360 +++++---------------
>  1 file changed, 82 insertions(+), 278 deletions(-)
> 
> diff --git a/testcases/kernel/containers/pidns/pidns31.c b/testcases/kernel/containers/pidns/pidns31.c
> index 8821ec83c..39dfb00eb 100644
> --- a/testcases/kernel/containers/pidns/pidns31.c
> +++ b/testcases/kernel/containers/pidns/pidns31.c
> @@ -1,330 +1,134 @@
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
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
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
> +#include "lapi/sched.h"
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
> +static siginfo_t info;
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
> +	if (mqd != -1)
> +		SAFE_MQ_CLOSE(mqd);
>  
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
> +	mq_unlink(MQNAME);
>  }
>  
> -/*
> - * cleanup_mqueue() - performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - * step == -1 means no local resource to remove.
> - */
> -void cleanup_mqueue(int result, int step, mqd_t mqd)
> +static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LTP_ATTRIBUTE_UNUSED void *unused)
                ^
		parent?
>  {
> -	if (step != NO_STEP)
> -		cleanup_resources(step, mqd);
> -
> -	tst_exit();
> +	memcpy(&info, si, sizeof(info));
> +	received++;
>  }
>  
> -/*
> - * child_fn() - Inside container
> - */
> -int child_fn(void *arg)
> +static void child_func(void)
>  {
> -	pid_t pid, ppid;
> -	mqd_t mqd;
> -	char buf[5];
> +	pid_t cpid, ppid;
> +	mqd_t mqd_child;
>  
> -	/* Set process id and parent pid */
> -	pid = getpid();
> +	cpid = getpid();
>  	ppid = getppid();
>  
> -	if (pid != CHILD_PID || ppid != PARENT_PID) {
> -		tst_resm(TBROK, "cinit: pidns is not created");
> -		cleanup_mqueue(TBROK, NO_STEP, 0);
> -	}
> -
> -	/* Close the appropriate end of pipe */
> -	close(father_to_child[1]);
> -
> -	/* Is parent ready to receive a message? */
> -	read(father_to_child[0], buf, 5);
> -	if (strcmp(buf, "f:ok")) {
> -		tst_resm(TBROK, "cinit: parent did not send the message!");
> -		cleanup_mqueue(TBROK, NO_STEP, 0);
> -	}
> -	tst_resm(TINFO, "cinit: my father is ready to receive a message");
> -
> -	mqd = tst_syscall(__NR_mq_open, mqname, O_WRONLY, 0, NULL);
> -	if (mqd == (mqd_t) - 1) {
> -		tst_resm(TBROK, "cinit: mq_open() failed (%s)",
> -			 strerror(errno));
> -		cleanup_mqueue(TBROK, NO_STEP, 0);
> -	}
> -	tst_resm(TINFO, "cinit: mq_open succeeded");
> -
> -	if (mq_send(mqd, MSG, strlen(MSG), MSG_PRIO) == (mqd_t) - 1) {
> -		tst_resm(TBROK, "cinit: mq_send() failed (%s)",
> -			 strerror(errno));
> -		cleanup_mqueue(TBROK, C_STEP_0, mqd);
> -	}
> -	tst_resm(TINFO, "cinit: mq_send() succeeded");
> -
> -	/* Cleanup and exit */
> -	cleanup_resources(C_STEP_1, mqd);
> -	exit(0);
> -}
> +	TST_EXP_EQ_LI(cpid, 1);
> +	TST_EXP_EQ_LI(ppid, 0);
>  
> -/*
> - * father_signal_handler()
> - */
> -static void father_signal_handler(int sig, siginfo_t * si, void *unused)
> -{
> -	char buf[256];
> -	struct mq_attr attr;
> -	struct notify_info *info;
> +	TST_CHECKPOINT_WAIT(0);
>  
> -	if (si->si_signo != SIGUSR1) {
> -		tst_resm(TBROK, "father: received %s unexpectedly",
> -			 strsignal(si->si_signo));
> -		return;
> -	}
> +	tst_res(TINFO, "Send mqueue message from child");
>  
> -	if (si->si_code != SI_MESGQ) {
> -		tst_resm(TBROK, "father: expected signal code SI_MESGQ - "
> -			 "Got %d", si->si_code);
> -		return;
> -	}
> +	mqd_child = SAFE_MQ_OPEN(MQNAME, O_WRONLY, 0, NULL);
> +	SAFE_MQ_SEND(mqd_child, "pippo", 5, 1);
>  
> -	if (!si->si_ptr) {
> -		tst_resm(TBROK, "father: expected si_ptr - Got NULL");
> -		return;
> -	}
> -
> -	info = (struct notify_info *)si->si_ptr;
> -
> -	if (si->si_pid != info->pid) {
> -		tst_resm(TFAIL,
> -			 "father: expected signal originator PID = %d - Got %d",
> -			 info->pid, si->si_pid);
> -		return;
> -	}
> -
> -	tst_resm(TPASS, "father: signal originator PID = %d", si->si_pid);
> -	result = TPASS;
> -
> -	/*
> -	 * Now read the message - Be silent on errors since this is not the
> -	 * test purpose.
> -	 */
> -	if (!mq_getattr(info->mqd, &attr))
> -		mq_receive(info->mqd, buf, attr.mq_msgsize, NULL);
> +	TST_CHECKPOINT_WAKE(0);
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
>  	pid_t cpid;
> -	mqd_t mqd;
> -	struct sigevent notif;
> -	struct sigaction sa;
>  	int status;
> -	struct notify_info info;
> +	struct sigaction sa;
> +	struct sigevent notif;
> +	struct notify_info n_info_send;
> +	struct notify_info *n_info_recv;
> +	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
>  
> -	setup();
> +	remove_mqueue(mqd);
> +	received = 0;
>  
> -	if (pipe(father_to_child) == -1) {
> -		tst_resm(TBROK, "parent: pipe() failed. aborting!");
> -		cleanup_mqueue(TBROK, NO_STEP, 0);
> +	cpid = SAFE_CLONE(&args);
> +	if (!cpid) {
> +		child_func();
> +		return;
>  	}
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
> +	tst_res(TINFO, "Register notification on posix mqueue");
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
> -	info.mqd = mqd;
> -	info.pid = cpid;
> -	notif.sigev_value.sival_ptr = &info;
> -	if (tst_syscall(__NR_mq_notify, mqd, &notif) == (mqd_t) -1) {
> -		tst_resm(TBROK, "parent: mq_notify() failed (%s)",
> -			 strerror(errno));
> -		cleanup_mqueue(TBROK, F_STEP_1, mqd);
> -	}
> -	tst_resm(TINFO, "parent: successfully registered for notification");
> +	n_info_send.mqd = mqd;
> +	n_info_send.pid = cpid;
> +	notif.sigev_value.sival_ptr = &n_info_send;

Is there actually any reason to pack these parameters and save it in the
sival_ptr now that we do not attempt to validate the values inside fo
the signal handler?

Can we please drop the whole structure and just use cpid in the
TST_EXP_EQ_LI() instead?

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
> +	if (!received) {
> +		tst_res(TFAIL, "Signal notification has not been received");
> +		return;
>  	}
>  
> -	cleanup_mqueue(result, F_STEP_3, mqd);
> +	n_info_recv = (struct notify_info *)info.si_ptr;
>  
> -	tst_exit();
> +	TST_EXP_EQ_LI(received, 1);
              ^
	      Huh? We just checked the value a few lines above.

> +	TST_EXP_EQ_LI(info.si_signo, SIGUSR1);
> +	TST_EXP_EQ_LI(info.si_code, SI_MESGQ);
> +	TST_EXP_POSITIVE(info.si_pid);

Do we really need to check that it's possitive if we compare it to cpid.

> +	TST_EXP_EQ_LI(n_info_recv->pid, info.si_pid);
>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +	.needs_root = 1,
> +	.needs_checkpoints = 1,
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
