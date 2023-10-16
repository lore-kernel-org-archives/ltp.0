Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77517CDB465
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 10:34:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29DE23CEF80
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 12:34:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF5123C8ACD
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 12:34:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5EAE4601573
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 12:34:02 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4428C21C34;
 Mon, 16 Oct 2023 10:34:01 +0000 (UTC)
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id DF34D2C234;
 Mon, 16 Oct 2023 10:34:00 +0000 (UTC)
References: <20230908102315.8163-1-andrea.cervesato@suse.de>
 <20230908102315.8163-3-andrea.cervesato@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 16 Oct 2023 11:03:25 +0100
Organization: Linux Private Site
In-reply-to: <20230908102315.8163-3-andrea.cervesato@suse.de>
Message-ID: <878r82yhyh.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: +++++
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.79 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 MIME_GOOD(-0.10)[text/plain]; REPLYTO_ADDR_EQ_FROM(0.00)[];
 DMARC_NA(0.20)[suse.de]; R_SPF_SOFTFAIL(0.60)[~all:c];
 HAS_ORG_HEADER(0.00)[]; TO_MATCH_ENVRCPT_SOME(0.00)[];
 VIOLATED_DIRECT_SPF(3.50)[]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; NEURAL_SPAM_LONG(3.00)[1.000];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(0.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FORGED_RECIPIENTS(2.00)[m:andrea.cervesato@suse.de,
 s:andrea.cervesato@suse.com]
X-Rspamd-Queue-Id: 4428C21C34
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Refactor exit_group01 using new API
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
> We provided a different approach to exit_group() testing, spawning
> multiple threads inside the child and checking if they get killed with
> the parent process.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Added thread_alive() function that checks existance of running threads, instead
> of using kill(tid, 0) method.
> tst_gettid() usage
>
>  testcases/kernel/syscalls/exit_group/Makefile |   2 +
>  .../kernel/syscalls/exit_group/exit_group01.c | 160 ++++++++++++------
>  2 files changed, 111 insertions(+), 51 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/exit_group/Makefile b/testcases/kernel/syscalls/exit_group/Makefile
> index 1273a4e9c..adbac3c51 100644
> --- a/testcases/kernel/syscalls/exit_group/Makefile
> +++ b/testcases/kernel/syscalls/exit_group/Makefile
> @@ -3,6 +3,8 @@
>  
>  top_srcdir		?= ../../../..
>  
> +exit_group01: CFLAGS+=-pthread
> +
>  include $(top_srcdir)/include/mk/testcases.mk
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/exit_group/exit_group01.c b/testcases/kernel/syscalls/exit_group/exit_group01.c
> index 5bf5b0218..2fcfff2f2 100644
> --- a/testcases/kernel/syscalls/exit_group/exit_group01.c
> +++ b/testcases/kernel/syscalls/exit_group/exit_group01.c
> @@ -1,68 +1,126 @@
> -/******************************************************************************
> - * Copyright (c) Crackerjack Project., 2007                                   *
> - * Ported to LTP by Manas Kumar Nayak <maknayak@in.ibm.com>                   *
> - * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>                          *
> - *                                                                            *
> - * This program is free software;  you can redistribute it and/or modify      *
> - * it under the terms of the GNU General Public License as published by       *
> - * the Free Software Foundation; either version 2 of the License, or          *
> - * (at your option) any later version.                                        *
> - *                                                                            *
> - * This program is distributed in the hope that it will be useful,            *
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of            *
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  *
> - * the GNU General Public License for more details.                           *
> - *                                                                            *
> - * You should have received a copy of the GNU General Public License          *
> - * along with this program;  if not, write to the Free Software Foundation,   *
> - * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           *
> - *                                                                            *
> - ******************************************************************************/
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Crackerjack Project., 2007
> + * Ported to LTP by Manas Kumar Nayak <maknayak@in.ibm.com>
> + * Copyright (c) 2015 Linux Test Project
> + * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
>  
> -#include <stdio.h>
> -#include <errno.h>
> -#include <linux/unistd.h>
> -#include <sys/wait.h>
> +/*\
> + * [Description]
> + *
> + * This test checks if exit_group() correctly ends a spawned child and all its
> + * running threads.
> + */
>  
> -#include "test.h"
> -#include "safe_macros.h"
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include "tst_safe_pthread.h"
> +#include "tst_test.h"
>  #include "lapi/syscalls.h"
>  
> -char *TCID = "exit_group01";
> -int testno;
> -int TST_TOTAL = 1;
> +#define THREADS_NUM 10
> +
> +static pid_t *tids;
>  
> -static void verify_exit_group(void)
> +static void thread_alive(const int tid)
>  {
> -	pid_t cpid, w;
> -	int status;
> +	char folder[128];
> +    struct stat sb;
> +	char state;
>  
> -	cpid = fork();
> -	if (cpid == -1)
> -		tst_brkm(TFAIL | TERRNO, NULL, "fork failed");
> +	snprintf(folder, sizeof(folder), "/proc/%i/stat", tid);
>  
> -	if (cpid == 0) {
> -		TEST(tst_syscall(__NR_exit_group, 4));
> -	} else {
> -		w = SAFE_WAIT(NULL, &status);
> -
> -		if (WIFEXITED(status) && (WEXITSTATUS(status) == 4)) {
> -			tst_resm(TPASS, "exit_group() succeeded");
> -		} else {
> -			tst_resm(TFAIL | TERRNO,
> -				 "exit_group() failed (wait status = %d)", w);
> +	for (;;) {
> +		if (stat(folder, &sb) == -1) {
> +			if (errno != ENOENT)
> +				tst_brk(TBROK | TERRNO, "stat() error");
> +
> +			break;
> +		}
> +
> +		SAFE_FILE_SCANF(folder, "%*i %*s %c", &state);
> +
> +		if (state != 'S') {
> +			tst_brk(TBROK,
> +				"Thread %d is supposed to sleep but it's in '%c' state",
> +				tid, state);
>  		}

This could fail due to PID reuse or maybe because state == 'Z'.

Perhaps instead we could check the threads are put into the Z state?

I guess that the child threads are reparented to init and it reaps
them. So you will have to prevent that by setting PR_SET_CHILD_SUBREAPER
on the main test process with prctl.

The man pages are not clear on this though. I guess this is how it works
from reading the kernel code.

> +
> +		usleep(1000);

This probably should be sched_yield. It's hard to know what a sensible
sleep time would be for any given system.

>  	}
>  }
>  
> -int main(int ac, char **av)
> +static void *worker(void *arg)
>  {
> -	int lc;
> +	int i = *((int *)arg);
>  
> -	tst_parse_opts(ac, av, NULL, NULL);
> +	tids[i] = tst_gettid();
>  
> -	for (lc = 0; TEST_LOOPING(lc); lc++)
> -		verify_exit_group();
> +	TST_CHECKPOINT_WAKE(0);
> +	pause();
>  
> -	tst_exit();
> +	return arg;
>  }
> +
> +static void spawn_threads(void)
> +{
> +	pthread_t threads[THREADS_NUM];
> +
> +	for (int i = 0; i < THREADS_NUM; i++) {
> +		SAFE_PTHREAD_CREATE(&threads[i], NULL, worker, (void *)&i);
> +		TST_CHECKPOINT_WAIT(0);
> +
> +		/* wait for paused thread */
> +		TST_PROCESS_STATE_WAIT(tids[i], 'S', 0);
> +	}
> +}
> +
> +static void run(void)
> +{
> +	pid_t pid;
> +	int status;
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		spawn_threads();
> +
> +		TEST(tst_syscall(__NR_exit_group, 4));
> +		if (TST_RET == -1)
> +			tst_brk(TBROK | TERRNO, "exit_group() error");
> +
> +		return;
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);

You could move this after thread_alive and check that the child threads
all eventually transition to Z.

You maybe need to wait on all the child threads as well if this process
is set as a sub-reaper. I don't see anything in the kernel to suggest
waiting on a normal PID will wait for its child threads.

Also exit_group appears to signal all the child threads as we would have
to do in userland if the syscall didn't exist.

> +
> +	for (int i = 0; i < THREADS_NUM; i++)
> +		thread_alive(tids[i]);
> +
> +	TST_EXP_EXPR(WIFEXITED(status) && WEXITSTATUS(status) == 4,
> +		"exit_group() succeeded");
> +}
> +
> +static void setup(void)
> +{
> +	tids = SAFE_MMAP(
> +		NULL,
> +		sizeof(pid_t) * THREADS_NUM,
> +		PROT_READ | PROT_WRITE,
> +		MAP_SHARED | MAP_ANONYMOUS,
> +		-1, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_MUNMAP(tids, sizeof(pid_t) * THREADS_NUM);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +};
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
