Return-Path: <SRS0=9lgI=OJ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1826CC433F5
	for <ltp@archiver.kernel.org>; Sun, 19 Sep 2021 15:49:26 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F265611C8
	for <ltp@archiver.kernel.org>; Sun, 19 Sep 2021 15:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5F265611C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E29C93C27CF
	for <ltp@archiver.kernel.org>; Sun, 19 Sep 2021 17:49:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F061A3C2170
 for <ltp@lists.linux.it>; Sun, 19 Sep 2021 17:49:12 +0200 (CEST)
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id A1F141000A50
 for <ltp@lists.linux.it>; Sun, 19 Sep 2021 17:49:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=SfU2R
 dlfEOJBCSSJVxH8HcoOZ8O0Rg30SbC/WmB/iMU=; b=N2FM/VeixhsIKRh+NYrKM
 E8Nyp6/MpkSy19yHA7MQtWckDOAJMfrdmFi22Fq58DuLWk8G60m3UP8bJ0HenT09
 Vt3ZsSnUbG/5Vao0xzpIA6H2YNw4A1OPh8/ZdJG8v9uts/FlALuqNkXB441AChXF
 NQxYGC/pW+cFmx4OBav+2M=
Received: from [192.168.0.11] (unknown [183.210.46.254])
 by smtp11 (Coremail) with SMTP id D8CowAA3nCXdW0dhIws1Bg--.0S2;
 Sun, 19 Sep 2021 23:48:54 +0800 (CST)
To: QI Fuli <fukuri.sai@gmail.com>, ltp@lists.linux.it
References: <20210918121114.10694-1-qi.fuli@fujitsu.com>
 <20210918121114.10694-2-qi.fuli@fujitsu.com>
From: Xiao Yang <ice_yangxiao@163.com>
Message-ID: <95f79e4f-049f-4cbd-ddef-d00138a8c2d6@163.com>
Date: Sun, 19 Sep 2021 23:48:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210918121114.10694-2-qi.fuli@fujitsu.com>
Content-Language: en-US
X-CM-TRANSID: D8CowAA3nCXdW0dhIws1Bg--.0S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jry3Kr45uF4xJw4fCFy7GFg_yoW7Ww4DpF
 9rZrnFkF48JF1ku3W0qw45ZF1rCwn5Xr48Kr1UAwsYqF4xJ34Uta1vg3sruF1kGrZxW3yS
 qa1v9r4rXa13tF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jmbyZUUUUU=
X-Originating-IP: [183.210.46.254]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiqAwTXlc7V+5RuQABsV
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/5] syscalls/dup2/dup201: Convert to new API
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
Cc: QI Fuli <qi.fuli@fujitsu.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210919154845.t8ufgFzRTAnLA7IgsEGIAi1Lh1fi-zIJO1eNzZdPEOI@z>

On 9/18/21 8:11 PM, QI Fuli wrote:
> From: QI Fuli <qi.fuli@fujitsu.com>
>
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup2/dup201.c | 174 +++++-------------------
>   1 file changed, 33 insertions(+), 141 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup2/dup201.c b/testcases/kernel/syscalls/dup2/dup201.c
> index 4fa34466a..cc1563115 100644
> --- a/testcases/kernel/syscalls/dup2/dup201.c
> +++ b/testcases/kernel/syscalls/dup2/dup201.c
> @@ -1,163 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - *
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
> + * Copyright (c) International Business Machines  Corp., 2001
> + * 07/2001 Ported by Wayne Boyer
> + * 01/2002 Removed EMFILE test - Paul Larson
>    */
> -
> -/*
> - * NAME
> - *	dup201.c
> - *
> - * DESCRIPTION
> - *	Negative tests for dup2() with bad fd (EBADF)
> - *
> - * ALGORITHM
> - * 	Setup:
> - *	a.	Setup signal handling.
> - *	b.	Pause for SIGUSR1 if option specified.
> - *
> - * 	Test:
> - *	a.	Loop if the proper options are given.
> - *	b.	Loop through the test cases
> - * 	c.	Execute dup2() system call
> - *	d.	Check return code, if system call failed (return=-1), test
> - *		for EBADF.
> - *
> - * 	Cleanup:
> - * 	a.	Print errno log and/or timing stats if options given
> +/*\
> + * [Description]
>    *
> - * USAGE:  <for command-line>
> - *  dup201 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> + * Negative tests for dup2() with bad fd (EBADF)
Please add a full stop.
>    *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *	01/2002 Removed EMFILE test - Paul Larson
> + * - First fd argument is less than 0
> + * - First fd argument is getdtablesize()
> + * - Second fd argument is less than 0
> + * - Second fd argument is getdtablesize()
>    *
> - * RESTRICTIONS
> - * 	NONE
>    */
>   
> -#include <sys/types.h>
> -#include <fcntl.h>
>   #include <errno.h>
> -#include <sys/time.h>
> -#include <sys/resource.h>
>   #include <unistd.h>
> -#include <signal.h>
> -#include "test.h"
> +#include "tst_test.h"
>   
> -void setup(void);
> -void cleanup(void);
> +static int maxfd, mystdout;
> +static int goodfd = 5;
> +static int badfd = -1;
>   
> -char *TCID = "dup201";
> -int TST_TOTAL = 4;
> -
> -int maxfd;
> -int goodfd = 5;
> -int badfd = -1;
> -int mystdout = 0;
> -
> -struct test_case_t {
> +static struct tcase {
>   	int *ofd;
>   	int *nfd;
> -	int error;
> -	void (*setupfunc) ();
> -} TC[] = {
> -	/* First fd argument is less than 0 - EBADF */
> -	{&badfd, &goodfd, EBADF, NULL},
> -	    /* First fd argument is getdtablesize() - EBADF */
> -	{&maxfd, &goodfd, EBADF, NULL},
> -	    /* Second fd argument is less than 0 - EBADF */
> -	{&mystdout, &badfd, EBADF, NULL},
> -	    /* Second fd argument is getdtablesize() - EBADF */
> -	{&mystdout, &maxfd, EBADF, NULL},
> +} tcases[] = {
> +	{&badfd, &goodfd},
> +	{&maxfd, &goodfd},
> +	{&mystdout, &badfd},
> +	{&mystdout, &maxfd},
>   };
>   
> -int main(int ac, char **av)
> +static void setup(void)
>   {
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/* loop through the test cases */
> -
> -		for (i = 0; i < TST_TOTAL; i++) {
> -
> -			/* call the test case setup routine if necessary */
> -			if (TC[i].setupfunc != NULL)
> -				(*TC[i].setupfunc) ();
> -
> -			TEST(dup2(*TC[i].ofd, *TC[i].nfd));
> -
> -			if (TEST_RETURN != -1) {
> -				tst_resm(TFAIL, "call succeeded unexpectedly");
> -				continue;
> -			}
> -
> -			if (TEST_ERRNO == TC[i].error) {
> -				tst_resm(TPASS,
> -					 "failed as expected - errno = %d : %s",
> -					 TEST_ERRNO, strerror(TEST_ERRNO));
> -			} else {
> -				tst_resm(TFAIL | TTERRNO,
> -					 "failed unexpectedly; "
> -					 "expected %d: %s", TC[i].error,
> -					 strerror(TC[i].error));
> -			}
> -		}
> -	}
> -	cleanup();
> -
> -	tst_exit();
> -}
> -
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - */
> -void setup(void)
> -{
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
>   	/* get some test specific values */
>   	maxfd = getdtablesize();
>   }
>   
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *	       completion or premature exit.
> - */
> -void cleanup(void)
> +static void run(unsigned int i)
>   {
> -	tst_rmdir();
> +	struct tcase *tc = tcases + i;
> +
> +	TST_EXP_FAIL2(dup2(*tc->ofd, *tc->nfd), EBADF,
> +			"dup2(%d, %d)", *tc->ofd, *tc->nfd);
>   }
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +	.setup = setup,
> +};


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
