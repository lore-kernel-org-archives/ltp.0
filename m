Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1554FC48BC3
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708530608; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=1V967RqwcvGf76Tvx9gVDXT44U9smm6/Pbhr5u0d6vA=;
 b=fwfMBhx5QkSiuIJ/XqWIDeiV9gXka/oXop8/XYhFT1g5tAdiQVxPyG+qrZWEwKLbRGCNR
 l12WtIDIPAcfij9bsCowaRviHBMnOGIoFB+kiWcTUF5G6BypTtGfFlO0dNNNAgXYP5Lr0Ef
 sHZpZkRskYCnCV+Rbt0zBn3u/yhT2yA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 704DA3D086C
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 16:50:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CF8F3D0353
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 16:49:46 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 444A12001D6
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 16:49:46 +0100 (CET)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a3eafbcb1c5so384445666b.0
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 07:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708530585; x=1709135385; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VEzoRlUATnltm1F5n9U2b/u6wYd5KFWi2q3ie44Dljs=;
 b=TOvMd5ZbR/FwZbobEHAnjDkgu6T3OlV/KSUUQwKmn8tkWFhkDzZfpgwWLMi3ABlFA4
 HNXY3nJ5/LjHPw6YxlsmXcA1Sq9keFIjUadMZsipxpTfFN+KhMRvK0ltaPUxpTy84j58
 2X4WEGAPboxIeWRfIuXY6HvwDX10+MBwxVLHkxtubgN089qkXMdA27Fp7nWRQE40+IB/
 YCUR/HWrqaQBXsueDqeDOARI1TwD0sHnzo5X7aJgCr6XIyAjj8zDz6cAGNQV9kQC8yRx
 /H9sbC6xoktD1YaGje0oTUusq+ycRRTJh8iWthdH6EWFa9s+WtxzZ69UZ87Jh/V+W5Xh
 4iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708530585; x=1709135385;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VEzoRlUATnltm1F5n9U2b/u6wYd5KFWi2q3ie44Dljs=;
 b=nGx9Ebn6QtGehnywRoWnZ8XmeTPvwNRxib9M7nYH1PtSov3Ma9bSFZbju21XIRIhVh
 kkDwW+ZYKQh9sjw8DDpsgKpvrQfTFh8CUwVONj8K8ofieKrd5kdJE2/ICskCVXtMbuV7
 75nO2CTqLa8rD40vLsSYcsdWV2qGDWdNbY7IuKbqh0geQBkN8e/egKMZ4CLFO/1riKEI
 2VoQIngJWv8KMHRDVnQFPgEzM/gIr9pRhb5w82xWHr+S03YBQ6thF6K8n9Dicxt6eurX
 Ida23+bJQQ2+wT02M/TV86wJs/+aocUAAoidHFTTMU1e/OXfSJ8AYkFPojkN54g8AUCz
 uxlA==
X-Gm-Message-State: AOJu0YxOjYqlgcybXTh/rsulL9K5QE8Qgfy/UsndD5cknvn7lzqOggEu
 yRKF/WH8vPVJyk03qK++W2Bp0X/NFNSpoqTqs2URcbBBBvusMO96CEmuGCGES+cw+HBzfHq9arg
 S05s=
X-Google-Smtp-Source: AGHT+IEmkW1ijaqjZWTyCrf42uvUqGhCuu0ZbSDIERJC2gda8Gp8CcchAxCQmQpxBfZQaYFtg6Unzg==
X-Received: by 2002:a17:906:3a94:b0:a3e:b754:2d71 with SMTP id
 y20-20020a1709063a9400b00a3eb7542d71mr6776941ejd.76.1708530585225; 
 Wed, 21 Feb 2024 07:49:45 -0800 (PST)
Received: from [10.232.133.81] ([88.128.88.5])
 by smtp.gmail.com with ESMTPSA id
 hu13-20020a170907a08d00b00a3dfafb264fsm5044537ejc.7.2024.02.21.07.49.44
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 07:49:44 -0800 (PST)
Message-ID: <d4d48a31-2ca6-4a30-990b-dc1cc9f8a2ab@suse.com>
Date: Wed, 21 Feb 2024 16:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <20231222094455.3878-1-xuyang2018.jy@fujitsu.com>
 <20231222094455.3878-2-xuyang2018.jy@fujitsu.com>
In-Reply-To: <20231222094455.3878-2-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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

This test is still missing the Cyril review request.

Regards,
Andrea

On 12/22/23 10:44, Yang Xu wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   .../kernel/syscalls/fchownat/fchownat02.c     | 139 ++++++------------
>   1 file changed, 42 insertions(+), 97 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fchownat/fchownat02.c b/testcases/kernel/syscalls/fchownat/fchownat02.c
> index 6dd1e024e..dcd320d6e 100644
> --- a/testcases/kernel/syscalls/fchownat/fchownat02.c
> +++ b/testcases/kernel/syscalls/fchownat/fchownat02.c
> @@ -1,135 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2014 Fujitsu Ltd.
> + * Copyright (c) Linux Test Project, 2014-2023
>    * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
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
> - */
> -/*
> - * Test Description:
> - *   Verify that,
> - *   The flag of fchownat() is AT_SYMLINK_NOFOLLOW and the pathname would
> - *   not be dereferenced if the pathname is a symbolic link.
>    */
>   
> -#define _GNU_SOURCE
> +/*\
> + * [Description]
> + *
> + * Verify that,
> + * The flag of fchownat() is AT_SYMLINK_NOFOLLOW and the pathname would
> + * not be dereferenced if the pathname is a symbolic link.
> + */
>   
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <unistd.h>
>   #include <stdlib.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/fcntl.h"
> +#include "tst_test.h"
>   
> -#define TESTFILE	"testfile"
> -#define TESTFILE_LINK	"testfile_link"
> -
> -char *TCID = "fchownat02";
> -int TST_TOTAL = 1;
> +#define TESTFILE        "testfile"
> +#define TESTFILE_LINK   "testfile_link"
>   
>   static int dir_fd;
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
> +static struct stat c_buf, l_buf;
>   
>   static void setup(void)
>   {
> -	struct stat c_buf, l_buf;
> -
> -	tst_require_root();
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	dir_fd = SAFE_OPEN(cleanup, "./", O_DIRECTORY);
> +	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
>   
> -	SAFE_TOUCH(cleanup, TESTFILE, 0600, NULL);
> +	SAFE_TOUCH(TESTFILE, 0600, NULL);
>   
> -	SAFE_SYMLINK(cleanup, TESTFILE, TESTFILE_LINK);
> +	SAFE_SYMLINK(TESTFILE, TESTFILE_LINK);
>   
> -	SAFE_STAT(cleanup, TESTFILE_LINK, &c_buf);
> +	SAFE_STAT(TESTFILE_LINK, &c_buf);
>   
> -	SAFE_LSTAT(cleanup, TESTFILE_LINK, &l_buf);
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
>   static void fchownat_verify(void)
>   {
> -	TEST(fchownat(dir_fd, TESTFILE_LINK, set_uid, set_gid,
> -		      AT_SYMLINK_NOFOLLOW));
> +	TST_EXP_PASS_SILENT(fchownat(dir_fd, TESTFILE_LINK, set_uid, set_gid,
> +			    AT_SYMLINK_NOFOLLOW));
>   
> -	if (TEST_RETURN != 0) {
> -		tst_resm(TFAIL | TTERRNO, "fchownat() failed, errno=%d : %s",
> -			 TEST_ERRNO, strerror(TEST_ERRNO));
> -	} else {
> -		test_verify();
> -	}
> -}
> +	SAFE_STAT(TESTFILE_LINK, &c_buf);
>   
> -static void test_verify(void)
> -{
> -	struct stat c_buf, l_buf;
> -
> -	SAFE_STAT(cleanup, TESTFILE_LINK, &c_buf);
> -
> -	SAFE_LSTAT(cleanup, TESTFILE_LINK, &l_buf);
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
> +			"link_uid=%d set_uid=%d | gid=%d link_gid=%d "
> +			"set_gid=%d", c_buf.st_uid, l_buf.st_uid, set_uid,
> +			c_buf.st_gid, l_buf.st_gid, set_gid);
>   	}
>   }
>   
>   static void cleanup(void)
>   {
> -	tst_rmdir();
> +	if (dir_fd > -1)
> +		SAFE_CLOSE(dir_fd);
>   }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = fchownat_verify,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +};



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
