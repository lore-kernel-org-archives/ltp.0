Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D69C02192
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 10:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738577204; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=73iAXkLikNHAI+OF5gBDZ2FCxqJO79xIsvMbKdXY29Q=;
 b=nKJdO8ADyWVPtEFwcXelfg4KsIxNtIPK/MOl1CUFakQooZwbyY8dUEhQS3dN+dTxRW3Io
 2Ok0WBrlbtrjm1GQz/IAxaNPcygySQJl/LDh9pvmykL+ceLHczikur2FcrphZAdEsw2spye
 2u1NcYic61Qcnhd7pGw1WP+CSIq2ppM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11CC73C8E92
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 11:06:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D99DB3C6AA0
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 11:06:21 +0100 (CET)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 18D2614104F2
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 11:06:21 +0100 (CET)
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-5d3bbb0f09dso7563899a12.2
 for <ltp@lists.linux.it>; Mon, 03 Feb 2025 02:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738577180; x=1739181980; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0QjxbrfZjOaglZ2A16pyYcvRTTxl199fNLtG0M+mpWk=;
 b=gDX8k04Te24xsBZC5chwH2CAVQ80i1fq2ND24F+1hPFpSa34cR2uuZkSIuVZ8E5LPv
 z5W2Euw64nnJHMi+9oeihXXGMJwIrUp13BKmAKqzzY12jfuJfJ4B1ovhq5KRMxriE6Kj
 jX+BTlMbyKYrmM4bK/QGcfGaYpGnxMFrkd3YdZhJrcr8z0omhzXlHh/ebpyCPrPOBdhG
 iTU9Yfo0UzRGwAXv/Om61lJikb3KqhfXlMyEcJZg2jw/GK7t8AlTyB7N+7hqSqD/w1qN
 DD2WXyyT7x+IMs93gXxYhAvp1upTEHTjDHkIWzV8pqBn48Vck5aKDDyRo6+au0AfZb05
 c4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738577180; x=1739181980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0QjxbrfZjOaglZ2A16pyYcvRTTxl199fNLtG0M+mpWk=;
 b=BAgy6mpkrlCbEOJ6TGuMl+Ad9jxmtrmOXwslZyo33GalUVF8jScrK5Z1vFKgnzKTcj
 kNakatiJKHT7WvJDmjwMNkGzM2RQwe94blCEwROmCSXI9lSopUahh/E6ZblykzgpwAbQ
 ZDFzmuSjjQ4gZvNGLUqtcpkeDtug+pq9+xSaUmjFrIT4yc+Wl11eazYoPLjHzsNgb8Ci
 fo6HxYCzJj8wun07pSO08DNTEUx+ZlHI4STWcBkjJYR3IxWJCxLucTJ+5v44j35NkU1r
 KqEnGTFVR5NV2Z/LMi5ixZR5oPBOHxoE4o7HamWDPVimKeIIY7qj5K7rdUodvDKdE8Pv
 1Gdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGqgYCO809uKmQdC6FLTTG92epWGHgvoiVdHyNEeNrrqnudwQjAnqEJmY0iyCmpbiM5+0=@lists.linux.it
X-Gm-Message-State: AOJu0YzSXERGWfeA9vVPqaUN7jwPHOArKqIUbJTTQHEbh3HbQQDtx0rd
 MqyI7y7EZE2yX+xjlrHfh/gXs06KNY87FxBrpMjtRS8///dJQ18CdDSjjh4EugRvr3SEw7afDf5
 ZUJybfg==
X-Gm-Gg: ASbGncumVqBTwiD2ZJbJtoLq0XqKqjfP/MQy1fFyfEjI1N8SAwpGdJkiDEit3Tzh4py
 F9a+OYNfeNnnqXJCflblAiJDki2szxHRxc+PtGcqGiuHWg7shOtRMR0iHcnaEWnwmsY/kgQZHqO
 /AeF+8TojJ1KMgw5kholK3E/9fddkP+Feaavbr+XHitFGoXHwWDxj+5YF/Rz61sFZTTILDXgP//
 L4S5YhUqQtC0N2mxJ7Y6k0+5985sJOxqX73+M6+Dx52p8Cn9IkrdqenczZhIGGmwwzv91vybeSd
 Wx8XvtA8iZKE7SWr2IJ6N92eBA==
X-Google-Smtp-Source: AGHT+IEiAJrY4sw9UFZYLjpOekfHe1AaYFFD8wFfPwUyglsxRTTUhPTggN2McRKTtvIill0GTkrYzg==
X-Received: by 2002:a17:906:478a:b0:aa6:94c0:f753 with SMTP id
 a640c23a62f3a-ab6cfd096f9mr2172663566b.33.1738577180371; 
 Mon, 03 Feb 2025 02:06:20 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a32520sm721839066b.156.2025.02.03.02.06.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 02:06:19 -0800 (PST)
Message-ID: <0ab8185b-0d81-43ac-bdb6-4d500df2bf39@suse.com>
Date: Mon, 3 Feb 2025 11:06:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, ltp@lists.linux.it, pvorel@suse.cz
References: <20250116084013.503341-1-ruansy.fnst@fujitsu.com>
Content-Language: en-US
In-Reply-To: <20250116084013.503341-1-ruansy.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] fchownat01: Convert to new API
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

All patch-set looks good. I'm gonna merge it, linking fchownat03 test 
inside runtest/syscalls file because it's missing from fchownat03 patch.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Thanks for the good job,
Andrea

On 1/16/25 09:40, Shiyang Ruan wrote:
> 1. convert to new API
> 2. move error tests to fchownat03
> 3. check if uid/gid is correctly set
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>
> ---
> V2: https://lore.kernel.org/ltp/20250115091218.2630891-1-ruansy.fnst@fujitsu.com/
>
> Changes:
>   * Initialize fd to -1, and check fd != -1 when cleanup
>   * Do not use TST_*_SILENT()
>   * fchownat01: describe what this case does in DESCRIPTION
>   * fchownat01: use TST_EXP_EQ_LI(); do not use test case struct
>   * fchownat02: use TST_EXP_EXPR()
>   * fchownat03: write a proper commit message, add more errnos to test
>
> ---
>   .../kernel/syscalls/fchownat/fchownat01.c     | 153 +++++-------------
>   1 file changed, 42 insertions(+), 111 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
> index 7771c111a..fedcb8ab2 100644
> --- a/testcases/kernel/syscalls/fchownat/fchownat01.c
> +++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
> @@ -1,133 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - *   Copyright (c) International Business Machines  Corp., 2006
> - *   AUTHOR: Yi Yang <yyangcdl@cn.ibm.com>
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
> - *   along with this program;  if not, write to the Free Software Foundation,
> - *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * Copyright (c) International Business Machines  Corp., 2006
> + * Copyright (c) Linux Test Project, 2007-2025
>    */
> -/*
> - * DESCRIPTION
> - *	This test case will verify basic function of fchownat
> - *	added by kernel 2.6.16 or up.
> +
> +/*\
> + * [Description]
> + *
> + * Verify that fchownat() succeeds to change file's ownership if the file
> + * descriptor is AT_FDCWD or set by opening a directory.
>    */
>   
>   #define _GNU_SOURCE
> +#include "tst_test.h"
>   
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <unistd.h>
> -#include <stdlib.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/fcntl.h"
> +#define TESTFILE1	"testfile1"
> +#define TESTFILE2	"testfile2"
>   
> -#define TESTFILE	"testfile"
> +static uid_t set_uid = 1000;
> +static gid_t set_gid = 1000;
> +static int dir_fd = -1;
>   
> -static void setup(void);
> -static void cleanup(void);
> -
> -static int dir_fd;
> -static int fd;
> -static int no_fd = -1;
> -static int cu_fd = AT_FDCWD;
> -
> -static struct test_case_t {
> -	int exp_ret;
> -	int exp_errno;
> -	int flag;
> -	int *fds;
> -	char *filenames;
> -} test_cases[] = {
> -	{0, 0, 0, &dir_fd, TESTFILE},
> -	{-1, ENOTDIR, 0, &fd, TESTFILE},
> -	{-1, EBADF, 0, &no_fd, TESTFILE},
> -	{-1, EINVAL, 9999, &dir_fd, TESTFILE},
> -	{0, 0, 0, &cu_fd, TESTFILE},
> -};
> -
> -char *TCID = "fchownat01";
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -static void fchownat_verify(const struct test_case_t *);
> -
> -int main(int ac, char **av)
> +static void fchownat_verify(void)
>   {
> -	int lc;
> -	int i;
> +	struct stat stat_buf;
>   
> -	tst_parse_opts(ac, av, NULL, NULL);
> +	TST_EXP_PASS(fchownat(AT_FDCWD, TESTFILE1, set_uid, set_gid, 0),
> +		     "fchownat(%d, %s, %d, %d, 0)",
> +		     AT_FDCWD, TESTFILE1, set_uid, set_gid);
>   
> -	setup();
> +	SAFE_STAT(TESTFILE1, &stat_buf);
> +	TST_EXP_EQ_LI(stat_buf.st_uid, set_uid);
> +	TST_EXP_EQ_LI(stat_buf.st_gid, set_gid);
>   
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -		for (i = 0; i < TST_TOTAL; i++)
> -			fchownat_verify(&test_cases[i]);
> -	}
> +	TST_EXP_PASS(fchownat(dir_fd, TESTFILE2, set_uid, set_gid, 0),
> +		     "fchownat(%d, %s, %d, %d, 0)",
> +		     dir_fd, TESTFILE2, set_uid, set_gid);
>   
> -	cleanup();
> -	tst_exit();
> +	SAFE_STAT(TESTFILE2, &stat_buf);
> +	TST_EXP_EQ_LI(stat_buf.st_uid, set_uid);
> +	TST_EXP_EQ_LI(stat_buf.st_gid, set_gid);
>   }
>   
>   static void setup(void)
>   {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	dir_fd = SAFE_OPEN(cleanup, "./", O_DIRECTORY);
> -
> -	SAFE_TOUCH(cleanup, TESTFILE, 0600, NULL);
> -
> -	fd = SAFE_OPEN(cleanup, "testfile2", O_CREAT | O_RDWR, 0600);
> -}
> -
> -static void fchownat_verify(const struct test_case_t *test)
> -{
> -	TEST(fchownat(*(test->fds), test->filenames, geteuid(),
> -		      getegid(), test->flag));
> -
> -	if (TEST_RETURN != test->exp_ret) {
> -		tst_resm(TFAIL | TTERRNO,
> -			 "fchownat() returned %ld, expected %d, errno=%d",
> -			 TEST_RETURN, test->exp_ret, test->exp_errno);
> -		return;
> -	}
> -
> -	if (TEST_ERRNO == test->exp_errno) {
> -		tst_resm(TPASS | TTERRNO,
> -			 "fchownat() returned the expected errno %d: %s",
> -			 test->exp_ret, strerror(test->exp_errno));
> -	} else {
> -		tst_resm(TFAIL | TTERRNO,
> -			 "fchownat() failed unexpectedly; expected: %d - %s",
> -			 test->exp_errno, strerror(test->exp_errno));
> -	}
> +	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
> +	SAFE_TOUCH(TESTFILE1, 0600, NULL);
> +	SAFE_TOUCH(TESTFILE2, 0600, NULL);
>   }
>   
>   static void cleanup(void)
>   {
> -	if (fd > 0)
> -		close(fd);
> -
> -	if (dir_fd > 0)
> -		close(dir_fd);
> -
> -	tst_rmdir();
> +	if (dir_fd != -1)
> +		SAFE_CLOSE(dir_fd);
>   }
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.test_all = fchownat_verify,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
