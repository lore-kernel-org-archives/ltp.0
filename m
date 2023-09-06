Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33015EB8FAF
	for <ltp@archiver.kernel.org>; Wed,  6 Sep 2023 10:38:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39C033CB76A
	for <ltp@archiver.kernel.org>; Wed,  6 Sep 2023 12:38:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95A8D3C89B6
 for <ltp@lists.linux.it>; Wed,  6 Sep 2023 12:38:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7036A20A6B7
 for <ltp@lists.linux.it>; Wed,  6 Sep 2023 12:38:31 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id BB3D520292;
 Wed,  6 Sep 2023 10:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693996710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=az2nz7wHht997EQwGL/3nHnCUdPvLY/y2roKYwxCDUM=;
 b=grEPPIcfCg7XPpLNR15Aib4FVHarFi8Bxp87ncWcUVaXv5B4gttfDvQrqjW4TswH7KrBet
 gn9RrAMhdWep2SmTv+FGAshgddYTVUr22Q7E1iasRD0he4Dvf2Z324EB8/QxvVMneMDOsA
 7BoVAtes2SLM5VLKBeDLdpd0bScOob0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693996710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=az2nz7wHht997EQwGL/3nHnCUdPvLY/y2roKYwxCDUM=;
 b=7cY4XRQAwuFhxhDPAj0vlBOCk616pod2x2Wir1uvHy1Yemka80tLnd4KjXvF1lWHsQ2rg7
 SI821Et7WBVG9zAw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 906B22C142;
 Wed,  6 Sep 2023 10:38:30 +0000 (UTC)
References: <20230830155548.9402-1-andrea.cervesato@suse.de>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 06 Sep 2023 10:02:35 +0100
Organization: Linux Private Site
In-reply-to: <20230830155548.9402-1-andrea.cervesato@suse.de>
Message-ID: <87v8cnegd7.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor exit_group01 using new API
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
>  .../kernel/syscalls/exit_group/exit_group01.c | 137 +++++++++++-------
>  2 files changed, 85 insertions(+), 54 deletions(-)
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
> index 5bf5b0218..0ed008115 100644
> --- a/testcases/kernel/syscalls/exit_group/exit_group01.c
> +++ b/testcases/kernel/syscalls/exit_group/exit_group01.c
> @@ -1,68 +1,97 @@
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
> -
> -#include <stdio.h>
> -#include <errno.h>
> -#include <linux/unistd.h>
> -#include <sys/wait.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Crackerjack Project., 2007
> + * Ported to LTP by Manas Kumar Nayak <maknayak@in.ibm.com>
> + * Copyright (c) 2015 Linux Test Project
> + * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test checks if exit_group() correctly ends a spawned child and all its
> + * running threads.
> + */
> +
> +#include <stdlib.h>
> +#include "tst_safe_pthread.h"
> +#include "tst_test.h"
>  #include "lapi/syscalls.h"
>  
> -char *TCID = "exit_group01";
> -int testno;
> -int TST_TOTAL = 1;
> +/* gittid is not defined by glibc */
> +#define gettid() syscall(SYS_gettid)
> +
> +#define THREADS_NUM 10
>  
> -static void verify_exit_group(void)
> +static pid_t *tids;
> +
> +static void *worker(void *arg)
>  {
> -	pid_t cpid, w;
> -	int status;
> +	int i = *((int *)arg);
>  
> -	cpid = fork();
> -	if (cpid == -1)
> -		tst_brkm(TFAIL | TERRNO, NULL, "fork failed");
> +	tids[i] = gettid();
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
> -		}
> +	TST_CHECKPOINT_WAKE(0);
> +	pause();
> +
> +	return arg;
> +}
> +
> +static void spawn_threads(void)
> +{
> +	pthread_t threads[THREADS_NUM];
> +
> +	for (int i = 0; i < THREADS_NUM; i++) {
> +		SAFE_PTHREAD_CREATE(&threads[i], NULL, worker, (void *)&i);
> +		TST_CHECKPOINT_WAIT(0);
>  	}
>  }
>  
> -int main(int ac, char **av)
> +static void run(void)
>  {
> -	int lc;
> +	pid_t pid;
> +	int status;
>  
> -	tst_parse_opts(ac, av, NULL, NULL);
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		spawn_threads();
>  
> -	for (lc = 0; TEST_LOOPING(lc); lc++)
> -		verify_exit_group();
> +		TEST(tst_syscall(__NR_exit_group, 4));
> +		if (TST_RET == -1)
> +			tst_brk(TBROK | TERRNO, "exit_group() error");
> +
> +		return;
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +
> +	TST_EXP_EXPR(WIFEXITED(status) && WEXITSTATUS(status) == 4,
> +		"exit_group() succeeded");
> +
> +	for (int i = 0; i < THREADS_NUM; i++)
> +		TST_EXP_FAIL(kill(tids[i], 0), ESRCH);

I'm not sure if there is a race condition here because

1. I can't find a synchronisation mechanism when the kernel sends the
   kill signal to the children. It just sets the signal then schedules
   them.
2. I can't see a clear way that wait{pid,id} would wait for a process
   and its children.

In fact I'm not sure if all the children of the thread group leader need
(or can be) to be waited on (you may need __WALL in options).

Could you try waiting on the idividual tids[] and then the pid?

I haven't seen the test fail, but the main test task (sleeping in
waitpid) probably gets scheduled after the child thread tasks. However
this doesn't seem like behaviour we can rely on.

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
>  
> -	tst_exit();
> +static void cleanup(void)
> +{
> +	SAFE_MUNMAP(tids, sizeof(pid_t) * THREADS_NUM);
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
