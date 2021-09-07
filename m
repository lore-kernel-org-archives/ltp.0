Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DCBC433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 01:46:34 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A405B60E77
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 01:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A405B60E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A44783C951C
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 03:46:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D7533C2639
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 03:46:21 +0200 (CEST)
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id 4ED81600C60
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 03:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=576uQ
 nYZ11vtvsjRLsoWfSqiwBN1Y28yLPRxmbiYwPs=; b=g/lxRkJ7fF0EVRU0nxyBs
 Z+Zn9hb9580rK3Y4Cu7ALTaD2QLB6+Ml0aqgaSqFmtwNcsp1MR1JZGBN0hhHXw4S
 qDH2ESv6l7a3OkGEK8B9P7gS/90d0QpYQ5abv7PPKwuXKCpeLmmRbLOR3T4iiHWP
 sbbDRVfjRY4BssDQIxVMKg=
Received: from [172.20.10.4] (unknown [122.96.46.110])
 by smtp1 (Coremail) with SMTP id GdxpCgB3mXJaxDZhIei7AQ--.43S2;
 Tue, 07 Sep 2021 09:46:07 +0800 (CST)
To: QI Fuli <fukuri.sai@gmail.com>, ltp@lists.linux.it
References: <20210902115849.72382-1-qi.fuli@fujitsu.com>
 <20210902115849.72382-3-qi.fuli@fujitsu.com>
From: Xiao Yang <ice_yangxiao@163.com>
Message-ID: <2b48d7f0-86ce-9deb-2b3c-cee3799682eb@163.com>
Date: Tue, 7 Sep 2021 09:46:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210902115849.72382-3-qi.fuli@fujitsu.com>
Content-Language: en-US
X-CM-TRANSID: GdxpCgB3mXJaxDZhIei7AQ--.43S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jry3Kr45uF4xJw1rAF4rAFb_yoWxXF1xpF
 9xGw17KFWDJFy09Fs7Xw43XF1FvanxXr1jgw1jv3ZY9r4fAryrtFsagryxJFykCrZ3Xa4F
 gF45Xr93Gw4DtFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jx3kZUUUUU=
X-Originating-IP: [122.96.46.110]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiEB8HXl8YHOJRXgAAsg
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] syscalls/dup2/dup202: Convert dup202 to the
 new API
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
Message-ID: <20210907014602.48IsBHRfrgkrnjAiy0xYCk1_U5H9KGn90uLg_-RmO14@z>

On 9/2/21 7:58 PM, QI Fuli wrote:
> From: QI Fuli <qi.fuli@fujitsu.com>
>
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup2/dup202.c | 175 +++++++-----------------
>   1 file changed, 48 insertions(+), 127 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup2/dup202.c b/testcases/kernel/syscalls/dup2/dup202.c
> index c87769fa9..16f8b2add 100644
> --- a/testcases/kernel/syscalls/dup2/dup202.c
> +++ b/testcases/kernel/syscalls/dup2/dup202.c
> @@ -1,65 +1,22 @@
> -/*
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
> - */
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   
>   /*
> - * NAME
> - *	dup202.c
> + * Copyright (c) International Business Machines  Corp., 2001
>    *
> - * DESCRIPTION
> + * DESCRIPTION:

Hi Qi,

Please use the new format of description so that it can be caught by doc 
parse:

---------------------------------------------

/*\

  [Description]

---------------------------------------------

>    *	Is the access mode the same for both file descriptors?
>    *		0: read only ?	"0444"
>    *		1: write only ? "0222"
>    *		2: read/write ? "0666"
>    *
> - * ALGORITHM
> - *	Creat a file with each access mode; dup each file descriptor;
> - *	stat each file descriptor and compare modes of each pair
> - *
> - * USAGE:  <for command-line>
> - *  dup202 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -f   : Turn off functionality Testing.
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> - *
> - * HISTORY
> + * HISTORY:
>    *	07/2001 Ported by Wayne Boyer
Remove it.
> - *
> - * RESTRICTIONS
> - *	None
>    */
>   
> -#include <sys/types.h>
> -#include <sys/stat.h>
>   #include <errno.h>
> -#include <fcntl.h>
>   #include <stdio.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -char *TCID = "dup202";
> -int TST_TOTAL = 3;
> -
> -void setup(void);
> -void cleanup(void);
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>   
>   char testfile[40];
>   int fail;
> @@ -68,100 +25,64 @@ int newfd;
>   /* set these to a known index into our local file descriptor table */
>   int duprdo = 10, dupwro = 20, duprdwr = 30;
>   
> -struct test_case_t {
> +static struct tcase {
>   	int *nfd;
>   	mode_t mode;
> -} TC[] = {
> +} tcases[]= {
>   	/* The first test creat(es) a file with mode 0444 */
> -	{
> -	&duprdo, (S_IRUSR | S_IRGRP | S_IROTH)},
> +	{&duprdo, (S_IRUSR | S_IRGRP | S_IROTH)},
>   	    /* The second test creat(es) a file with mode 0222 */
> -	{
> -	&dupwro, (S_IWUSR | S_IWGRP | S_IWOTH)},
> +	{&dupwro, (S_IWUSR | S_IWGRP | S_IWOTH)},
>   	    /* The third test creat(es) a file with mode 0666 */
> -	{
> -	&duprdwr,
> -		    (S_IRUSR | S_IRGRP | S_IROTH | S_IWUSR | S_IWGRP | S_IWOTH)}
> +	{&duprdwr, (S_IRUSR | S_IRGRP | S_IROTH | S_IWUSR | S_IWGRP | S_IWOTH)},
>   };
>   
> -int main(int ac, char **av)
> +void setup(void)
>   {
> -	int lc;
> -	int i, ofd;
> -	struct stat oldbuf, newbuf;
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
> -		for (i = 0; i < TST_TOTAL; i++) {
> -
> -			if ((ofd = creat(testfile, TC[i].mode)) == -1)
> -				tst_brkm(TBROK | TERRNO, cleanup,
> -					 "creat failed");
> -
> -			TEST(dup2(ofd, *TC[i].nfd));
> -
> -			if (TEST_RETURN == -1) {
> -				tst_resm(TFAIL | TTERRNO,
> -					 "call failed unexpectedly");
> -				continue;
> -			}
> +	(void)umask(0);
> +	sprintf(testfile, "dup202.%d", getpid());
> +}
>   
> -			/* stat the original file */
> -			SAFE_FSTAT(cleanup, ofd, &oldbuf);
> +static void run(unsigned int i)
> +{
> +	int ofd;
> +	struct stat oldbuf, newbuf;
> +	struct tcase *tc = tcases + i;
>   
> -			/* stat the duped file */
> -			SAFE_FSTAT(cleanup, *TC[i].nfd, &newbuf);
> +	ofd = creat(testfile, tc->mode);
> +	if (ofd == -1)
> +		tst_brk(TBROK | TERRNO, "creat failed");
Call SAFE_OPEN() directly.
>   
> -			if (oldbuf.st_mode != newbuf.st_mode)
> -				tst_resm(TFAIL, "original and dup "
> -					 "modes do not match");
> -			else
> -				tst_resm(TPASS, "fstat shows new and "
> -					 "old modes are the same");
> +	TEST(dup2(ofd, *tc->nfd));
>   
> -			/* remove the file so that we can use it again */
> -			if (close(*TC[i].nfd) == -1)
> -				perror("close failed");
> -			if (close(ofd) == -1)
> -				perror("close failed");
> -			if (unlink(testfile) == -1)
> -				perror("unlink failed");
> -		}
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "call failed unexpectedly");
> +		return;
>   	}
>   
> -	cleanup();
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
> +	/* stat the original file */
> +	SAFE_FSTAT(ofd, &oldbuf);
>   
> -	TEST_PAUSE;
> +	/* stat the duped file */
> +	SAFE_FSTAT(*tc->nfd, &newbuf);
>   
> -	tst_tmpdir();
> +	if (oldbuf.st_mode != newbuf.st_mode)
> +		tst_res(TFAIL, "original and dup modes do not match");
> +	else
> +		tst_res(TPASS, "fstat shows new and old modes are the same");
>   
> -	(void)umask(0);
> -
> -	sprintf(testfile, "dup202.%d", getpid());
> +	/* remove the file so that we can use it again */
> +	if (close(*tc->nfd) == -1)
> +		perror("close failed");
It is safe to call SAFE_CLOSE().
> +	if (close(ofd) == -1)
> +		perror("close failed");
It is safe to call SAFE_CLOSE().
> +	if (unlink(testfile) == -1)
> +		perror("unlink failed");
unlink() is unnecessary if you call SAFE_OPEN() before.
>   }
>   
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *	       completion or premature exit.
> - */
> -void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +	.setup = setup,
> +};


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
