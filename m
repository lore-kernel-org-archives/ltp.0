Return-Path: <SRS0=cJ4o=OK=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73198C433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 02:39:50 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBFD460240
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 02:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EBFD460240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F0523C3174
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 04:39:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F4853C21F8
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 04:39:35 +0200 (CEST)
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id A9E6460071B
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 04:39:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:From; bh=u9GQW
 sFxirptRmEmlW9psXjLNgAfVKTUyAIa9/21iCQ=; b=PT9WI9WwfEJbUnBNQEIQX
 TudVFtPZ4Mqzhyzh3fiDGJs1tvU54eH3ZXQGgqLHzIGwHrzwfC7nBf9zhXJ4fI+p
 TBBNzJVbEcvvx/jI58ERhIVDEnsRpcZ/wvGoJoRpVXb4QizmdP7Lz/g181BIhglL
 rGI7CdzUIH0oKm+wYSh5us=
Received: from [192.168.0.104] (unknown [223.64.164.18])
 by smtp8 (Coremail) with SMTP id DMCowAAX5SVg9EdhxWxCBA--.4607S2;
 Mon, 20 Sep 2021 10:39:28 +0800 (CST)
Message-ID: <cf12eb42-aa72-6210-2908-4b17264c2853@163.com>
Date: Mon, 20 Sep 2021 11:07:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
To: QI Fuli <fukuri.sai@gmail.com>, ltp@lists.linux.it
References: <20210917101907.2657-1-qi.fuli@fujitsu.com>
 <20210917101907.2657-3-qi.fuli@fujitsu.com>
From: xuyang <xuyang_jy_0410@163.com>
In-Reply-To: <20210917101907.2657-3-qi.fuli@fujitsu.com>
X-CM-TRANSID: DMCowAAX5SVg9EdhxWxCBA--.4607S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWrWw4xJF4UXrWkAr4ruFg_yoWrZw4Dpa
 9F9F4jka1kJ3W8WFWvgwsFkFWUCwn5CFy7K34j93ZYvF17XryUtw40qa4UAF1DGrWIqayF
 9a109Fn8Jw1rXF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4LvtUUUUU=
X-Originating-IP: [223.64.164.18]
X-CM-SenderInfo: p0x1t05jbm5saquriqqrwthudrp/1tbiXB8UhFXl1NEL3wAAsy
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/dup3_02: Convert to new API
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

Hi Qi
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> ---
>   testcases/kernel/syscalls/dup3/dup3_02.c | 118 ++++++-----------------
>   1 file changed, 29 insertions(+), 89 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/dup3/dup3_02.c b/testcases/kernel/syscalls/dup3/dup3_02.c
> index e49ec3575..08a741240 100644
> --- a/testcases/kernel/syscalls/dup3/dup3_02.c
> +++ b/testcases/kernel/syscalls/dup3/dup3_02.c
> @@ -1,118 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2013 Fujitsu Ltd.
>    * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>    */
> -
> -/*
> - * Description:
> - * Verify that,
> - *  1. dup3() fails with -1 return value and sets errno to EINVAL
> - *     if flags contain an invalid value or oldfd was equal to newfd.
> +/*\
> + * [Description]
> + * Test for various EINVAL error.
> + * - EINVAL - oldfd is equal to newfd W/O using O_CLOEXEC flag
> + * - EINVAL - oldfd is equal to newfd W/ using O_CLOEXEC flag
What is W/O or W/ ?
> + * - EINVAL - flags contain an invalid value
>    */
>   
>   #define _GNU_SOURCE
>   
> -#include <stdio.h>
>   #include <errno.h>
> -#include <unistd.h>
> -#include <fcntl.h>
> -#include <string.h>
> -#include <signal.h>
> -#include <sys/types.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/fcntl.h"
> -#include "lapi/syscalls.h"
> -
> -
> -static void setup(void);
> -static void cleanup(void);
> -
> -#define INVALID_FLAG	-1
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>   
>   static int old_fd;
> -static int new_fd;
> +static int new_fd = -1;
>   
> -static struct test_case_t {
> +static struct tcase {
>   	int *oldfd;
>   	int *newfd;
>   	int flags;
> -	int exp_errno;
> -} test_cases[] = {
> -	{&old_fd, &old_fd, O_CLOEXEC, EINVAL},
> -	{&old_fd, &old_fd, 0, EINVAL},
> -	{&old_fd, &new_fd, INVALID_FLAG, EINVAL}
> +} tcases[] = {
> +	{&old_fd, &old_fd, O_CLOEXEC},
> +	{&old_fd, &old_fd, 0},
> +	{&old_fd, &new_fd, -1}
Look the kernel code[1], it checks flag firstly, then check oldfd 
whether equal to newfd. Finally, check newfd upper limit.

For future compatibility, we don't know whether check logic will change. 
So use a valid newfd is better.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/file.c#n1159
>   };
>   
> -char *TCID = "dup3_02";
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -
> -int main(int ac, char **av)
> +static void run(unsigned int i)
>   {
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> +	struct tcase *tc = tcases + i;
>   
> -		for (i = 0; i < TST_TOTAL; i++) {
> -			TEST(ltp_syscall(__NR_dup3, *(test_cases[i].oldfd),
> -			     *(test_cases[i].newfd), test_cases[i].flags));
> -
> -			if (TEST_RETURN != -1) {
> -				tst_resm(TFAIL, "dup3 succeeded unexpectedly");
> -				continue;
> -			}
> -
> -			if (TEST_ERRNO == test_cases[i].exp_errno) {
> -				tst_resm(TPASS | TTERRNO,
> -					 "dup3 failed as expected");
> -			} else {
> -				tst_resm(TFAIL | TTERRNO,
> -					 "dup3 failed unexpectedly; expected:"
> -					 "%d - %s", test_cases[i].exp_errno,
> -					 strerror(test_cases[i].exp_errno));
> -			}
> -		}
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	TST_EXP_FAIL2(dup3(*tc->oldfd, *tc->newfd, tc->flags), EINVAL,
> +		"dup3(%d, %d, %d)", *tc->oldfd, *tc->newfd, tc->flags);
>   }
>   
>   static void setup(void)
>   {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	tst_tmpdir();
> -
> -	TEST_PAUSE;
> -
> -	old_fd = SAFE_CREAT(cleanup, "testeinval.file", 0644);
> -	new_fd = -1;
> +	old_fd = SAFE_CREAT("testeinval.file", 0644);
>   }
>   
>   static void cleanup(void)
>   {
>   	if (old_fd > 0)
> -		SAFE_CLOSE(NULL, old_fd);
> -
> -	tst_rmdir();
> +		SAFE_CLOSE(old_fd)
>   }
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +};
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
