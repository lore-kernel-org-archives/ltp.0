Return-Path: <SRS0=//k7=OH=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE74C433F5
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 07:05:04 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE6760ED7
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 07:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1BE6760ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C65E3C882D
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 09:05:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA0883C1D1D
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 09:04:51 +0200 (CEST)
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 185D410009AC
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 09:04:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=/HqlP
 qGsfRN9Gm6G0sIoXhs/OYJWoSstojo/vFkrtU8=; b=Dyk9IZFYStUuIaynMQrXR
 JtP3wum9EhflF/E/LP/bdkbynOur4ZyHrVIKTM8Yp4khlxRIzhJbVQW6P+jmpPR4
 PYShHPuI1HfsCmzxrcROSeR1qSceVGL298elUd7Mst9Xh9bDsoQjckGEKKswwInq
 xrOKAfx4jE5YEmQ8le5e1I=
Received: from [172.20.10.4] (unknown [122.192.13.177])
 by smtp1 (Coremail) with SMTP id GdxpCgCn8fgIPkRh6ARqCA--.603S2;
 Fri, 17 Sep 2021 15:04:43 +0800 (CST)
To: QI Fuli <fukuri.sai@gmail.com>, ltp@lists.linux.it
References: <20210916104933.33409-1-qi.fuli@fujitsu.com>
 <20210916104933.33409-2-qi.fuli@fujitsu.com>
From: Xiao Yang <ice_yangxiao@163.com>
Message-ID: <6df28a0d-3a22-9571-9d63-82404b744690@163.com>
Date: Fri, 17 Sep 2021 15:04:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210916104933.33409-2-qi.fuli@fujitsu.com>
Content-Language: en-US
X-CM-TRANSID: GdxpCgCn8fgIPkRh6ARqCA--.603S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jry3Kr45uF4xJw4fCFy7GFg_yoW7ZF4DpF
 9rZrnFkF48GFn2v3W0qw45ZF1ruws5Zr48KryDAwsYqr47JryUta1v934Du3WkGrZxW3yS
 qF4vvr4rXa13taUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jxSdgUUUUU=
X-Originating-IP: [122.192.13.177]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/xtbBIwkRXl3l-cQfGgAAsh
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/5] syscalls/dup2/dup201: Convert to new API
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
Message-ID: <20210917070440.iAQ3VTWTKdQB2t463wSjUCfZKeoRGdP_7xRyU6-4MrE@z>

On 9/16/21 6:49 PM, QI Fuli wrote:
> From: QI Fuli <qi.fuli@fujitsu.com>
>
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup2/dup201.c | 174 +++++-------------------
>   1 file changed, 33 insertions(+), 141 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup2/dup201.c b/testcases/kernel/syscalls/dup2/dup201.c
> index 4fa34466a..ff82b5fe7 100644
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
> + *	07/2001 Ported by Wayne Boyer
> + *	01/2002 Removed EMFILE test - Paul Larson
>    */
>   
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
> + * First fd argument is less than 0
> + * First fd argument is getdtablesize()
> + * Second fd argument is less than 0
> + * Second fd argument is getdtablesize()

Hi Qi,

You should use the following list in markdown so that the description 
can be processed by docparse properly:

* Negative tests for dup2() with bad fd (EBADF):
*
* - First fd argument is less than 0
* - First fd argument is getdtablesize()
* - Second fd argument is less than 0
* - Second fd argument is getdtablesize()

Best Regards,
Xiao Yang

>    *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *	01/2002 Removed EMFILE test - Paul Larson
> - *
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
> -
> -void setup(void);
> -void cleanup(void);
> -
> -char *TCID = "dup201";
> -int TST_TOTAL = 4;
> +#include "tst_test.h"
>   
> -int maxfd;
> -int goodfd = 5;
> -int badfd = -1;
> -int mystdout = 0;
> +static int maxfd, mystdout;
> +static int goodfd = 5;
> +static int badfd = -1;
>   
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
