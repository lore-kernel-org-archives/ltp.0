Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30480C636CC
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 15:20:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 479E03CBF84
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 16:20:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69F333C1D84
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 16:20:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6CD22140055B
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 16:20:02 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 48D7821864;
 Mon, 13 Feb 2023 15:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676301602;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3QX3a/q1LYNrnc9HsVqYdXorkQL0oCbsnxNm//dCurg=;
 b=FFZJm2eA4z/0JQ7Q4k6xr5bJkdpaKGWSRpmjVZmPr9U9skwXztjQpd7uUQdJTJfCLY/Tk5
 q3SH5C5ApdY2h77EEaxr8Iex/g+1u18HOp/7NmSyEvvBYsNqkJuQiVYhragK3VmK98DS0E
 8CsQYvNlfyqwDfbRXkM3q2HPsgmuEKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676301602;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3QX3a/q1LYNrnc9HsVqYdXorkQL0oCbsnxNm//dCurg=;
 b=yqFUklV42DsOzv8tH2RH5uwCCIEfYOn6xQRl757pmNJS8bwCToN+5B2nGFUdHHuFWl1+x6
 cQZnl9vWq1dp3nDQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 184042C143;
 Mon, 13 Feb 2023 15:20:02 +0000 (UTC)
References: <20230207122731.29303-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Mon, 13 Feb 2023 15:19:15 +0000
Organization: Linux Private Site
In-reply-to: <20230207122731.29303-1-andrea.cervesato@suse.com>
Message-ID: <874jrppp7n.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Refactor pidns16 test using new LTP API
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

Merged without child return value and I added volatile to the
signal_pid.

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Removed counter flag that now is unused
>
>  testcases/kernel/containers/pidns/pidns16.c | 191 ++++++--------------
>  1 file changed, 60 insertions(+), 131 deletions(-)
>
> diff --git a/testcases/kernel/containers/pidns/pidns16.c b/testcases/kernel/containers/pidns/pidns16.c
> index 2ee61065a..430cf4dd8 100644
> --- a/testcases/kernel/containers/pidns/pidns16.c
> +++ b/testcases/kernel/containers/pidns/pidns16.c
> @@ -1,157 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> -* Copyright (c) International Business Machines Corp., 2007
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
> -
> -* * Test Assertion.
> -* *----------------
> -* * kill -USR1 container_init
> -* *	- from the parent process and also inside a container
> -* *	- Where init has defined a custom handler for USR1
> -* *	- Should call the handler and
> -* *	- Verify whether the signal handler is called from the proper process.
> -* *
> -* * Description:
> -* *  Create PID namespace container.
> -* *  Container init defines the handler for SIGUSR1 and waits indefinetly.
> -* *  Parent sends SIGUSR1 to container init.
> -* *  The signal handler is handled and the cont-init resumes normally.
> -* *  From the container, again the signal SIGUSR1 is sent.
> -* *  In the sig-handler check if it's invoked from correct pid(parent/container)
> -* *  If cont-init wakes up properly -
> -* *  it will return expected value at exit which is verified at the end.
> -* *
> -* * History:
> -* *  DATE	  NAME				   DESCRIPTION
> -* *  04/11/08  Veerendra C  <vechandr@in.ibm.com> Verifying cont init kill -USR1
> -*
> -*******************************************************************************/
> -#include "config.h"
> + * Copyright (c) International Business Machines Corp., 2007
> + *               04/11/08  Veerendra C  <vechandr@in.ibm.com>
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Clone a process with CLONE_NEWPID flag and verifies that siginfo->si_pid is
> + * set to 0 if sender (parent process) sent the signal. Then send signal from
> + * container itself and check if siginfo->si_pid is set to 1.
> + */
>  
>  #define _GNU_SOURCE 1
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <sys/wait.h>
> -#include <sys/types.h>
>  #include <signal.h>
> -#include <unistd.h>
> -#include "pidns_helper.h"
> -#include "test.h"
> -
> -#define CHILD_PID	1
> -#define PARENT_PID	0
> +#include "tst_test.h"
> +#include "lapi/sched.h"
>  
> -char *TCID = "pidns16";
> -int TST_TOTAL = 3;
> +static int signal_pid;
>  
> -void child_signal_handler(int sig, siginfo_t * si, void *unused)
> +static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LTP_ATTRIBUTE_UNUSED void *unused)
>  {
> -	static int c = 1;
> -	pid_t expected_pid;
> -
> -	/* Verifying from which process the signal handler is signalled */
> -
> -	switch (c) {
> -	case 1:
> -		expected_pid = PARENT_PID;
> -		break;
> -	case 2:
> -		expected_pid = CHILD_PID;
> -		break;
> -	default:
> -		tst_resm(TBROK, "child should NOT be signalled 3+ times");
> -		return;
> -	}
> -
> -	if (si->si_pid == expected_pid)
> -		tst_resm(TPASS, "child is signalled from expected pid %d",
> -			 expected_pid);
> -	else
> -		tst_resm(TFAIL, "child is signalled from unexpected pid %d,"
> -			 " expecting pid %d", si->si_pid, expected_pid);
> -
> -	c++;
> +	signal_pid = si->si_pid;
>  }
>  
> -/*
> - * child_fn() - Inside container
> - */
> -int child_fn(void *ttype)
> +static int child_func(void)
>  {
>  	struct sigaction sa;
> -	pid_t pid, ppid;
> +	pid_t cpid, ppid;
>  
> -	/* Set process id and parent pid */
> -	pid = getpid();
> +	cpid = getpid();
>  	ppid = getppid();
>  
> -	if ((pid != CHILD_PID) || (ppid != PARENT_PID))
> -		tst_resm(TBROK, "pidns is not created.");
> +	TST_EXP_EQ_LI(cpid, 1);
> +	TST_EXP_EQ_LI(ppid, 0);
> +
> +	tst_res(TINFO, "Catching SIGUSR1 signal");
>  
> -	/* Set signal handler for SIGUSR1, also mask other signals */
>  	sa.sa_flags = SA_SIGINFO;
> -	sigemptyset(&sa.sa_mask);
> +	SAFE_SIGFILLSET(&sa.sa_mask);
>  	sa.sa_sigaction = child_signal_handler;
> -	if (sigaction(SIGUSR1, &sa, NULL) == -1)
> -		tst_resm(TBROK, "%d: sigaction() failed", pid);
> -
> -	pause();
> -	tst_resm(TINFO, "Container: Resumed after receiving SIGUSR1 "
> -		 "from parentNS ");
> -	if (kill(pid, SIGUSR1) != 0) {
> -		tst_resm(TFAIL, "kill(SIGUSR1) fails.");
> -	}
> -	tst_resm(TINFO, "Container: Resumed after sending SIGUSR1 "
> -		 "from container itself");
> -	_exit(10);
> -}
> +	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
>  
> -static void setup(void)
> -{
> -	tst_require_root();
> -	check_newpid();
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +
> +	TST_EXP_EQ_LI(signal_pid, 0);
> +
> +	tst_res(TINFO, "Sending SIGUSR1 from container itself");
> +
> +	SAFE_KILL(cpid, SIGUSR1);
> +
> +	TST_EXP_EQ_LI(signal_pid, 1);
> +
> +	return 0;
>  }
>  
> -/***********************************************************************
> -*   M A I N
> -***********************************************************************/
> -int main()
> +static void run(void)
>  {
> -	int status;
> -	pid_t cpid;
> -
> -	setup();
> +	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
> +	pid_t pid;
>  
> -	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
> +	signal_pid = -1;
>  
> -	if (cpid < 0) {
> -		tst_resm(TBROK, "clone() failed.");
> +	pid = SAFE_CLONE(&args);
> +	if (!pid) {
> +		child_func();
> +		return;
>  	}
>  
> -	sleep(1);
> -	if (kill(cpid, SIGUSR1) != 0) {
> -		tst_resm(TFAIL, "kill(SIGUSR1) fails.");
> -	}
> -	sleep(1);
> -	if (waitpid(cpid, &status, 0) < 0)
> -		tst_resm(TWARN, "waitpid() failed.");
> -
> -	if ((WIFEXITED(status)) && (WEXITSTATUS(status) == 10))
> -		tst_resm(TPASS, "container init continued successfuly, "
> -			 "after handling signal -USR1");
> -	else
> -		tst_resm(TFAIL, "c-init failed to continue after "
> -			 "passing kill -USR1");
> -	tst_exit();
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	tst_res(TINFO, "Sending SIGUSR1 from parent");
> +
> +	SAFE_KILL(pid, SIGUSR1);
> +
> +	TST_CHECKPOINT_WAKE(0);
>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_root = 1,
> +	.needs_checkpoints = 1,
> +	.forks_child = 1,
> +};
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
