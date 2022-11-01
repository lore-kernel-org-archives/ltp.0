Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F023C433FE
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 11:13:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93F123CAD0D
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 12:13:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BE363CAC37
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 12:13:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 865476006E2
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 12:13:26 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6C5971F90D;
 Tue,  1 Nov 2022 11:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667301206;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VfrRbsztkBJKcXZMR4ovhvXZ2UIr/dw7y9gXox2k2yQ=;
 b=RehsIYnFMjbW7b/BXO36tnXu/46lsVycW9u2lWgHDOz1f9BCgksegVfMVIkbD73e6F4LIW
 5Z3g4j1C0h+AjpePDqo6TiyD9JXCwkFY3lyvKRlkQE1u7Wr0fVm8zRscOYKL1H3n0Uk/0Z
 jNFiSht3IvoewdJk/3lQQg1GnM6q/fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667301206;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VfrRbsztkBJKcXZMR4ovhvXZ2UIr/dw7y9gXox2k2yQ=;
 b=pEhqMfdcEEp1c18ZnDa+sAuZPjUvVAEy0EKPw8O8nUTOwOu6/XhZZt0LBhFKVSIZ7nw3rH
 yQsEf8rBEbuG9XAQ==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id DEF702C141;
 Tue,  1 Nov 2022 11:13:25 +0000 (UTC)
References: <20220816080836.5063-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 01 Nov 2022 11:06:22 +0000
Organization: Linux Private Site
In-reply-to: <20220816080836.5063-1-andrea.cervesato@suse.com>
Message-ID: <874jvj9bca.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor pidns16 test using new LTP API
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
>  testcases/kernel/containers/pidns/pidns16.c | 197 +++++++-------------
>  1 file changed, 68 insertions(+), 129 deletions(-)
>
> diff --git a/testcases/kernel/containers/pidns/pidns16.c b/testcases/kernel/containers/pidns/pidns16.c
> index 2ee61065a..d11e8eaa1 100644
> --- a/testcases/kernel/containers/pidns/pidns16.c
> +++ b/testcases/kernel/containers/pidns/pidns16.c
> @@ -1,157 +1,96 @@
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
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
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
> +#include "lapi/namespaces_constants.h"
>  
> -char *TCID = "pidns16";
> -int TST_TOTAL = 3;
> +static volatile int exp_pid;
> +static volatile int passed;
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
> +	tst_res(TINFO, "Received signal %s from PID %d",
> tst_strsig(si->si_signo), si->si_pid);

I missed this on pidns12. We are calling tst_res in a signal
handler which Cyril warned against

"The bigger problem though is that we call tst_brk() and tst_res() in the
handler, which is not safe at all. The are couple things that can go
wrong here, mostly glibc locks can get deadlocked for the underlying
FILE* and if the underlying fprintf() calls malloc() the malloc data
structures may end up corrupted. It's quite rare for this to happen, but
there have been a few tests that were failing with small probability due
to these mistakes."

We should only save the values in the sighandler and check them in the
main child function.

>  
> -	if (si->si_pid == expected_pid)
> -		tst_resm(TPASS, "child is signalled from expected pid %d",
> -			 expected_pid);
> -	else
> -		tst_resm(TFAIL, "child is signalled from unexpected pid %d,"
> -			 " expecting pid %d", si->si_pid, expected_pid);
> +	if (si->si_signo != SIGUSR1)
> +		return;
>  
> -	c++;
> +	if (si->si_pid == exp_pid)
> +		passed = 1;
>  }
>  
> -/*
> - * child_fn() - Inside container
> - */
> -int child_fn(void *ttype)
> +static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
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
> +	if (cpid != 1 || ppid != 0) {
> +		tst_res(TFAIL, "Got unexpected result of cpid=%d ppid=%d", cpid, ppid);
> +		return 1;

Same with TST_EXP_EQ

> +	}
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
>  
> -static void setup(void)
> -{
> -	tst_require_root();
> -	check_newpid();
> -}
> +	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
>  
> -/***********************************************************************
> -*   M A I N
> -***********************************************************************/
> -int main()
> -{
> -	int status;
> -	pid_t cpid;
> +	passed = 0;
> +	exp_pid = 0;
>  
> -	setup();
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  
> -	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
> +	if (passed)
> +		tst_res(TPASS, "Container resumed after receiving SIGUSR1 from parent namespace");
> +	else
> +		tst_res(TFAIL, "Container did not receive the SIGUSR1 signal from parent");
>  
> -	if (cpid < 0) {
> -		tst_resm(TBROK, "clone() failed.");
> -	}
> +	passed = 0;
> +	exp_pid = 1;
>  
> -	sleep(1);
> -	if (kill(cpid, SIGUSR1) != 0) {
> -		tst_resm(TFAIL, "kill(SIGUSR1) fails.");
> -	}
> -	sleep(1);
> -	if (waitpid(cpid, &status, 0) < 0)
> -		tst_resm(TWARN, "waitpid() failed.");
> +	SAFE_KILL(cpid, SIGUSR1);
>  
> -	if ((WIFEXITED(status)) && (WEXITSTATUS(status) == 10))
> -		tst_resm(TPASS, "container init continued successfuly, "
> -			 "after handling signal -USR1");
> +	if (passed)
> +		tst_res(TPASS, "Container resumed after receiving SIGUSR1 from container namespace");
>  	else
> -		tst_resm(TFAIL, "c-init failed to continue after "
> -			 "passing kill -USR1");
> -	tst_exit();
> +		tst_res(TFAIL, "Container did not receive the SIGUSR1 signal from container");
> +
> +	return 0;
> +}
> +
> +static void run(void)
> +{
> +	int ret;
> +
> +	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "clone failed");
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	SAFE_KILL(ret, SIGUSR1);
> +
> +	TST_CHECKPOINT_WAKE(0);
>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
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
