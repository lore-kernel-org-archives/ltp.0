Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33CACDB474
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 08:13:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 760253CD0FF
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 10:13:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF40D3C8680
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 10:13:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 001A21000A6E
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 10:13:10 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 570EE1FF06;
 Tue, 17 Oct 2023 08:13:09 +0000 (UTC)
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id ED45A2CCEB;
 Tue, 17 Oct 2023 08:13:08 +0000 (UTC)
References: <20230908135201.26771-1-andrea.cervesato@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 17 Oct 2023 09:02:18 +0100
Organization: Linux Private Site
In-reply-to: <20230908135201.26771-1-andrea.cervesato@suse.de>
Message-ID: <874jipy8dp.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-0.21 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(0.20)[suse.de];
 R_SPF_SOFTFAIL(0.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; VIOLATED_DIRECT_SPF(3.50)[];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(0.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FORGED_RECIPIENTS(2.00)[m:andrea.cervesato@suse.de,
 s:andrea.cervesato@suse.com]
X-Rspamd-Queue-Id: 570EE1FF06
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor fork14 using new LTP API
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
>  testcases/kernel/syscalls/fork/fork14.c | 203 +++++++++++-------------
>  1 file changed, 89 insertions(+), 114 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fork/fork14.c b/testcases/kernel/syscalls/fork/fork14.c
> index 93af2ebac..1d5b1dc7b 100644
> --- a/testcases/kernel/syscalls/fork/fork14.c
> +++ b/testcases/kernel/syscalls/fork/fork14.c
> @@ -1,143 +1,118 @@
> -/*********************************************************************
> - * Copyright (C) 2014  Red Hat, Inc.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it
> - * is free of the rightful claim of any third person regarding
> - * infringement or the like.  Any license provided herein, whether
> - * implied or otherwise, applies only to this software file.  Patent
> - * licenses, if any, provided herein do not apply to combinations of
> - * this program with other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA.
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato
> <andrea.cervesato@suse.com>

Missing original copyright

> + */
> +
> +/*\
> + * [Description]
>   *
> - * This test is a reporducer for this patch:
> - *              https://lkml.org/lkml/2012/4/24/328
> + * This test is a reporducer for this patch:
> https://lkml.org/lkml/2012/4/24/328

It would be nice to have the git tag, but this is way in the past. So
it's not important.

>   * Since vma length in dup_mmap is calculated and stored in a unsigned
>   * int, it will overflow when length of mmaped memory > 16 TB. When
> - * overflow occur, fork will  incorrectly succeed. The patch above
> - * fixed it.
> - ********************************************************************/
> -
> -#include <sys/mman.h>
> -#include <sys/wait.h>
> -#include <stdio.h>
> -#include <unistd.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/abisize.h"
> + * overflow occur, fork will incorrectly succeed. The patch above fixed it.
> + */
>  
> -char *TCID = "fork14";
> -int TST_TOTAL = 1;
> +#ifndef TST_ABI32
>  
> -#define GB		(1024 * 1024 * 1024L)
> +#include <stdlib.h>
> +#include <sys/wait.h>
> +#include "tst_test.h"
>  
> -/* set mmap threshold to 16TB */
>  #define LARGE		(16 * 1024)
>  #define EXTENT		(16 * 1024 + 10)
>  
> -static char **pointer_vec;
> -
> -static void setup(void);
> -static void cleanup(void);
> -static int  fork_test(void);
> +static char **memvec;
>  
> -int main(int ac, char **av)
> +static void run(void)
>  {
> -	int lc, reproduced;
> +	int i, j, ret;
> +	pid_t pid;
> +	void *mem;
> +	int failures = 0;
> +	int prev_failed = 0;
> +	int passed = 1;
>  
> -	tst_parse_opts(ac, av, NULL, NULL);
> -/*
> - * Tested on ppc64/x86_64/i386/s390x. And only 64bit has this issue.
> - * Since a 32bit program can't mmap so many memory.
> - */
> -#ifdef TST_ABI32
> -	tst_brkm(TCONF, NULL, "This test is only for 64bit.");
> -#endif
> -	setup();
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> +	for (i = 0; i < EXTENT; i++) {
> +		mem = mmap(NULL, 1 * TST_GB,
> +			PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS,
> +			0, 0);
>  
> -		reproduced = fork_test();
> -		if (reproduced == 0)
> -			tst_resm(TPASS, "fork failed as expected.");
> -	}
> -	cleanup();
> -	tst_exit();
> -}
> +		if (mem == MAP_FAILED) {
> +			tst_res(TINFO, "mmap() failed");
>  
> -static void setup(void)
> -{
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> +			++failures;
>  
> -	pointer_vec = SAFE_MALLOC(cleanup, EXTENT * sizeof(char *));
> -}
> +			if (failures > 10) {
> +				tst_brk(TBROK, "mmap() fails too many "
> +					"times, so it's almost impossible to "
> +					"get a vm_area_struct sized
> 16TB.");

If the failures are due to ENOMEM then the test is not broken. We just
can't overcommit enough memory or are limited by the number of mappings.

I'd suggest failing with TCONF in this case.

> +			}
> +		}
>  
> -static void cleanup(void)
> -{
> -	free(pointer_vec);
> -}
> +		memvec[i] = mem;
>  
> -static int fork_test(void)
> -{
> -	int i, j, prev_failed = 0, fails = 0, cnt = 0;
> -	int reproduced = 0;
> -	void *addr;
> +		pid = fork();
>  
> -	for (i = 0; i < EXTENT; i++) {
> -		addr = mmap(NULL, 1 * GB, PROT_READ | PROT_WRITE,
> -			    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> -		if (addr == MAP_FAILED) {
> -			pointer_vec[i] = NULL;
> -			fails++;
> -			/*
> -			 * EXTENT is "16*1024+10", if fails count exceeds 10,
> -			 * we are almost impossible to get an vm_area_struct
> -			 * sized 16TB
> +		if (pid == -1) {
> +			/* keep track of the failed fork() and verify that next one
> +			 * is failing as well.
>  			 */
> -			if (fails == 11) {
> -				tst_brkm(TCONF, cleanup, "mmap() fails too many"
> -					 "times, so we are almost impossible to"
> -					 " get an vm_area_struct sized 16TB.");
> -			}
> -		} else {
> -			pointer_vec[i] = addr;
> +			prev_failed = 1;
> +			continue;
>  		}
> -		cnt++;
>  
> -		switch (tst_fork()) {
> -		case -1:
> -			prev_failed = 1;
> -		break;
> -		case 0:
> +		if (!pid)
>  			exit(0);
> -		default:
> -			SAFE_WAITPID(cleanup, -1, NULL, 0);
>  
> -			if (prev_failed > 0 && i >= LARGE) {
> -				tst_resm(TFAIL, "Fork succeeds incorrectly");
> -				reproduced = 1;
> -				goto clear_memory_map;
> -			}
> +		ret = waitpid(pid, NULL, 0);
> +		if (ret == -1 && errno != ECHILD)
> +			tst_brk(TBROK | TERRNO, "waitpid() error");
> +
> +		if (prev_failed && i >= LARGE) {
> +			passed = 0;
> +			break;
>  		}
> +
> +		prev_failed = 0;
> +
> +		tst_res(TINFO, "fork() passed at %d attempt", i);
> +	}
> +
> +	for (j = 0; j < i; j++) {
> +		if (memvec[j])
> +			SAFE_MUNMAP(memvec[j], 1 * TST_GB);
>  	}
>  
> -clear_memory_map:
> -	for (j = 0; j < cnt; j++) {
> -		if (pointer_vec[j])
> -			SAFE_MUNMAP(cleanup, pointer_vec[j], 1 * GB);
> +	if (passed)
> +		tst_res(TPASS, "fork() failed as expected");
> +	else
> +		tst_res(TFAIL, "fork() succeeded incorrectly");
> +}
> +
> +static void setup(void)
> +{
> +	memvec = SAFE_MALLOC(EXTENT * sizeof(char *));
> +	memset(memvec, 0, EXTENT);
> +}
> +
> +static void cleanup(void)
> +{
> +	for (long i = 0; i < EXTENT; i++) {
> +		if (memvec[i])
> +			SAFE_MUNMAP(memvec[i], 1 * TST_GB);
>  	}
>  
> -	return reproduced;
> +	free(memvec);
>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +};
> +
> +#else /* TST_ABI32 */
> +	TST_TEST_TCONF("Test doesn't supports 32bits architecture");
> +#endif
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
