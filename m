Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FBFC48BC3
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 15:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708529171; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Wa+iaNBj/vYhOgn3Ptt/XjdiByAk4L2QBKVmaOYAoHo=;
 b=W3OiWUdJMxCkqPbpcajdgci9PjTKfWvRUnpiZWZJVsSX97g8FkQiQj9pdAOiNe1GQ0a3H
 WURfeij4lsQNvHMZjppRGxsgELTWQkMKoRqY95/ZLvxTddjzvTMX/T8J054nKn6IXJAXSjN
 cy4HcJXDUSmEBT/HE31mvTM/7zxys7k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 467663D0B15
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 16:26:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 690F13C8EE0
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 16:25:49 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AA4AB602A15
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 16:25:48 +0100 (CET)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a3d484a58f6so103124366b.3
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 07:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708529147; x=1709133947; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LZ+VRj4bOs/50gJ5sa/vw6iaVdCnSgJUmLMYsayQ+ms=;
 b=H/k5Qv30Wuklil7tZWW0zlenJx8UIA3LMXzzD341ktL4Uoa95xP3BzqePqI9nXPLHi
 Uo0Xew8bjmyj1Qn8NoD/wOltNeerI8ETNlMlASYws1seJ+fTl7B+TIOowwxBnaHuUsoO
 DD12KnzJFi0kbIQjHPVlEVIMTBy+BnNlE04duBS+DfWWVoBAwtwhAb9AHTYmf9u3dOZ4
 t54iI+Sg5zVWUhgfATfvO7NyNo9e1gS5OqMmxrx9I6+Im8XhBsMI1kIlcSRP0Myi9VGk
 i6G7MuMLjtuCBL1HN/zUPMUgU1P7kuWIlH3626rGHnBVLAQ+rfvsi1hRMCNdIXRUhJcg
 YxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708529147; x=1709133947;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LZ+VRj4bOs/50gJ5sa/vw6iaVdCnSgJUmLMYsayQ+ms=;
 b=LJnmU5mN54vYVJfkFSDWVs/B1PHsjFQUyLFyXmSlRaHkwj8avssLTmId7nCksxmP5Y
 rcckn41ZCkK4CHWXNE5x3DoFsGl1OjI3OByCICzqs5PcrmnhNW6kAHXd/Box5SXCz04M
 UGu4qanHeREBlsR1IVPnC18Jl/NvK5IENgbymuwyAyMICQr+REzzuTpbYGUk0i6wQrAM
 mwugMSiwsO2hRm0x32bVohHhISNUHdK4VVABGT1OfcG2kZ1JbmW/T0l3bu5N1R644YD7
 BQehsMCREiIJtynr6FWbWd+hKNcN9OyAlmAdf9+UHfMkjtx5k6iDNbm1UrnT4JBfHJC3
 Fqqg==
X-Gm-Message-State: AOJu0YxnuRVjs1wx0oIne997cbJA74SIQ3RjAC5ZIAdlY5StMZ6XqYX9
 KETPFh/Lp0P+Wpq+MP6GzY9ndTTi78/7knNQdqZeHV8ieHF2yL0kfK4l60joSwZghDkFdrUph+R
 ioD0=
X-Google-Smtp-Source: AGHT+IEGFyEZ5KqH3DQ4YCCbSOW2xGZpzyHGy5Zj13GkHfb5F/aDyMSl9TMw0cOvKdZt1vbYm4pKfw==
X-Received: by 2002:a17:906:e085:b0:a3f:870:535c with SMTP id
 gh5-20020a170906e08500b00a3f0870535cmr2910462ejb.44.1708529147290; 
 Wed, 21 Feb 2024 07:25:47 -0800 (PST)
Received: from [10.232.133.81] ([88.128.88.5])
 by smtp.gmail.com with ESMTPSA id
 bh5-20020a170906a0c500b00a3ea6b5e4eesm2976703ejb.19.2024.02.21.07.25.46
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 07:25:46 -0800 (PST)
Message-ID: <d3a85ff2-25f5-4b2c-ae53-c89647627717@suse.com>
Date: Wed, 21 Feb 2024 16:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <20231222094455.3878-1-xuyang2018.jy@fujitsu.com>
In-Reply-To: <20231222094455.3878-1-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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

On 12/22/23 10:44, Yang Xu wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   .../kernel/syscalls/fchownat/fchownat01.c     | 163 +++++++-----------
>   1 file changed, 61 insertions(+), 102 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
> index 7771c111a..c00c6063e 100644
> --- a/testcases/kernel/syscalls/fchownat/fchownat01.c
> +++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
> @@ -1,133 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - *   Copyright (c) International Business Machines  Corp., 2006
> - *   AUTHOR: Yi Yang <yyangcdl@cn.ibm.com>
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> + * Copyright (c) International Business Machines  Corp., 2006
> + * Copyright (c) Linux Test Project, 2006-2023
> + * Author: Yi Yang <yyangcdl@cn.ibm.com>
> + */
> +
> +/*\
> + * [Description]
>    *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> + * Check the basic functionality of the faccessat() system call.
>    *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software Foundation,
> - *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - */
> -/*
> - * DESCRIPTION
> - *	This test case will verify basic function of fchownat
> - *	added by kernel 2.6.16 or up.
> + * - fchownat() passes if dir_fd is file descriptor to the directory
> + *   where the file is located and pathname is relative path of the file.
> + * - fchownat() passes if pathname is absolute, then dirfd is ignored.
> + * - fchownat() passes if pathname is relative and dirfd is the special
> + *   value AT_FDCWD.
> + * - fchownat() passes if pathname is an empty string, operate on the file
> + *   referred to by dirfd.
> + * - fchownat() passes if pathname is a symbolic link, operate on the link
> + *   itself.
>    */
>   
>   #define _GNU_SOURCE
>   
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <unistd.h>
>   #include <stdlib.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/fcntl.h"
> +#include "tst_test.h"
>   
> -#define TESTFILE	"testfile"
> -
> -static void setup(void);
> -static void cleanup(void);
> +#define TESTFILE        "testfile"
> +#define TESTFILE_LINK   "testfile_link"
>   
>   static int dir_fd;
> -static int fd;
> -static int no_fd = -1;
>   static int cu_fd = AT_FDCWD;
> +static char *testfile;
> +static char *abspath;
> +static char *symfile;
> +static char *empty;
>   
> -static struct test_case_t {
> -	int exp_ret;
> -	int exp_errno;
> -	int flag;
> +static struct tcase {
>   	int *fds;
> -	char *filenames;
> -} test_cases[] = {
> -	{0, 0, 0, &dir_fd, TESTFILE},
> -	{-1, ENOTDIR, 0, &fd, TESTFILE},
> -	{-1, EBADF, 0, &no_fd, TESTFILE},
> -	{-1, EINVAL, 9999, &dir_fd, TESTFILE},
> -	{0, 0, 0, &cu_fd, TESTFILE},
> +	char **filenames;
> +	int flag;
> +} tcases[] = {
> +	{&dir_fd, &testfile, 0},
> +	{&dir_fd, &abspath, 0},
> +	{&cu_fd, &testfile, 0},
> +	{&cu_fd, &empty, AT_EMPTY_PATH},
> +	{&dir_fd, &symfile, AT_SYMLINK_NOFOLLOW}
>   };
>   
> -char *TCID = "fchownat01";
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -static void fchownat_verify(const struct test_case_t *);
> -
> -int main(int ac, char **av)
> -{
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
> -}
> -
>   static void setup(void)
>   {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
>   
> -	tst_tmpdir();
> +	SAFE_TOUCH(TESTFILE, 0600, NULL);
>   
> -	dir_fd = SAFE_OPEN(cleanup, "./", O_DIRECTORY);
> +	SAFE_SYMLINK(TESTFILE, TESTFILE_LINK);
>   
> -	SAFE_TOUCH(cleanup, TESTFILE, 0600, NULL);
> +	char *tmpdir = tst_get_tmpdir();
>   
> -	fd = SAFE_OPEN(cleanup, "testfile2", O_CREAT | O_RDWR, 0600);
> +	abspath = tst_aprintf("%s/" TESTFILE, tmpdir);
> +	free(tmpdir);
>   }
>   
> -static void fchownat_verify(const struct test_case_t *test)
> +static void fchownat_verify(unsigned int i)
>   {
> -	TEST(fchownat(*(test->fds), test->filenames, geteuid(),
> -		      getegid(), test->flag));
> +	struct tcase *tc = &tcases[i];
>   
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
> +	TST_EXP_PASS(fchownat(*tc->fds, *tc->filenames, geteuid(), getegid(),
> +		     tc->flag), "fchownat(%d, %s, %d, %d, %d)",
> +		     *tc->fds, *tc->filenames, geteuid(), getegid(), tc->flag);
I would call geteuid() and getegid() only once before the TST_EXP_PASS.
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
> +	if (dir_fd > -1)
> +		SAFE_CLOSE(dir_fd);
>   }
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = fchownat_verify,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.bufs = (struct tst_buffers []) {
> +		{&testfile, .str = TESTFILE},
> +		{&empty, .str = ""},
> +		{&symfile, .str = TESTFILE_LINK},
> +		{},
> +	},
> +	.needs_tmpdir = 1,
> +};

Otherwise LGTM

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
