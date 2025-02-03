Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CFAC02196
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738576699; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=jL0af2yMoCZkn90+13Im/zVJ9kzkmizGxVY6BXJb0OE=;
 b=A7GlY01e2nPKi44gX4dLxGGQ8fafm2hyi77KzT3wHDFQdodCqZLvnQTLbq6tQTwC5xI32
 1Css9f/os7gouT0VQM9PNJo8G2bGK5GSrH4LdpgYywTFclJ+AOB5N0t+0kdGYYeT537Z1OR
 2OqkzpCSUWG7VXlL/z1nXFcz9W93XcU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7368A3C8EA2
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 10:58:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88A023C8E71
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 10:57:57 +0100 (CET)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E8E8F142E675
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 10:57:55 +0100 (CET)
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-ab70043cd05so594989466b.0
 for <ltp@lists.linux.it>; Mon, 03 Feb 2025 01:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738576675; x=1739181475; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pjAgJfwF6r7DlwHyqYVZr+63limf/UOsVHvomNCXH9M=;
 b=SrvvdEqF3v5osO/m3tCES2pNdQj+obX94+4Q//eOq9ll1OIPM/UWZURWWAWS8Bv0Rm
 RhRXLlenQoJD7oRl5rXMN5VBgOatF8XdsWL0YxNRafxI92x6wZMJuPguz1wGfdT58LUg
 rwVkFtwgU5IHkLmEd5Sk0q+nHxTPsAnyLPOqUiuQfR428tDAdfMsoqiWJHD0lKYrJ/F/
 x+w61pRL77JbQmrQL0rSVV88Do/ioQBVHRi0hOgSG0uTlCc2CNq0ma+UJjAv+B30vJMM
 XryE/I1AZlLwRcKipgePy6GgKb79lwq9sMQ+9B6E+tiNFtaWLdROB8hej27HzPE1/wGa
 zQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738576675; x=1739181475;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pjAgJfwF6r7DlwHyqYVZr+63limf/UOsVHvomNCXH9M=;
 b=Lh1DGfOgVn1dsSacw3iofz6fH6N/ZfUEDXCAZdhOCwxV26XouKDtcDpPMPaApMc+lI
 I4vmW9BmJSpl8vJpfHj56acayC3G7Mmr+XmwQ/274lO5366d5pmHCBeE3Tj49K/U6BsW
 lyPQ6wuNo+OeR/1Bl3GbU2Dxj9NTyS9wDTQuMYUDRIa6nQAzKe2f3swIMrLiEy8r50Cz
 r/oIv7xj+heO673eHU7LrEpkKWhFo3MEWoOkFymv/Y8qgWhPloiel+mRSS6L9au5chAe
 FJhQ7pHxj22cJkXR70J83cS3hXa/qScEDeduRSiRS6Q/v4tDDTzvxhiModzGuRGE8Naa
 exYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpwZ8wZUMysjVJy3d5AazaZDYYuPwPAr6SCx3hPCKJ+j/RFLkEKQqXrsU3Yzx9YkweSNw=@lists.linux.it
X-Gm-Message-State: AOJu0YzZ626+3zUqp7Y+MNNSvKIlAr75EYmJVsM+dvoHMruHIO136st2
 viXwCiJYc7w4UmwfFwd/6l1LW8WKJM9vcVz7GChpb857vyB8uDIPpdjGAdw1rYw=
X-Gm-Gg: ASbGnctDKRhZBWe2mxu92tk2BzhCwwRJyhbV7n5OxDXu83AnVDnLhEDPpnIrx/+FoLj
 ydQzY4zJpYdsuQW0o+GJOhcZStrTBGBfymFG5SqBuDvt13uyUMoYuFhETTN4mebSC43USODdeNW
 ohSisiKOgDsF1jaV/gSy5aOGbHqToVOOvgsLPxxu1g7yUZffKmvezjB/Tbuuu3YVKApuDYSAZ0j
 S5z1ylBEjIuZ39j+T/qlnQqG6uV26w2rpIXfKHKcoY4yhbUJb7C19RUAPQJ13hGQq61eUwEApHM
 RwdQrOeOAiyFPAICuwVV9DaGSw==
X-Google-Smtp-Source: AGHT+IFon7fA11O29rmGWLT/awOhJY1VScHwJqUBjapyPqpVQUVsZmDn7o6DaX+eduHY7wBxe5x0Ww==
X-Received: by 2002:a17:907:c10:b0:ab6:f59b:8327 with SMTP id
 a640c23a62f3a-ab6f59b8396mr1868620766b.10.1738576675272; 
 Mon, 03 Feb 2025 01:57:55 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab705a00b60sm493038366b.10.2025.02.03.01.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 01:57:54 -0800 (PST)
Message-ID: <9d0b6458-6d77-4c2c-a46b-60208d07b5df@suse.com>
Date: Mon, 3 Feb 2025 10:57:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, ltp@lists.linux.it,
 liwang@redhat.com
References: <20250115091218.2630891-1-ruansy.fnst@fujitsu.com>
Content-Language: en-US
In-Reply-To: <20250115091218.2630891-1-ruansy.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

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
> +
> +	/* check if the file's ownership changed successfully */
> +	SAFE_STAT(filename, &stat_buf);
> +	if (stat_buf.st_uid == set_uid && stat_buf.st_gid == set_gid)
> +		tst_res(TPASS, "fchownat(%d, %s, %d, %d, 0)",
> +			fd, filename, set_uid, set_gid);
> +	else
> +		tst_res(TFAIL, "fchownat() fails because uid(%d) != set(%d) || "
> +			"gid(%d) != set(%d)",
> +			stat_buf.st_uid, set_uid,
> +			stat_buf.st_gid, set_gid);
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

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
