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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0843C433EF
	for <ltp@archiver.kernel.org>; Sun, 19 Sep 2021 15:48:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D56D0610EA
	for <ltp@archiver.kernel.org>; Sun, 19 Sep 2021 15:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D56D0610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54B5F3C29E2
	for <ltp@archiver.kernel.org>; Sun, 19 Sep 2021 17:48:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEC4B3C2170
 for <ltp@lists.linux.it>; Sun, 19 Sep 2021 17:48:34 +0200 (CEST)
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id C09C4600676
 for <ltp@lists.linux.it>; Sun, 19 Sep 2021 17:48:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=z9NFa
 xbex7wsQ+lEtqoYIQb50CcE/yNUX9U7Mn5PGM0=; b=YPeNazrc9WRm38l/u+iBy
 alcZSinbRuG8uTpAo/FZRaQ4/Ls+ZV00sO+jNbzeD2pJiSxxN1XS8eGs4xHV5OZ/
 0yxGJaEc8dD6FPcyeRmz9hzZcBlU0bhF+OQlVJCBGTex/qO28fEFIDKw1fIWMikr
 1A6O1eFWIOyUQ7qr4SNNtQ=
Received: from [192.168.0.11] (unknown [183.210.46.254])
 by smtp11 (Coremail) with SMTP id D8CowABnS7S5W0dhvAI1Bg--.37S2;
 Sun, 19 Sep 2021 23:48:19 +0800 (CST)
To: QI Fuli <fukuri.sai@gmail.com>, ltp@lists.linux.it
References: <20210918121114.10694-1-qi.fuli@fujitsu.com>
 <20210918121114.10694-5-qi.fuli@fujitsu.com>
From: Xiao Yang <ice_yangxiao@163.com>
Message-ID: <d5e3c2f5-1a32-af4c-cd63-518b997193d4@163.com>
Date: Sun, 19 Sep 2021 23:48:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210918121114.10694-5-qi.fuli@fujitsu.com>
Content-Language: en-US
X-CM-TRANSID: D8CowABnS7S5W0dhvAI1Bg--.37S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jry3Kr45uF4xJF18ZryDGFg_yoW7Kw4DpF
 9xuryxXF4kJFy8GF1xXwsrtF15Zws8JrWUZrW8ZasYyr4UZryxJr4vqw18XFyUGrW8Zw10
 qF4UWr98J3WDtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jm6wtUUUUU=
X-Originating-IP: [183.210.46.254]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/xtbBEgMTXl6idWFZaQAAsE
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/5] syscalls/dup2/dup205: Convert to new API
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
Message-ID: <20210919154808.gsAJAogjpRM1VjYBLC3yt37jAbDo3kbrV__hZbqeUSw@z>

On 9/18/21 8:11 PM, QI Fuli wrote:
> From: QI Fuli <qi.fuli@fujitsu.com>
>
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup2/dup205.c | 171 ++++++++----------------
>   1 file changed, 55 insertions(+), 116 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup205.c
> index 0b324531f..e6fc175c3 100644
> --- a/testcases/kernel/syscalls/dup2/dup205.c
> +++ b/testcases/kernel/syscalls/dup2/dup205.c
> @@ -1,134 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2002
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
> + * Copyright (c) International Business Machines  Corp., 2002
> + * Ported from SPIE, section2/iosuite/dup6.c, by Airong Zhang
>    */
>   
> -/* Ported from SPIE, section2/iosuite/dup6.c, by Airong Zhang */
> -
> -/*======================================================================
> -	=================== TESTPLAN SEGMENT ===================
> ->KEYS:  < dup2()
> ->WHAT:  < Does dup return -1 on the 21st file?
> ->HOW:   < Create up to _NFILE files and check for -1 return on the
> -	< next attempt
> -	< Should check NOFILE as well as _NFILE.  19-Jun-84 Dale.
> ->BUGS:  <
> -======================================================================*/
> +/*\
> + * [Description]
> + * Negative test for dup2() with max open file descriptors.
> + */
>   
> -#include <sys/param.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <errno.h>
> -#include <fcntl.h>
> +#include <stdlib.h>
>   #include <stdio.h>
>   #include <unistd.h>
> -#include "test.h"
> -
> -char *TCID = "dup205";
> -int TST_TOTAL = 1;
> -int *fildes;
> -int min;
> -int local_flag;
> -
> -#define PASSED 1
> -#define FAILED 0
> -
> -static void setup(void);
> -static void cleanup(void);
> -
> -int main(int ac, char *av[])
> -{
> -	int ifile;
> -	char pfilname[40];
> -	int serrno;
> -
> -	int lc;
> -
> -	ifile = -1;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	local_flag = PASSED;
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>   
> -		sprintf(pfilname, "./dup205.%d\n", getpid());
> -		unlink(pfilname);
> -		serrno = 0;
> -		if ((fildes[0] = creat(pfilname, 0666)) == -1)
> -			tst_brkm(TBROK | TERRNO, cleanup, "creat failed");
> -		else {
> -			fildes[fildes[0]] = fildes[0];
> -			for (ifile = fildes[0] + 1; ifile < min + 10; ifile++) {
> -				if ((fildes[ifile] = dup2(fildes[ifile - 1],
> -							  ifile)) == -1) {
> -					serrno = errno;
> -					break;
> -				} else {
> -					if (fildes[ifile] != ifile) {
> -						tst_brkm(TFAIL, cleanup,
> -							 "got wrong descriptor "
> -							 "number back (%d != %d)",
> -							 fildes[ifile], ifile);
> -					}
> -				}
> -			}	/* end for */
> -			if (ifile < min) {
> -				tst_resm(TFAIL, "Not enough files duped");
> -				local_flag = FAILED;
> -			} else if (ifile > min) {
> -				tst_resm(TFAIL, "Too many files duped");
> -				local_flag = FAILED;
> -			}
> -			if (serrno != EBADF && serrno != EMFILE &&
> -			    serrno != EINVAL) {
> -				tst_resm(TFAIL, "bad errno on dup2 failure");
> -				local_flag = FAILED;
> -			}
> -		}
> -		unlink(pfilname);
> -		for (ifile = fildes[0]; ifile < min + 10; ifile++)
> -			close(fildes[ifile]);
> -		if (local_flag == PASSED) {
> -			tst_resm(TPASS, "Test passed.");
> -		} else {
> -			tst_resm(TFAIL, "Test failed.");
> -		}
> -
> -	}
> -	cleanup();
> -	tst_exit();
> -}
> +static int *fildes;
> +static int min;
> +static char pfilname[40];
>   
>   static void setup(void)
>   {
> -	tst_tmpdir();
> -
>   	min = getdtablesize();	/* get number of files allowed open */
> -	fildes = malloc((min + 10) * sizeof(int));
> -	if (fildes == NULL)
> -		tst_brkm(TBROK | TERRNO, cleanup, "malloc error");
> +	fildes = SAFE_MALLOC((min + 10) * sizeof(int));
Please initialize fildes to 0.
> +	sprintf(pfilname, "./dup205.%d\n", getpid());
>   }
>   
>   static void cleanup(void)
>   {
>   	if (fildes != NULL)
>   		free(fildes);
> -	tst_rmdir();
>   }
> +
> +static void run(void)
> +{
> +	int ifile = -1;
> +
> +	fildes[0] = SAFE_CREAT(pfilname, 0666);
> +	fildes[fildes[0]] = fildes[0];
> +	for (ifile = fildes[0] + 1; ifile < min + 10; ifile++) {
> +		TEST(dup2(fildes[ifile - 1], ifile));
> +		if ((fildes[ifile] = TST_RET) == -1)
> +			break;
> +		if (fildes[ifile] != ifile)
> +			tst_brk(TFAIL, "got wrong descriptor number back "
> +				"(%d != %d)", fildes[ifile], ifile);
> +	}
> +
> +	if (TST_ERR != EBADF && TST_ERR != EMFILE && TST_ERR != EINVAL) {
> +		tst_res(TFAIL, "bad errno on dup2 failure");
> +		goto close;
> +	}
> +
> +	if (ifile < min)
> +		tst_res(TFAIL, "Not enough files duped");
> +	else if (ifile > min)
> +		tst_res(TFAIL, "Too many files duped");
> +	else
> +		tst_res(TPASS, "Test passed.");

I perfer to keep the previous logic:

1) compare ifile and min firstly.

2) check errno secondly.

BTW: remove the full stop for "Test passed."

> +
> +close:
> +	SAFE_UNLINK(pfilname);
> +	for (ifile = fildes[0]; ifile < min + 10; ifile++)
> +		close(fildes[ifile]);

There is an very old issue that the fd of stdout is closed here.

With this issue, dup205 -i 5 shows only one message:

------------------------------

tst_test.c:1353: TINFO: Timeout per run is 0h 05m 00s
dup205.c:60: TPASS: Test passed.

------------------------------

Please close the fds which are not equal to 0.

> +}
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
