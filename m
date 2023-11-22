Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5281EC61D9B
	for <ltp@archiver.kernel.org>; Wed, 22 Nov 2023 10:31:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5C663CE07E
	for <ltp@archiver.kernel.org>; Wed, 22 Nov 2023 11:31:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D31333CC114
 for <ltp@lists.linux.it>; Wed, 22 Nov 2023 11:31:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 838B6608A79
 for <ltp@lists.linux.it>; Wed, 22 Nov 2023 11:31:18 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id CFE4B21907;
 Wed, 22 Nov 2023 10:31:17 +0000 (UTC)
Received: from g78 (rpalethorpe.udp.ovpn1.prg.suse.de [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8EC372C14F;
 Wed, 22 Nov 2023 10:31:17 +0000 (UTC)
References: <20231121172630.964-1-andrea.cervesato@suse.de>
 <20231121172630.964-3-andrea.cervesato@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 22 Nov 2023 09:31:52 +0000
Organization: Linux Private Site
In-reply-to: <20231121172630.964-3-andrea.cervesato@suse.de>
Message-ID: <87y1eq84gb.fsf@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: CFE4B21907
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] Refactor exit_group01 using new API
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
>  testcases/kernel/syscalls/exit_group/Makefile |   2 +
>  .../kernel/syscalls/exit_group/exit_group01.c | 144 +++++++++++-------
>  2 files changed, 95 insertions(+), 51 deletions(-)
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
> index 5bf5b0218..9c557eedf 100644
> --- a/testcases/kernel/syscalls/exit_group/exit_group01.c
> +++ b/testcases/kernel/syscalls/exit_group/exit_group01.c
> @@ -1,68 +1,110 @@
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
> +#include "tst_test.h"
>  #include "lapi/syscalls.h"
> +#include "tst_safe_pthread.h"
>  
> -char *TCID = "exit_group01";
> -int testno;
> -int TST_TOTAL = 1;
> +#define THREADS_NUM 10

It occured to me while looking at the mmap code that this test is far
more likely to find something if we at least set the number of threads
to max(2, tst_ncpus). It also would be better for embedded systems with
one CPU.

Taking that even further, if every thread has its affinity set to run on
a unique core then this will force a lot of cross CPU
communication. However that could go in another test.

>  
> -static void verify_exit_group(void)
> +static pid_t *tids;
> +static int *counter;
> +
> +static void *worker(void *arg)
>  {
> -	pid_t cpid, w;
> +	int i = *((int *)arg);
> +
> +	tids[i] = tst_gettid();
> +
> +	while (1) {
> +		++(*counter);

The atomic function can be used when updating or reading counter.

> +		usleep(0);

nit: sched_yield better shows the intent

> +	}
> +
> +	return arg;
> +}
> +
> +static void spawn_threads(void)
> +{
> +	pthread_t threads[THREADS_NUM];
> +
> +	for (int i = 0; i < THREADS_NUM; i++)
> +		SAFE_PTHREAD_CREATE(&threads[i], NULL, worker, (void *)&i);
> +}
> +
> +static void run(void)
> +{
> +	pid_t pid;
>  	int status;
>  
> -	cpid = fork();
> -	if (cpid == -1)
> -		tst_brkm(TFAIL | TERRNO, NULL, "fork failed");
> +	*counter = 0;
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		spawn_threads();
>  
> -	if (cpid == 0) {
>  		TEST(tst_syscall(__NR_exit_group, 4));
> -	} else {
> -		w = SAFE_WAIT(NULL, &status);
> -
> -		if (WIFEXITED(status) && (WEXITSTATUS(status) == 4)) {
> -			tst_resm(TPASS, "exit_group() succeeded");
> -		} else {
> -			tst_resm(TFAIL | TERRNO,
> -				 "exit_group() failed (wait status = %d)", w);
> -		}
> +		if (TST_RET == -1)
> +			tst_brk(TBROK | TERRNO, "exit_group() error");
> +
> +		return;
>  	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +
> +	TST_EXP_EXPR(WIFEXITED(status) && WEXITSTATUS(status) == 4,
> +		"exit_group() succeeded");
> +
> +	int old_counter = *counter;
> +
> +	tst_res(TINFO, "Checking if threads are still running");
> +	usleep(1000000);
> +
> +	TST_EXP_EXPR(old_counter == *counter, "Counter value hasn't changed");
>  }
>  
> -int main(int ac, char **av)
> +static void setup(void)
>  {
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> +	tids = SAFE_MMAP(
> +		NULL,
> +		sizeof(pid_t) * THREADS_NUM,
> +		PROT_READ | PROT_WRITE,
> +		MAP_SHARED | MAP_ANONYMOUS,
> +		-1, 0);
>  
> -	for (lc = 0; TEST_LOOPING(lc); lc++)
> -		verify_exit_group();
> +	counter = SAFE_MMAP(
> +		NULL,
> +		sizeof(int),
> +		PROT_READ | PROT_WRITE,
> +		MAP_SHARED | MAP_ANONYMOUS,
> +		-1, 0);
> +}

nit; mmap always maps at least a page, so calling it twice is wasteful.

If we are setting up shared memory with more than one variable in then
the cleanest way to do it is to create a struct with the variables in
e.g.

struct shm {
       int counter;
       pid_t pid;
};

struct shm *shm = SAFE_MMAP(0, 2 * sizeof(struct shm) * tst_ncpus(), ...);
struct shm *copy = shm + tst_ncpus()

Also if each thread has its own counter then we won't have all the CPUs
fighting to atomically update the memory which could be an issue on a
machine with >128 cores.

Then you can memcpy the whole shm and memcmp it after the delay.

>  
> -	tst_exit();
> +static void cleanup(void)
> +{
> +	SAFE_MUNMAP(tids, sizeof(pid_t) * THREADS_NUM);
> +	SAFE_MUNMAP(counter, sizeof(int));
>  }
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
