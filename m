Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3366AC02185
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 12:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736943395; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=MnpP/sOLXk4C8i79bvjNnfArmR/ec0oQnttikGaUQbk=;
 b=Oc7jTfeCs3uD2qquc9pBsebeVrUhTVxTz4eevUX09bI7Xdc2Af5F48VY6ER0swHMTtsAr
 qz3U7iFrJ5ZATSFGRUUBNwoNy9h7ZZdBozX6nsZDouV/Mm0Hx2wZXrCiSOas1cKSnsmTmg9
 X91lb7JZmKhAF1y/w/KqcbMsbF5a8Ik=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89D523C7AAA
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 13:16:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A2213C217E
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 13:16:13 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4DB121BD98C6
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 13:16:12 +0100 (CET)
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso5483758f8f.1
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 04:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736943371; x=1737548171; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xhsOIf6jEn3rhAfXyasxbw2k2fuGPMuCRFHfQ0GD010=;
 b=TAjKo1uh5iS+kaI9X36Nk1HqsRH3FypMqDpUE9PluFMXeckPJtjFLg9Z2rbUgDnMk+
 n1+Rq7nMYi7nBBAf9P6476FxKKAAXLpfrj9Lugd2DtC38jhknLaKecaSCsPk0cuPceAE
 fED7PJXIdr/D6dMLGcENbp5oKB/p4DzeWL7tmd1W6wCM5qbgsPLmJmuMA5nrKmmgMRhy
 F2345L+31zS3WboVyvnAZcsBoMkuQdnORX5wDYe+WARvuQootzey7mgu0zkQ/eWKx4/H
 o0w4kOoOeKPaSrGv5vAryU1uhO/RWycXXgG9FzFLBtrp11kwXw2ueEdZVogno2EsNcQE
 0O1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736943371; x=1737548171;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xhsOIf6jEn3rhAfXyasxbw2k2fuGPMuCRFHfQ0GD010=;
 b=NL857O8fuTATdQk0kx/jOH+WNHXGmdN64j9bUF57FtOTP6vJG2ao8VR1Qk4s5VG0wR
 ctOe8wBRszIIFPK1dtNgJ/wN1dUdu4UqyMXp/7adnzf4By11Y5brSsO+ZAz1rvSj0s/x
 k1RodvvLH1zXBtHadlUy5nFHciAnp6PlNPx0y9blAD2ChWNVc2Ly1t9cUjkCeSIdQ4NO
 WhgNn8IpPCMK/L0b7XIXbJZEaS+Dc9QErj4mwI8KmcF5xbRVb8zsuo0gTd1l9uRWAOq9
 rDhuzr4hJ7+BCCzm6n95hekB7uEexcP0hglTjg62HBkr5KV5Mh/PhTD+2DF6eML/qenp
 HhRw==
X-Gm-Message-State: AOJu0YwLWGLHj1lonPHM5VqEJymu3Nkyvu/aJOx5/xnZfNYGBYmyLivF
 FlC57CsjhVpNaoMlUlXirSHawk/wG39gULi3MASp1YBg+vNJ8TmtE7VnunNL5FeaCkkpn7gubWp
 TfT6mmur5
X-Gm-Gg: ASbGncvsfcqkNFyioezg3u3VPZzZeslNWOiRLhGcUm9UfsGMff2RdWXTNsUZKVXN+mc
 V/3q3LaqTfVKSfGZ9wIH4KHLMPJUuzRWEl87iZlxPWk5pRFwZUhPbJFLuE28XSMyKgy8F09NwF0
 fhyL9pqF8vpa608RtbjuFcTw+GhNGNwNC0h6mOhhdoMHQhTobC+cKymqeuxwyXZCe8qQ+Oym6Wj
 6Ivl9qQddXuxS5cc2+YXHapJkpLqIsxfIIVUPcB00KdWGGY/Yz+70jEKaEWR66oX85jJ2dGKcQ9
 eF3N0DnvNPJdTh8eH+fl3Q0i5ZBQyhnNMAAgLkdMX4ZFG1VStImNSPKfrTJ2tdknU49bAE5DozR
 ezdsdf4X4xkdBoRZMLWA=
X-Google-Smtp-Source: AGHT+IEM6F5cT1PIvHBS/OE7mTQ9qJB7Z3OP2XRhd8ctIiPizfh5TPGoVWQb29eyvYKiqasGcxfHyA==
X-Received: by 2002:a5d:64ed:0:b0:38a:5122:5a10 with SMTP id
 ffacd0b85a97d-38a872de114mr27566424f8f.15.1736943371299; 
 Wed, 15 Jan 2025 04:16:11 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d2f5sm17583537f8f.17.2025.01.15.04.16.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 04:16:10 -0800 (PST)
Message-ID: <bc282b7b-a9fd-40ad-b1d0-0030c92fc524@suse.com>
Date: Wed, 15 Jan 2025 13:16:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it, ruansy.fnst@fujitsu.com
References: <20250115091218.2630891-1-ruansy.fnst@fujitsu.com>
Content-Language: en-US
In-Reply-To: <20250115091218.2630891-1-ruansy.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] fchownat01: Convert to new API
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

On 1/15/25 10:12, Shiyang Ruan via ltp wrote:
> 1. convert to new API
> 2. move error tests to fchownat03
> 3. check if uid/gid is correctly set
>
> ---
> V1: https://lore.kernel.org/ltp/20240126062540.2596279-1-ruansy.fnst@fujitsu.com/T/#u
>
> Changes:
>   * Move error tests from fchownat01 to fchownat03
>   * fchownat01: Add check if file's ownership changed successfully
>   * fchownat02: Use AT_FDCWD instead of dir_fd
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>   .../kernel/syscalls/fchownat/fchownat01.c     | 160 ++++++------------
>   1 file changed, 50 insertions(+), 110 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
> index 7771c111a..6768fdd77 100644
> --- a/testcases/kernel/syscalls/fchownat/fchownat01.c
> +++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
> @@ -1,133 +1,73 @@
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
> + * Verify basic function of fchownat() added by kernel 2.6.16 or up.
We need a bit more information here. The description should tell at 
first read what test is doing without reading the source code.
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
> -
> -#define TESTFILE	"testfile"
> -
> -static void setup(void);
> -static void cleanup(void);
> +#define TESTFILE1	"testfile1"
> +#define TESTFILE2	"testfile2"
>   
> +static uid_t set_uid = 1000;
> +static gid_t set_gid = 1000;
>   static int dir_fd;
> -static int fd;
> -static int no_fd = -1;
>   static int cu_fd = AT_FDCWD;
>   
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
> +static struct tcase {
> +	int *fd;
> +	char *filename;
> +} tcases[] = {
> +	{ &dir_fd, TESTFILE1, },
> +	{ &cu_fd, TESTFILE2, },
>   };
>   
> -char *TCID = "fchownat01";
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -static void fchownat_verify(const struct test_case_t *);
> -
> -int main(int ac, char **av)
> +static void fchownat_verify(unsigned int n)
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
> -		for (i = 0; i < TST_TOTAL; i++)
> -			fchownat_verify(&test_cases[i]);
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	struct tcase *tc = &tcases[n];
> +	struct stat stat_buf;
> +	int fd = *tc->fd;
> +	const char *filename = tc->filename;
> +
> +	TST_EXP_PASS_SILENT(fchownat(fd, filename, set_uid, set_gid, 0));
We can use the regular TST_EXP_PASS() since we are testing fchownat() 
syscall.
> +
> +	/* check if the file's ownership changed successfully */
comment is not needed.
> +	SAFE_STAT(filename, &stat_buf);
> +	if (stat_buf.st_uid == set_uid && stat_buf.st_gid == set_gid)
> +		tst_res(TPASS, "fchownat(%d, %s, %d, %d, 0)",
> +			fd, filename, set_uid, set_gid);
> +	else
> +		tst_res(TFAIL, "fchownat() fails because uid(%d) != set(%d) || "
> +			"gid(%d) != set(%d)",
> +			stat_buf.st_uid, set_uid,
> +			stat_buf.st_gid, set_gid);

We can simplify with:

TST_EXP_EQ_LI(stat_buf.st_uid, set_uid);
TST_EXP_EQ_LI(stat_buf.st_gid, set_gid);

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
>   	if (dir_fd > 0)
It's better to use dir_fd != -1 and initialize dir_fd to -1 at definition.
> -		close(dir_fd);
> -
> -	tst_rmdir();
> +		SAFE_CLOSE(dir_fd);
>   }
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.test = fchownat_verify,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};

I have the impression we are over-complicating things using test case 
struct here. We have only 2 use cases: one with directory descriptor and 
one with AT_FDCWD.

We can just add both testcases inside the verify_fchownat() function and 
initialize file descriptors inside setup(). In this way we reduce the 
amount of code and we simplify the overall structure of the test.

Kind regards,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
