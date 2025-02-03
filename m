Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DEBC02192
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 10:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738577012; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=6o7aOGWCQAvqbq+r0yn+ssPW0M4HWgbUF1iEQZFHcGs=;
 b=N5PFffy41GrzVgMWVyZQ4L3EjhJ7jEcxarz3rRZbInT+kDgnUiUXtRDTU0Z1G+YINjIAg
 ttd3aMWlkvAHyCeaa+uufYxX+YH+GvihU7R+8Qn9kpy8ZRDUqIi4SgmDb9sZXLXV264GGV7
 aR9DmDz85tS2gohi0z/YvUpj9AnIWR4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B60DE3C8CE1
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 11:03:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63F233C8E97
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 11:02:59 +0100 (CET)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 194D46216C0
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 11:02:58 +0100 (CET)
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-ab34a170526so660976366b.0
 for <ltp@lists.linux.it>; Mon, 03 Feb 2025 02:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738576977; x=1739181777; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mja3doy7DMrOO7GeEpR0Yd1WURLvHlpXQrKxKVqe/ks=;
 b=ZLNw0WqD+vZQ8V44FyliyuxOuyHBzC/OHcfHLyc7MNjFVY4NabZ+VYB86oKtNY49DM
 JAdafp9V8y/dVxUQhFaItepT9fxfzPA0Hi3BCup5+vEJazogARJ24mqbIWKvYKWbFolj
 LGxl7QHM6tbIdlMpFIGlgBFZho0bAzoIif7l5QCM1EmTY4XvPYC7Rrb1LZj0baeVjeWD
 StKoa1RwyRaznNSKZFFSHo/zZmQe0PMiQhpDHQGa0dY+noqC2ZTNX6CNRHVOKGt/PVsw
 L7M9s9fixclOMnxkUo9Uke3qjAzWU/iFPDDJ6JX7F0YQbaEhYKymfabuyEgHDrMrduZ3
 SAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738576977; x=1739181777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mja3doy7DMrOO7GeEpR0Yd1WURLvHlpXQrKxKVqe/ks=;
 b=ekbRXRM10r3oqG38oN10qyRfeLIBRXjFcIaFMt7GXPUpIh2/tdgLvSy3Y/gPkRG2rZ
 w7GpJnfJyPU0naeN5BmD8VNjKI6wjzQAep2had/dO1S2Md/3DvFLOV7UMc3G2hndjUwJ
 l7mN2HXmTz5av8t4Aa37mLi6/0879YLNTPjWgDOVtnGfKJFbhra3JL8jSuEV9pHlK4Qr
 F091A+BGZjvC1WdJ9Q85QI6n55r5Op9iWOvdui381ZIyvlweVtHUvUFvZlXWXeduNDgX
 qQqpUC39QG7gEot95PeLhDXX/UKFOJDpBA2F+jfvmtn1wgbZiHbHzvBZkSOwRigv7/M0
 UIgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNXdjH+A3UcGpkOtF27csEh1481NpAO50AW9PQKwjO1BSWcjMKqbYZ9x5Ww/ah+9ItezQ=@lists.linux.it
X-Gm-Message-State: AOJu0YztINOXCrz21XwRaLgYrRcxA65PD4A38U+XqSbODpNxL0wg/vn1
 qCMtZMmRkdNeh9uEAZfXf3qdbMqSByI8IQ48DgDIUupvjG5nOcFQ893nKVcqwEI=
X-Gm-Gg: ASbGncvXCkZHyectnDk0daezrdphN5INl/m2ySOLefO6VTSiWRHdc/bYs1OfsRDhcgT
 qFSNmr3kxMSBtgy5oDR7/khO7GkUc1gPPdiUFsmjKk9netIl6tiItKHZxH09wbRsbZioeD1Vqzw
 gyMNIg+wbL0+OufsXWvzDulSShKosSqGpHghWgZt6ji4OGeYsCZy6d4uVXo5GPYgrjdyiBvwcbx
 lc5EXzl04wEVMNZz2qsd80WzoWnw1NIMZ1tTjBYruhyIFfuUEegGE3ivNyqF3HeZKkro2MBf4Pd
 26eVd/rdOyGz2/to5rPZGZWc9w==
X-Google-Smtp-Source: AGHT+IF3aU+hUE6x9ORoy7pxJg4YRP3LA57RmjBKb/eB0ZJVSTz3Sff74R8TiDgfZc1i4aEeMsPXrA==
X-Received: by 2002:a17:907:3e0f:b0:ab6:52d9:8cd8 with SMTP id
 a640c23a62f3a-ab6cfcdf2c5mr2292643066b.13.1738576977440; 
 Mon, 03 Feb 2025 02:02:57 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47a7b0fsm730391766b.12.2025.02.03.02.02.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 02:02:57 -0800 (PST)
Message-ID: <0ed64220-9d81-4247-98c8-84f874292bef@suse.com>
Date: Mon, 3 Feb 2025 11:02:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, ltp@lists.linux.it, pvorel@suse.cz
References: <20250116084013.503341-1-ruansy.fnst@fujitsu.com>
 <20250116084013.503341-2-ruansy.fnst@fujitsu.com>
Content-Language: en-US
In-Reply-To: <20250116084013.503341-2-ruansy.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] fchownat02: Convert to new API
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

On 1/16/25 09:40, Shiyang Ruan wrote:
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>   .../kernel/syscalls/fchownat/fchownat02.c     | 138 ++++--------------
>   1 file changed, 32 insertions(+), 106 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fchownat/fchownat02.c b/testcases/kernel/syscalls/fchownat/fchownat02.c
> index 6dd1e024e..10b4f5e3c 100644
> --- a/testcases/kernel/syscalls/fchownat/fchownat02.c
> +++ b/testcases/kernel/syscalls/fchownat/fchownat02.c
> @@ -1,135 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2014 Fujitsu Ltd.
> - * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
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
> - * with this program.
> + * Copyright (c) Linux Test Project, 2014-2025
>    */
> -/*
> - * Test Description:
> - *   Verify that,
> - *   The flag of fchownat() is AT_SYMLINK_NOFOLLOW and the pathname would
> - *   not be dereferenced if the pathname is a symbolic link.
> +
> +/*\
> + * [Description]
> + *
> + * Verify that fchownat() will operate on symbolic links when
> + * AT_SYMLINK_NOFOLLOW is used.
>    */
>   
>   #define _GNU_SOURCE
> -
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <unistd.h>
> -#include <stdlib.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/fcntl.h"
> +#include "tst_test.h"
>   
>   #define TESTFILE	"testfile"
>   #define TESTFILE_LINK	"testfile_link"
>   
> -char *TCID = "fchownat02";
> -int TST_TOTAL = 1;
> -
> -static int dir_fd;
>   static uid_t set_uid = 1000;
>   static gid_t set_gid = 1000;
> -static void setup(void);
> -static void cleanup(void);
> -static void test_verify(void);
> -static void fchownat_verify(void);
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
> -			fchownat_verify();
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
>   
>   static void setup(void)
>   {
>   	struct stat c_buf, l_buf;
>   
> -	tst_require_root();
> -
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
> -	SAFE_SYMLINK(cleanup, TESTFILE, TESTFILE_LINK);
> -
> -	SAFE_STAT(cleanup, TESTFILE_LINK, &c_buf);
> -
> -	SAFE_LSTAT(cleanup, TESTFILE_LINK, &l_buf);
> +	SAFE_TOUCH(TESTFILE, 0600, NULL);
> +	SAFE_SYMLINK(TESTFILE, TESTFILE_LINK);
> +	SAFE_STAT(TESTFILE_LINK, &c_buf);
> +	SAFE_LSTAT(TESTFILE_LINK, &l_buf);
>   
>   	if (l_buf.st_uid == set_uid || l_buf.st_gid == set_gid) {
> -		tst_brkm(TBROK | TERRNO, cleanup,
> -			 "link_uid(%d) == set_uid(%d) or link_gid(%d) == "
> -			 "set_gid(%d)", l_buf.st_uid, set_uid, l_buf.st_gid,
> -			 set_gid);
> +		tst_brk(TBROK,
> +			"uid link(%d) == set(%d) or gid link(%d) == set(%d)",
> +			l_buf.st_uid, set_uid, l_buf.st_gid, set_gid);
>   	}
>   }
>   
> -static void fchownat_verify(void)
> -{
> -	TEST(fchownat(dir_fd, TESTFILE_LINK, set_uid, set_gid,
> -		      AT_SYMLINK_NOFOLLOW));
> -
> -	if (TEST_RETURN != 0) {
> -		tst_resm(TFAIL | TTERRNO, "fchownat() failed, errno=%d : %s",
> -			 TEST_ERRNO, strerror(TEST_ERRNO));
> -	} else {
> -		test_verify();
> -	}
> -}
> -
> -static void test_verify(void)
> +static void run(void)
>   {
>   	struct stat c_buf, l_buf;
>   
> -	SAFE_STAT(cleanup, TESTFILE_LINK, &c_buf);
> +	TST_EXP_PASS(fchownat(AT_FDCWD, TESTFILE_LINK, set_uid, set_gid, AT_SYMLINK_NOFOLLOW),
> +		     "fchownat(%d, %s, %d, %d, %d)",
> +		     AT_FDCWD, TESTFILE_LINK, set_uid, set_gid, AT_SYMLINK_NOFOLLOW);
>   
> -	SAFE_LSTAT(cleanup, TESTFILE_LINK, &l_buf);
> +	SAFE_STAT(TESTFILE_LINK, &c_buf);
> +	SAFE_LSTAT(TESTFILE_LINK, &l_buf);
>   
> -	if (c_buf.st_uid != set_uid && l_buf.st_uid == set_uid &&
> -	    c_buf.st_gid != set_gid && l_buf.st_gid == set_gid) {
> -		tst_resm(TPASS, "fchownat() test AT_SYMLINK_NOFOLLOW success");
> -	} else {
> -		tst_resm(TFAIL,
> -			 "fchownat() test AT_SYMLINK_NOFOLLOW fail with uid=%d "
> -			 "link_uid=%d set_uid=%d | gid=%d link_gid=%d "
> -			 "set_gid=%d", c_buf.st_uid, l_buf.st_uid, set_uid,
> -			 c_buf.st_gid, l_buf.st_gid, set_gid);
> -	}
> +	TST_EXP_EXPR(c_buf.st_uid != set_uid && l_buf.st_uid == set_uid,
> +		     "fchownat() correctly operated on symlink user ID");
> +	TST_EXP_EXPR(c_buf.st_gid != set_gid && l_buf.st_gid == set_gid,
> +		     "fchownat() correctly operated on symlink group ID");
>   }
>   
> -static void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.test_all = run,
> +	.setup = setup,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
