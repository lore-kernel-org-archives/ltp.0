Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EF9C02192
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 09:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738576723; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=eShh1mkmBySmH1fLExns46oAm05i/+Iog9Nnmsop4V4=;
 b=VY9NjxfA4A8E77c9D4gNUkSuUXAK7D9wf+clNuvIF5I7J29dAzq9yYZqvbgAj+ByM80lx
 WI8e09AqkTZXEfmYm/9NaMSnOkOQ95b8oyUMb5+Ry8gS518Te1CfRV+oPJRGzXx3HH10dkL
 BjMPSFwF/4T2kG3hCUSuUFho0BQ4AvM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AB083C8E9E
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 10:58:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 201F53C8E9C
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 10:58:07 +0100 (CET)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 17A79102DC4C
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 10:58:06 +0100 (CET)
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so622023166b.0
 for <ltp@lists.linux.it>; Mon, 03 Feb 2025 01:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738576685; x=1739181485; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pP8c15fkdq17EAG0DTwyOKfG8vaxSGilgXzm8EWhq0E=;
 b=aFzsQWMeL6+e6bDPhZBYyOVWriMCSpp7C6lKPhxHoVu53aK12rmdgcB+/KqKOUcMEY
 fcBIESovCH24ztDHT7bQQk25I+ulEd4qVVLfziZc0SkgMm3Jik9O+fcogOX2jPHQNTYL
 A9Sn8N8LqanaZ6dEBC2v7M32qgcj37+Nw/28HM56VAUmiSH688E706EwelDKLWhZO24C
 nm9TogMMpdwDosKDlDX9ChwrPycXcA45mUrq2wP9Xhu3EaH75G3V7YuAKXnCo9R07pge
 hiY1JxWTjg7F39GTQOlEWx6HUGVKBC2fDkw4Q2/lyhX5I+umMuOzB4SbUGOsZ9F9VKMu
 4O/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738576685; x=1739181485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pP8c15fkdq17EAG0DTwyOKfG8vaxSGilgXzm8EWhq0E=;
 b=krwKgUCrn5/vFxZV+e18DkG+6arppxcDbylzx50f8CiezGsZsLWwmH9ETe12uK0eV2
 H0lBdPt5k+p94KZCc92dMR2QPDKfIZuVnu1NfWx8suh7RPLU8/bvGKtabW2h5msZAHS3
 ol6zLSDOgcJ5GfitD6XlH0HMS2IZA9VuAGD7FVphcREYHOS62HRywUuEFmi0EGDoV4Yy
 emv5sSL9eso6KGSnvHp5Go80NplnVUsDtTexkiJIf9/guqexkAVixJ8J9MAWMiAuKHVv
 D2mC2dI/fgGjFbXRRFzkyu6iCAdPUHUZ+UjQfwTrvCVdQAJq+RP+b/s17GrNaWCdPefJ
 mNqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHxGsFepXYhdO8Du8SIcxsh3gFtp4GUteTlctPTMSxfdzOzdHFE66NDF8X8ytKvwzCZRw=@lists.linux.it
X-Gm-Message-State: AOJu0Yx5CxJg8DeLh5Hkm0ZaKKl4WRPsj8ZHIHWLlh0L3lTaOvtTuOTL
 d/hfYccCEcq7vnF6X0XRzdQdtWCokCOHyOb2Q8oYO4o0igoCtrgzEgXqU/BhWd4=
X-Gm-Gg: ASbGncuJXq+bWFwjjh0bFPcgrlVZVqvC1sbyDGNxwi9p857HqBPkdVS6N86tohM6jSI
 imy7GVeNZkLTFfF63TOftErdaeQX4m18QdwVOBJB+cjF1gqVdmSTUbO0mxBH3+GSDiqDE689kyI
 y/oNqAwJyUVS1+OBSfwpt8CzZEzLG76OSZCsNKz+ePx+OnKgpDyWPk7a9nVvPrHyPb9INB76zqY
 6AKfOkvvrdIAxu2QRwrOrePtkdxYD0/ReCub1PpixmqCr/9JpFgdAJmJDNWHcbEzQchjUSaVwkv
 254KgnUTPgL6t0ia+dMND0rbmg==
X-Google-Smtp-Source: AGHT+IEIvGh8nwaTon/5XiqGirHeOCKMtX3fhpuxmccTnyq84BF6LvX/x7VnT14GbMF6GJWcKzv3qQ==
X-Received: by 2002:a17:907:c1f:b0:ab2:f5cb:c039 with SMTP id
 a640c23a62f3a-ab6cfe174edmr2098612266b.54.1738576685335; 
 Mon, 03 Feb 2025 01:58:05 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a326e6sm721450366b.157.2025.02.03.01.58.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 01:58:05 -0800 (PST)
Message-ID: <05d0cc8e-25ac-4709-8ecc-dcf8c1cd9be3@suse.com>
Date: Mon, 3 Feb 2025 10:58:04 +0100
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

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
>   
> -	SAFE_LSTAT(cleanup, TESTFILE_LINK, &l_buf);
> +	SAFE_STAT(TESTFILE_LINK, &c_buf);
> +	SAFE_LSTAT(TESTFILE_LINK, &l_buf);
>   
>   	if (c_buf.st_uid != set_uid && l_buf.st_uid == set_uid &&
>   	    c_buf.st_gid != set_gid && l_buf.st_gid == set_gid) {
> -		tst_resm(TPASS, "fchownat() test AT_SYMLINK_NOFOLLOW success");
> +		tst_res(TPASS, "fchownat() test AT_SYMLINK_NOFOLLOW success");
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

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
