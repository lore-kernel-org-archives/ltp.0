Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27328E92711
	for <ltp@archiver.kernel.org>; Fri,  6 Oct 2023 10:53:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9A1F3C2DA4
	for <ltp@archiver.kernel.org>; Fri,  6 Oct 2023 12:53:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A44A13C2DA4
 for <ltp@lists.linux.it>; Fri,  6 Oct 2023 12:53:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 49E40601BC5
 for <ltp@lists.linux.it>; Fri,  6 Oct 2023 12:53:03 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 03B111F895;
 Fri,  6 Oct 2023 10:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696589583;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tTrmZY65HutMsZ8GrxmabqyZxIknX/HpQjzf9MBvnUI=;
 b=WsJuNWbvcPtuUc/MBNmVPEMp4KY8nT0U6asd306HDw8XhCZZE2Eah8sN5n86qvfOd9FlQu
 ecekK+nDZQjVwv58c7aSpdJTvix11Nn4CF+m8vHUtnVdW9Yu79u+YF9tkRrHHZi7ny+YK4
 rhAIEG/q9g5oZxAyXpWGlvLgEVHvgD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696589583;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tTrmZY65HutMsZ8GrxmabqyZxIknX/HpQjzf9MBvnUI=;
 b=vENqNG9qzkjXglPNw8++d5B9NOFUpXCAeeMzhKvD1Jskrdfd3MmB4emFGAbDIec1fMZmhx
 5xGatQ43Pl6hDxCw==
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id ADBD62C142;
 Fri,  6 Oct 2023 10:53:02 +0000 (UTC)
References: <20230906080950.23155-1-andrea.cervesato@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 06 Oct 2023 11:14:32 +0100
Organization: Linux Private Site
In-reply-to: <20230906080950.23155-1-andrea.cervesato@suse.de>
Message-ID: <87a5sw10qb.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor fork12 using new LTP API
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

Andrea Cervesato <andrea.cervesato@suse.de> writes:

> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/syscalls/fork/fork12.c | 177 +++++++++---------------
>  1 file changed, 62 insertions(+), 115 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fork/fork12.c b/testcases/kernel/syscalls/fork/fork12.c
> index 1c55c0c30..d8767859f 100644
> --- a/testcases/kernel/syscalls/fork/fork12.c
> +++ b/testcases/kernel/syscalls/fork/fork12.c
> @@ -1,137 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - *
> - *
> - * NAME
> - *	fork12.c
> - *
> - * DESCRIPTION
> - *	Check that all children inherit parent's file descriptor
> - *
> - * ALGORITHM
> - *	Parent forks processes until -1 is returned.$
> - *
> - * USAGE
> - *	fork12
> - *	** CAUTION ** Can hang your machine, esp prior to 2.4.19
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *	07/2002 Split from fork07 as a test case to exhaust available pids.
> + * Copyright (c) International Business Machines  Corp., 2001
> + *     07/2001 Ported by Wayne Boyer
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +/*\
> + *[Description]
>   *
> - * RESTRICTIONS
> - *	Should be run as root to avoid resource limits.$
> - *	Should not be run with other test programs because it tries to
> - *	  use all available pids.
> + * This test spawns multiple processes inside a child, until fork() returns -1.
> + * Then we check if EAGAIN is raised.
>   */
>  
> -#include <stdio.h>
> +#include <stdlib.h>
>  #include <sys/wait.h>
> -#include <errno.h>
> -#include <string.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -char *TCID = "fork12";
> -int TST_TOTAL = 1;
> +#include "tst_test.h"
>  
> -static void setup(void);
> -static void cleanup(void);
> -static void fork12_sigs(int signum);
> +static pid_t child_pid;
>  
> -int main(int ac, char **av)
> +static void start_forking(void)
>  {
> -	int forks, pid1, fork_errno, waitstatus;
> -	int ret, status;
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		tst_resm(TINFO, "Forking as many kids as possible");
> -		forks = 0;
> -		while ((pid1 = fork()) != -1) {
> -			if (pid1 == 0) {	/* child */
> -				/*
> -				 * Taunt the OOM killer so that it doesn't
> -				 * kill system processes
> -				 */
> -				SAFE_FILE_PRINTF(NULL,
> -					"/proc/self/oom_score_adj", "500");
> -				pause();
> -				exit(0);
> -			}
> -			forks++;
> -			ret = SAFE_WAITPID(cleanup, -1, &status, WNOHANG);
> -			if (ret > 0) {
> -				/* a child may be killed by OOM killer */
> -				if (WTERMSIG(status) == SIGKILL)
> -					break;
> -				tst_brkm(TBROK, cleanup,
> -					 "child exit with error code %d or signal %d",
> -					 WEXITSTATUS(status), WTERMSIG(status));
> -			}
> +	pid_t pid;
> +	int status;
> +	int forks = 1;
> +
> +	tst_res(TINFO, "Forking as many children as possible");
> +
> +	while (1) {
> +		TEST(fork());
> +		pid = TST_RET;
> +
> +		if (pid == -1)
> +			break;
> +
> +		if (!pid) {
> +			/*
> +			 * Taunt the OOM killer so that it doesn't
> +			 * kill system processes
> +			 */
> +			SAFE_FILE_PRINTF("/proc/self/oom_score_adj", "500");
> +			pause();
> +			exit(0);
>  		}
> -		fork_errno = errno;
> -
> -		/* parent */
> -		tst_resm(TINFO, "Number of processes forked is %d", forks);
> -		tst_resm(TPASS, "fork() eventually failed with %d: %s",
> -			 fork_errno, strerror(fork_errno));
> -		/* collect our kids */
> -		/*
> -		 * Introducing a sleep(3) to make sure all children are
> -		 * at pause() when SIGQUIT is sent to them
> -		 */
> -		sleep(3);
> -		kill(0, SIGQUIT);
> -		while (wait(&waitstatus) > 0) ;
>  
> +		forks++;
> +
> +		if (SAFE_WAITPID(-1, &status, WNOHANG) > 0) {
> +			tst_brk(TBROK, "child exit with error code %d or signal %d",
> +					WEXITSTATUS(status),
> +					WTERMSIG(status));
> +		}
>  	}
>  
> -	cleanup();
> -	tst_exit();
> +	tst_res(TINFO, "Number of processes forked is %d", forks);
> +	TST_EXP_EXPR(TST_ERR == EAGAIN, "last fork() failed with
> EAGAIN");

I think it should at least accept ENOMEM as well.

>  }
>  
> -static void setup(void)
> +static void run(void)
>  {
> -	tst_sig(FORK, fork12_sigs, cleanup);
> -	TEST_PAUSE;
> +	int status;
> +
> +	child_pid = SAFE_FORK();
> +	if (!child_pid) {

Maybe here we should start a new process group which we can kill later
in cleanup.

I guess you would call SAFE_SETPGID(0, 0) here.

> +		start_forking();
> +		return;
> +	}
> +
> +	SAFE_WAIT(&status);
>  }
>  
>  static void cleanup(void)
>  {
> -	int waitstatus;
> +	kill(child_pid, 0);
>  
> -	/* collect our kids */
> -	kill(0, SIGQUIT);
> -	while (wait(&waitstatus) > 0) ;
> +	if (errno != ESRCH)

Possibly errno is undefined if the call to kill was successful. Also
there is a race here. You probably should just do an unconditional
SIGKILL to all the children.

If you have a process group as mentioned above, then you should be able
to call kill(-child_pid, SIGKILL).

> +		SAFE_KILL(child_pid, SIGKILL);
>  }
>  
> -static void fork12_sigs(int signum)
> -{
> -	if (signum == SIGQUIT) {
> -		/* Children will continue, parent will ignore */
> -	} else {
> -		tst_brkm(TBROK, cleanup,
> -			 "Unexpected signal %d received.", signum);
> -	}
> -}
> +static struct tst_test test = {
> +	.test_all = run,
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +	.max_runtime = 600,
> +};
> -- 
> 2.35.3

BTW, tests like this seem to cause containers to become unresponsive. If
Kirk or LTX are running in the same container without any further
isolation then we could use all the resources assigned to a container on
forking. We can lock LTX in memory, but that still leaves CPU.

Perhaps the test could reduce its own process and memory limit? e.g. with prlimit


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
