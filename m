Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F05EC02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 12:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736944382; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Nqn1cox/0UaQCUYbFA/X4VipLI/IIY9SUy6KPTS6oaA=;
 b=OK+Kkj7JjKENqxgfnv7994yuN7YvKmCT80UtvxjOFpu95dGc43oMRBPv6UBxi0satPaa5
 uoo/RSeuzXUUfEjq0+yIC4ybOxCo6sRvBezlr4H98+BPN9akkQr6di46nCM1wgl/CHmpxTg
 bOb3fgcA8dVb70MgsqtpUgfHuKkOszo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E57583C7B76
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 13:33:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C6783C7A3B
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 13:32:42 +0100 (CET)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CA161100E33F
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 13:32:41 +0100 (CET)
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so4684007f8f.2
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 04:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736944361; x=1737549161; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HW/F+NTPd9zA6EeiG17QsvjCz0i5XvpMl5RT5fLR0CU=;
 b=OHOfb0K2seNvVkhk4CkpDNkNq9jif/xIfPnxHXxPtVe2vs/8CfRMObWdktQu0yfbXM
 Zze12H7a59q0UKfWSb7qKjw2Es8tfSzAYmrxt5VhMGNaY0MtyncPixwW+2Yh4wFAzW7t
 6u20UILi75lhXqbjuBSX4Un3Z5f6EnsQvgjQuIeks0ExtcX9Yc10f4tBwKKEfLTMgkOH
 rr36If093SQeS6ijGTfcu0emkst0I+l/TAo0S/ECvAd0w99xsa26zT3m/w7eunMTCwt7
 e02l+SvjXSX9ymHasla4EHVq5h8cMuCUAfNsLTKTXl9fkjGZJ1Trts4C+QYmMso7Vs5W
 0EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736944361; x=1737549161;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HW/F+NTPd9zA6EeiG17QsvjCz0i5XvpMl5RT5fLR0CU=;
 b=TE4XwzmWtHq7hp9/70IZ1lDGnSAmAKH3NF5VI65vhoF2emMvMHWN+aNt96Agm1UNS1
 mJbxTTM8U94Y3uybUEZqyIJBfATOTfars7eq9KnH29g1wVzB77R01Iwlzlu32Pt6+vuq
 EjSA3ICvVk/PjUXyG55AYMi5Qhz0dOYDmGCUAfX0+xo/m78ZN2WGtzZ0G3mmDSz46H11
 n6KR+9cTavUtdreV2w68yQmDtqU1ivtMQy/JyBg7B0h2VyCEUAqgfnI9oKFeKxitwhtx
 pdOr8Pt7NlxRpq1ci2kiS5U48KGHrHwHgEJnO6aTBV7N741QOxs/SnrnN52xrOmWC7Sj
 l6zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8NfC4wTjtaOf7jjcrti6bzZqQmASsjPG5g+4ZqHgOixpkLy2jqQKy3xe1KPQjJp/KJRM=@lists.linux.it
X-Gm-Message-State: AOJu0YyaRJD5Gpqcyr5oRqF66MldPp3mGsya8n6rmXoOlhHeEeSlDTtP
 gMYUwuNa1QlZgn/kj8rv7K6f8HN/CJFcq7JhKQmHvWlw8EaFg8b40UjT7vQwEMzToRdZ28vtrXt
 +bgdxTpov
X-Gm-Gg: ASbGncsko/LoXRHSrCVt17ztYYTA3oyX3NvpORcy5WKCgK7twkvjiqyV/GOUNqW4LRC
 qjdET1bQcj3uhldSWw/9Wh9CbG07LIxTNrGGuuIV+dn1p81xNL/24LU6kKIfJRWfrSlxMCjFiFU
 8VrNo3wmHNezA13hWPfyQuU/l+oFMbasId0ZPP+UkwhjrTwGZMFnBwXwVZuqFspQ37zsRTh4psd
 buNQM6dwuzn8AfyGY7jOzO55UErnm9iUXPA8RojB1ox1quIEaFioR9mL7m38+fsSwCxby0Iy7l9
 KoHEwQW1lQ8epvuCsZ1Op6WQTewqwQdGli4HHLPEl77Bz0g1Gyo3Pl1RnwOCduorZDhmdLWu4qs
 vWe5c6Zrk4LFSeSp/4w4=
X-Google-Smtp-Source: AGHT+IFDIcUQ3wYt/QrzXwkTI00yEMKk47/zcnbTCR3VEbuLjwNBaOOOp2ujc74WfIGwfuRpFDS29A==
X-Received: by 2002:a05:6000:2a3:b0:386:32ca:aa12 with SMTP id
 ffacd0b85a97d-38a8733b9dbmr24827733f8f.49.1736944361076; 
 Wed, 15 Jan 2025 04:32:41 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d2dfsm17177949f8f.7.2025.01.15.04.32.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 04:32:40 -0800 (PST)
Message-ID: <d89f62cd-1949-4598-9919-9c83d6be19c8@suse.com>
Date: Wed, 15 Jan 2025 13:32:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, ltp@lists.linux.it,
 liwang@redhat.com
References: <20250115091218.2630891-1-ruansy.fnst@fujitsu.com>
 <20250115091218.2630891-2-ruansy.fnst@fujitsu.com>
Content-Language: en-US
In-Reply-To: <20250115091218.2630891-2-ruansy.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] fchownat02: Convert to new API
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
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>   .../kernel/syscalls/fchownat/fchownat02.c     | 132 +++++-------------
>   1 file changed, 33 insertions(+), 99 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fchownat/fchownat02.c b/testcases/kernel/syscalls/fchownat/fchownat02.c
> index 6dd1e024e..d8e4e0cfe 100644
> --- a/testcases/kernel/syscalls/fchownat/fchownat02.c
> +++ b/testcases/kernel/syscalls/fchownat/fchownat02.c
> @@ -1,135 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2014 Fujitsu Ltd.
> - * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> + * Copyright (c) Linux Test Project, 2014-2025
> + */
> +
> +/*\
> + * [Description]
>    *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + * Verify that:
>    *
> - * You should have received a copy of the GNU General Public License along
> - * with this program.
> - */
> -/*
> - * Test Description:
> - *   Verify that,

This newline is not needed. We can just have:

"Verify that fchownat() will operate on symbolic links when 
AT_SYMLINK_NOFOLLOW is used".
>    *   The flag of fchownat() is AT_SYMLINK_NOFOLLOW and the pathname would
>    *   not be dereferenced if the pathname is a symbolic link.
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
> +		tst_brk(TBROK | TERRNO,
> +			"link_uid(%d) == set_uid(%d) or link_gid(%d) == "
> +			"set_gid(%d)", l_buf.st_uid, set_uid, l_buf.st_gid,
> +			set_gid);
>   	}
TERRNO is not needed.
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
> +	TST_EXP_PASS_SILENT(fchownat(AT_FDCWD, TESTFILE_LINK, set_uid, set_gid,
> +				     AT_SYMLINK_NOFOLLOW));
No need to use SILENT version, since we are testing fchownat().
>   
> -	SAFE_LSTAT(cleanup, TESTFILE_LINK, &l_buf);
> +	SAFE_STAT(TESTFILE_LINK, &c_buf);
> +	SAFE_LSTAT(TESTFILE_LINK, &l_buf);
>   
>   	if (c_buf.st_uid != set_uid && l_buf.st_uid == set_uid &&
>   	    c_buf.st_gid != set_gid && l_buf.st_gid == set_gid) {
> -		tst_resm(TPASS, "fchownat() test AT_SYMLINK_NOFOLLOW success");
> +		tst_res(TPASS, "fchownat() test AT_SYMLINK_NOFOLLOW success");

Here we can use TST_EXP_EXPR() macro here:

TST_EXP_EXPR(c_buf.st_uid != set_uid && l_buf.st_uid == set_uid, "%s", 
"fchownat() correctly operated on symlink user ID");
TST_EXP_EXPR(c_buf.st_gid != set_gid && l_buf.st_gid == set_gid, "%s", 
"fchownat() correctly operated on symlink group ID");

>   	} else {
> -		tst_resm(TFAIL,
> -			 "fchownat() test AT_SYMLINK_NOFOLLOW fail with uid=%d "
> -			 "link_uid=%d set_uid=%d | gid=%d link_gid=%d "
> -			 "set_gid=%d", c_buf.st_uid, l_buf.st_uid, set_uid,
> -			 c_buf.st_gid, l_buf.st_gid, set_gid);
> +		tst_res(TFAIL,
> +			"fchownat() test AT_SYMLINK_NOFOLLOW fail with uid=%d "
> +			"link_uid=%d set_uid=%d | gid=%d link_gid=%d set_gid=%d",
> +			c_buf.st_uid, l_buf.st_uid, set_uid,
> +			c_buf.st_gid, l_buf.st_gid, set_gid);
>   	}
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
Kind regards,
Andrea Cervesato

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
