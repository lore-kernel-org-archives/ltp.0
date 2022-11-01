Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9A8FA373D
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 12:22:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA8563CAC5A
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 13:22:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5CEF3CAC2D
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 13:21:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E4254600841
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 13:21:58 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2F5AB3373A;
 Tue,  1 Nov 2022 12:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667305318;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qRsQixlk60YR87nMmsTmrtdygh2z93H9u1iXHApqHGE=;
 b=j9RKJ/e9dv9fZh1mwJ4J68BKpAZMKpPL65bcGg89RAXG9eTD0Z6XIhfa4buBPIdTG1/dRX
 qOzLTwxLHsbVSCcjIQAe71WZa4oBrNjp2njIBSsyYKoFgOYW7SLD11hDj6FuXTPrc3t3RP
 /ca7lzBToIWseTGDKsCcARihXGeOx5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667305318;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qRsQixlk60YR87nMmsTmrtdygh2z93H9u1iXHApqHGE=;
 b=h3NCeAqB8N+kkx/iyrZ/BvuVJcS/quGgGI7iPfhgTO+6Kj331RZh1JQNzxF9dIakfMnXew
 g7YQsR5bfvGQvJDA==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7DF082C141;
 Tue,  1 Nov 2022 12:21:57 +0000 (UTC)
References: <20220816113142.25638-1-andrea.cervesato@suse.com>
 <20220816113142.25638-3-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 01 Nov 2022 12:01:34 +0000
Organization: Linux Private Site
In-reply-to: <20220816113142.25638-3-andrea.cervesato@suse.com>
Message-ID: <87r0ym9868.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] Refactor pidns30 test using new LTP API
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
>  testcases/kernel/containers/pidns/pidns30.c | 312 +++++---------------
>  1 file changed, 66 insertions(+), 246 deletions(-)
>
> diff --git a/testcases/kernel/containers/pidns/pidns30.c b/testcases/kernel/containers/pidns/pidns30.c
> index c8b0806c0..b01759a87 100644
> --- a/testcases/kernel/containers/pidns/pidns30.c
> +++ b/testcases/kernel/containers/pidns/pidns30.c
> @@ -1,296 +1,116 @@
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
> -* File: pidns30.c
> -*
> -*   Description:
> -*    This testcase checks if the si_pid is correctly set when a process
> -*    that has registered for notification on a posix mqueue is in a
> -*    descendant namespace wrt the process that sends a message to that posix
> -*    mqueue.
> -*
> -*   Test Assertion & Strategy:
> -*    Parent                                   Child
> -*    --------------------------------------------------------------------------
> -*    Create a POSIX mqueue.
> -*    Create a PID namespace container.
> -*                                             Open that mqueue for reading
> -*                                             Register for notification when a
> -*                                                message arrives in that mqueue
> -*                                             Install a handler for SIGUSR1.
> -*    Write something to the mqueue.
> -*                                             Inside the handler, check that
> -*                                                si_pid is set to 0
> -*
> -*   Usage: <for command-line>
> -*    pidns30
> -*
> -*   History:
> -*    DATE      NAME                             DESCRIPTION
> -*    01/12/08  Nadia Derbey               Creation of this test.
> -*              <Nadia.Derbey@bull.net>
> -*
> -******************************************************************************/
> + * Copyright (c) Bull S.A.S. 2008
> + *               01/12/08  Nadia Derbey <Nadia.Derbey@bull.net>
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Clone a process with CLONE_NEWPID flag, register notification on a posix
> + * mqueue and send a mqueue message from the parent. Then check if signal
> + * notification contains si_pid of the parent.
> + */
> +
>  #define _GNU_SOURCE 1
> -#include <sys/wait.h>
> -#include <sys/types.h>
>  #include <signal.h>
> -#include <stdlib.h>
> -#include <unistd.h>
> -#include <stdio.h>
>  #include <mqueue.h>
> -#include "lapi/syscalls.h"
> -#include "pidns_helper.h"
> -#include "test.h"
> -
> -char *TCID = "pidns30";
> -int TST_TOTAL = 1;
> -
> -char *mqname = "mq1";
> -int result = TFAIL;
> +#include "tst_test.h"
> +#include "tst_safe_posix_ipc.h"
> +#include "lapi/namespaces_constants.h"
>  
> -int father_to_child[2];
> -int child_to_father[2];
> +#define MQNAME "/LTP_PIDNS30_MQ"
>  
> -#define CHILD_PID       1
> -#define PARENT_PID      0
> -
> -#define MSG      "HOW ARE YOU"
> -#define MSG_PRIO 1
> -
> -#define NO_STEP	-1
> -#define F_STEP_0 0x00
> -#define F_STEP_1 0x01
> -#define F_STEP_2 0x02
> -#define F_STEP_3 0x03
> -#define C_STEP_0 0x10
> -#define C_STEP_1 0x11
> -#define C_STEP_2 0x12
> -
> -mqd_t rc = -1;
> -mqd_t mqd = -1;
> -
> -static void remove_pipe(int *fd)
> -{
> -	close(fd[0]);
> -	close(fd[1]);
> -}
> +static mqd_t mqd = -1;
> +static int received;

This should be volatile because it is used in the sighandler.

>  
>  static void remove_mqueue(mqd_t mqd)
>  {
> -	mq_close(mqd);
> -	tst_syscall(__NR_mq_unlink, mqname);
> -}
> -
> -static void cleanup(void)
> -{
> -	if (mqd != -1) {
> -		remove_mqueue(mqd);
> -	}
> -	if (rc != -1) {
> -		remove_mqueue(rc);
> -	}
> -	remove_pipe(father_to_child);
> -	remove_pipe(child_to_father);
> -}
> +	if (mqd != -1)
> +		SAFE_MQ_CLOSE(mqd);
>  
> -static void cleanup_child(void)
> -{
> -	if (mqd != -1) {
> -		tst_syscall(__NR_mq_notify, mqd, NULL);
> -	}
> -	cleanup();
> +	mq_unlink(MQNAME);

We don't know that mq_unlink ever succeeds as we never check the
result. This seems like lazyness because it is used at the beginning of
run where it is expected to fail.

>  }
>  
> -/*
> - * child_signal_handler() - to handle SIGUSR1
> - *
> - * XXX (garrcoop): add calls to cleanup_child() -- or should this be handled
> - * from the libltp signal handler?
> - */
> -static void child_signal_handler(int sig, siginfo_t * si, void *unused)
> +static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LTP_ATTRIBUTE_UNUSED void *unused)
>  {
> -	char buf[256];
> -	struct mq_attr attr;
> +	tst_res(TINFO, "Received signal %s from pid %d",
> tst_strsig(si->si_signo), si->si_pid);

Again we should avoid calling tst_res in the signal handler

>  
> -	if (si->si_signo != SIGUSR1) {
> -		printf("received signal = %d unexpectedly\n", si->si_signo);
> +	if (si->si_signo != SIGUSR1 || si->si_code != SI_MESGQ ||
> si->si_pid != 0)

If the wrong signal or details are sent then we won't get any debug
information. Unlike with the old version.

>  		return;
> -	}
> -
> -	if (si->si_code != SI_MESGQ) {
> -		printf("expected signal code SI_MESGQ; got %d instead\n",
> -		       si->si_code);
> -		return;
> -	}
> -
> -	if (si->si_pid) {
> -		printf("expected signal originator PID = 0; got %d instead\n",
> -		       si->si_pid);
> -		return;
> -	} else {
> -		printf("signal originator PID = 0\n");
> -		result = TPASS;
> -	}
>  
> -	/*
> -	 * Now read the message - Be silent on errors since this is not the
> -	 * test purpose.
> -	 */
> -	rc = mq_getattr(si->si_int, &attr);
> -	if (rc != -1)
> -		mq_receive(si->si_int, buf, attr.mq_msgsize, NULL);
> +	received++;
>  }
>  
> -/*
> - * child_fn() - Inside container
> - *
> - * XXX (garrcoop): add more calls to cleanup_child()?
> - */
> -int child_fn(void *arg)
> +static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>  {
> -	pid_t pid, ppid;
> +	pid_t cpid, ppid;
>  	struct sigaction sa;
>  	struct sigevent notif;
> -	char buf[5];
> +	mqd_t mqd_child;
>  
> -	/* Set process id and parent pid */
> -	pid = getpid();
> +	cpid = getpid();
>  	ppid = getppid();
>  
> -	if (pid != CHILD_PID || ppid != PARENT_PID) {
> -		printf("pidns was not created\n");
> -		return 1;
> +	if (cpid != 1 || ppid != 0) {
> +		tst_res(TFAIL, "got unexpected result of cpid=%d ppid=%d", cpid, ppid);
> +		return 0;

Again TST_EXP_EQ*

>  	}
>  
> -	/* Close the appropriate end of each pipe */
> -	close(child_to_father[0]);
> -	close(father_to_child[1]);
> +	TST_CHECKPOINT_WAIT(0);
>  
> -	while (read(father_to_child[0], buf, 1) != 1)
> -		sleep(1);
> -
> -	mqd = tst_syscall(__NR_mq_open, mqname, O_RDONLY, 0, NULL);
> -	if (mqd == -1) {
> -		perror("mq_open failed");
> -		return 1;
> -	} else
> -		printf("mq_open succeeded\n");
> -
> -	/* Register for notification on message arrival */
> +	mqd_child = SAFE_MQ_OPEN(MQNAME, O_RDONLY, 0, NULL);
>  	notif.sigev_notify = SIGEV_SIGNAL;
>  	notif.sigev_signo = SIGUSR1;
> -	notif.sigev_value.sival_int = mqd;
> -	if (tst_syscall(__NR_mq_notify, mqd, &notif) == -1) {
> -		perror("mq_notify failed");
> -		return 1;
> -	} else
> -		printf("successfully registered for notification\n");
> +	notif.sigev_value.sival_int = mqd_child;
> +
> +	SAFE_MQ_NOTIFY(mqd_child, &notif);
>  
> -	/* Define handler for SIGUSR1 */
>  	sa.sa_flags = SA_SIGINFO;
> -	sigemptyset(&sa.sa_mask);
> +	SAFE_SIGEMPTYSET(&sa.sa_mask);
>  	sa.sa_sigaction = child_signal_handler;
> -	if (sigaction(SIGUSR1, &sa, NULL) == -1) {
> -		perror("sigaction failed");
> -		return 1;
> -	} else
> -		printf("successfully registered handler for SIGUSR1\n");
> +	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
>  
> -	/* Ask parent to send a message to the mqueue */
> -	if (write(child_to_father[1], "c:ok", 5) != 5) {
> -		perror("write failed");
> -		return 1;
> -	}
> -
> -	sleep(3);
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  
> -	/* Has parent sent a message? */
> -	read(father_to_child[0], buf, 5);
> -	if (strcmp(buf, "f:ok") != 0) {
> -		printf("parent did not send the message!\n");
> -		return 1;
> +	if (received != 1) {
> +		tst_res(TFAIL, "Signal hasn't been received after mqueue
> event");

If we receive more than one signal then this will also be printed. In
any case we can shorted this with TST_EXP_EQ_*.

> +		return 0;
>  	}
> -	printf("parent is done - cleaning up\n");
>  
> -	cleanup_child();
> +	tst_res(TPASS, "Signal has been received after mqueue event");
>  
> -	exit(0);
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
> -int main(void)
> +static void run(void)
>  {
> -	int status;
> -	char buf[5];
> -	pid_t cpid;
> -
> -	setup();
> -
> -	if (pipe(child_to_father) == -1 || pipe(father_to_child) == -1) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "pipe failed");
> -	}
> +	int ret;
>  
> -	tst_syscall(__NR_mq_unlink, mqname);
> +	remove_mqueue(mqd);
>  
> -	/* container creation on PID namespace */
> -	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
> -	if (cpid == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
> +	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "clone failed");
>  
> -	mqd =
> -	    tst_syscall(__NR_mq_open, mqname, O_RDWR | O_CREAT | O_EXCL, 0777,
> -		    NULL);
> -	if (mqd == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "mq_open failed");
> -	else
> -		tst_resm(TINFO, "successfully created posix mqueue");
> +	mqd = SAFE_MQ_OPEN(MQNAME, O_RDWR | O_CREAT | O_EXCL, 0777, 0);
>  
> -	if (write(father_to_child[1], buf, 1) != 1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "write failed");
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  
> -	/* Close the appropriate end of each pipe */
> -	close(child_to_father[1]);
> -	close(father_to_child[0]);
> +	SAFE_MQ_SEND(mqd, "pippo", 5, 1);
>  
> -	/* Is container ready */
> -	read(child_to_father[0], buf, 5);
> -	if (strcmp(buf, "c:ok") != 0)
> -		tst_brkm(TBROK, cleanup,
> -			 "container did not respond as expected!");
> -
> -	rc = mq_send(mqd, MSG, strlen(MSG), MSG_PRIO);
> -	if (rc == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "mq_send failed");
> -	else
> -		tst_resm(TINFO, "mq_send succeeded");
> -
> -	/* Tell the child the message has been sent */
> -	if (write(father_to_child[1], "f:ok", 5) != 5)
> -		tst_brkm(TBROK | TERRNO, cleanup, "write failed");
> -
> -	/* Wait for child to finish */
> -	if (wait(&status) == -1)
> -		tst_resm(TBROK | TERRNO, "wait failed");
> -
> -	cleanup();
> -
> -	tst_exit();
> +	TST_CHECKPOINT_WAKE(0);
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
