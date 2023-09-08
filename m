Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19565EE57E0
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 09:19:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C97833CE973
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 11:19:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 864C83CB504
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 11:19:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B2ADF1BB9FAC
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 11:19:35 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 13B4A218EA;
 Fri,  8 Sep 2023 09:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694164775;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q9mvHg40YXchnjvZytkw2SsNPG/XBo2XHxOd+MHcarA=;
 b=up8ZD8V+PvSQ4iHiHL8q03Ac8J5neDOmWFv//nyYlaysGPdHmSt4DEwCIqA4bA3bA4yHmK
 pbxIfQNA9pkmW3OfgMBk35rBTqQOs/l1g8CtqwZSjMeRx4mwPHBqLPOsRB1qMMOzmkufI+
 GZ4VU4PvLGFinoinMX7nIeSMk0i8Ra8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694164775;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q9mvHg40YXchnjvZytkw2SsNPG/XBo2XHxOd+MHcarA=;
 b=oZy/8qv89H8JbzYSzqznPxslD+DL7+Tuwn9wswDtcOBy4N7dMEQ+NFEWHIZhMJggKkGjrP
 /pN4ylRgH0TwZ8DA==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 63B4D2C143;
 Fri,  8 Sep 2023 09:19:34 +0000 (UTC)
References: <20230907115431.28960-1-andrea.cervesato@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 08 Sep 2023 10:02:59 +0100
Organization: Linux Private Site
In-reply-to: <20230907115431.28960-1-andrea.cervesato@suse.de>
Message-ID: <874jk5hviz.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor exit_group01 using new API
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
>  .../kernel/syscalls/exit_group/exit_group01.c | 140 +++++++++++-------
>  2 files changed, 88 insertions(+), 54 deletions(-)
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
> index 5bf5b0218..fb65624ac 100644
> --- a/testcases/kernel/syscalls/exit_group/exit_group01.c
> +++ b/testcases/kernel/syscalls/exit_group/exit_group01.c
> @@ -1,68 +1,100 @@
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

It was added in glibc 2.30. I don't know how old that is. It may need an
entry in lapi.

> +
> +#define THREADS_NUM 10
> +
> +static pid_t *tids;
>  
> -static void verify_exit_group(void)
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
> +
> +		/* wait for paused thread */
> +		TST_PROCESS_STATE_WAIT(tids[i], 'S', 0);
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
> +	for (int i = 0; i < THREADS_NUM; i++)
> +		TST_EXP_FAIL(kill(tids[i], 0), ESRCH);

I think there is still a possible race condition here. Especially if the
children are schedule on a different CPU and that CPU is handling
interrupts. AFAICT the kernel sends kill then schedules the
children. I'm not sure what happens exactly, but it doesn't move the
children to the current CPU and schedule them in serial before killing
the parent.

I'm not sure if waiting on the threads will work. Another option is to
repeatedly check if the /proc/<pid> folder exists and what state the
process is in if it does. You can't send kill repeatedly unless you know
the signal you are sending won't kill the child.

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
