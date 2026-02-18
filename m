Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE33E9A02C
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771420938; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=2So4fr6akFRYe1mBlpOn1e/KshPKY0gScz4NGqVvd0M=;
 b=YF+hki6ZzxmaFDaUK7WXhqqpZ03n+fUecReTc13SzalwmxpU5vPqv5PmwxcCjtm8TRQsZ
 +oWHpG33trfBMD3Kmy7nC9hj0I3lEJpCd9ciM5cp+gmIzzFhP7EFTl9OwZ/kOVUThmB9NV1
 bzEPa1EXEhDA9y/Z2/MXRCvkjb3O0fw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 549C23D06ED
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 14:22:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF0193CC7E6
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 14:21:55 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0076220097A
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 14:21:54 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4837584120eso35817645e9.1
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 05:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771420914; x=1772025714; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oA/Losg8PMZM3ExAjRHte+fqhiO2L8BUh11K+KjZdDA=;
 b=VCvurVpTkHTYUp5gdnh2Vrb4MrHth6XFS3lUv2okW+MaK627lcvqZDg3byhN/XM6b/
 jEwkAz+0oO/neP1bpFLBsJTYQdPU7QCs7+DBFF/uMqof3iwi4afTxEoUDkyF57GPJUiF
 Kbt8qYzoKkdGVMNrRczxpqynMphbttrRkGDBofQ8cYRc4TQDSHCRx+8XT0rj0Gqqw3H4
 mPAyBfiybRbw5av/CQHjxiz6pDf9VM3SWrkIJTKsgu8H9kk2jjMnwpd3tLF4dYN/BXHj
 0Z6a9ZUATAEaZIzQqbCDtEEEljZu1MF2Q7npEhOsYn7DIRUvvGsjVxI3XzKzB8ZlMQHj
 rbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771420914; x=1772025714;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oA/Losg8PMZM3ExAjRHte+fqhiO2L8BUh11K+KjZdDA=;
 b=C+D4n+mK7jtpSnYb+6nAbmvrI/YtgW5XFUnj14TN1qqWCRbapQ/liqRvbsNz0on/rk
 44lhR5fySG9ahy76mvK68b0h9h6Ba9nQvxep23UjR0SAbThabUUNn1sbUA5mBhZKcFN9
 PR6WdUAOoPnTohe2J2iSrs9KOmqHseZOQVR8dlobMiDw0sHuN8rRA5nj0VrEnjDmcgst
 RA5etAGEZJ/iBppwuVo+UiSGRPVJwpnt9TGLT6Lse15vDRxuemqeqkAtQd+dquFbrNhG
 UUYXVcebgMlj2TftutYSzYj+q+R+2NXtYUv9wmNQgH11+Jjkq79mIGbddFZQ/BUfwMOj
 UQYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy0hcc00VCLy3xYpQTi+lG5Pm1MedLvJyaDGGjXuMQn+EgtkteyfZWl9skR7gc1Bk5DY4=@lists.linux.it
X-Gm-Message-State: AOJu0Ywps684FYhp85OZ1uNbPB7cFTm1s1IT4rb3uqMs1z51KYjXhLb8
 G77E9iuUmdyj7lc0WKI5EfyOWULwYfYy5Ls95fCinE+qseWd/6I5n6bwx3W7S/vgkf0=
X-Gm-Gg: AZuq6aKcXTyn4hxe4FEGJlz64FxdzOkmu4ZpfBK13/CyVc7Jd4bnx32m9nQmUoivBrd
 EAQ8R2WncSLcbPchKq2wNG8hxSfaeF8NJZ6huJeTVWci+tSD/CHP1gfs5zPNeY4sFxDYoqXNe4m
 pzz67J60RI0528sMlzVnBtti33A01ZB6RmVgnx3PsQPuxiAPT1AfcFOENc6spxE5tyilJ0vSxNy
 wG7krkR55xnR4etT6EddGibIslW6lehKGW9DZ4YNfalkx/wAAy3cB9WptQITH99goSGP862IEgM
 2zETFXhjfF6mYZskHbzVHfrjPl2d9a9MEHmHJhOCVh7eMtE1T0CkOWrVa04XZm3ZDcKztq7u3dK
 QQdxTR0KcpBpSIaBe4v/cLv1edEZPgPC3wM4z5NgGrv/acGk+90fp43qWyorQtdFq45UDQYXUSL
 6RexTavuuJIvRdmU40zDMShd0oTxbXiJcmTZdrCOTL1tPMPc1OyXHr/YhCvTeEUSunNKU3+DfmQ
 e9xXfLYt9qaGR07Z+Q=
X-Received: by 2002:a05:600c:358c:b0:480:426e:9d38 with SMTP id
 5b1f17b1804b1-48379be6056mr236860515e9.27.1771420914300; 
 Wed, 18 Feb 2026 05:21:54 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dcfafcdsm902756385e9.9.2026.02.18.05.21.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 05:21:53 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 18 Feb 2026 14:21:53 +0100
Message-Id: <DGI4B1B5F1L9.16IITENATKJVZ@suse.com>
To: "Wei Gao" <wegao@suse.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20250319142310.30036-1-wegao@suse.com>
 <20250723154610.3860563-1-wegao@suse.com>
In-Reply-To: <20250723154610.3860563-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] open16: allow restricted O_CREAT of FIFOs and
 regular files
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Wed Jul 23, 2025 at 5:46 PM CEST, Wei Gao via ltp wrote:
> This commit adds test cases to verify the security restrictions for opening
> FIFOs and regular files in world-writable sticky directories.
>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  runtest/syscalls                          |   1 +
>  testcases/kernel/syscalls/open/.gitignore |   1 +
>  testcases/kernel/syscalls/open/open16.c   | 124 ++++++++++++++++++++++
>  3 files changed, 126 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/open/open16.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 3531c2a3c..0de9bfaef 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -984,6 +984,7 @@ open12 open12
>  open13 open13
>  open14 open14
>  open15 open15
> +open16 open16
>  
>  openat01 openat01
>  openat02 openat02
> diff --git a/testcases/kernel/syscalls/open/.gitignore b/testcases/kernel/syscalls/open/.gitignore
> index af5997572..d2cacc02e 100644
> --- a/testcases/kernel/syscalls/open/.gitignore
> +++ b/testcases/kernel/syscalls/open/.gitignore
> @@ -13,3 +13,4 @@
>  /open13
>  /open14
>  /open15
> +/open16
> diff --git a/testcases/kernel/syscalls/open/open16.c b/testcases/kernel/syscalls/open/open16.c
> new file mode 100644
> index 000000000..6e01dde26
> --- /dev/null
> +++ b/testcases/kernel/syscalls/open/open16.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * Verify disallows open of FIFOs or regular files not owned by the user in world
> + * writable sticky directories
> + */
> +
> +#include <pwd.h>
> +#include <stdlib.h>
> +#include "tst_test.h"
> +#include "tst_safe_file_at.h"
> +
> +#define FILENAME  "setuid04_testfile"

Never used.

> +#define DIR "ltp_tmp_check1"
> +#define TEST_FILE "test_file_1"
> +#define TEST_FIFO "test_fifo_1"
> +#define LTP_USR_UID1 1000
> +#define LTP_USR_UID2 1001

If target is to have a UID that doesn't belong to the current user,
we can just have:

  pw = SAFE_GETPWNAM("nobody");

and use the provided UID.

> +#define PROTECTED_REGULAR "/proc/sys/fs/protected_regular"
> +#define PROTECTED_FIFOS "/proc/sys/fs/protected_fifos"
> +#define TEST_FIFO_PATH DIR "/" TEST_FIFO
> +
> +static int dir_fd;

Not initialized to -1.

> +
> +static void run(void)
> +{
> +	SAFE_CHMOD(DIR, 0777 | S_ISVTX);
> +	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "0");
> +	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "0");
> +
> +	if (!SAFE_FORK()) {
> +		SAFE_SETUID(LTP_USR_UID1);
> +
> +		int fd = SAFE_OPENAT(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777);
> +
> +		SAFE_CLOSE(fd);
> +
> +		SAFE_MKFIFO(TEST_FIFO_PATH, 0777);
> +
> +		exit(0);
> +	}
> +
> +	tst_reap_children();
> +
> +	if (!SAFE_FORK()) {
> +		SAFE_SETUID(LTP_USR_UID2);
> +
> +		int fd = TST_EXP_FD(openat(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777));
> +
> +		if (TST_PASS)
> +			SAFE_CLOSE(fd);
> +
> +		fd = TST_EXP_FD(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777));
> +
> +		if (TST_PASS)
> +			SAFE_CLOSE(fd);
> +
> +		exit(0);
> +	}
> +
> +	tst_reap_children();
> +
> +	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "1");
> +	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "1");
> +
> +	if (!SAFE_FORK()) {
> +		SAFE_SETUID(LTP_USR_UID2);
> +		TST_EXP_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777), EACCES);
> +		TST_EXP_FAIL(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777), EACCES);
> +
> +		exit(0);
> +	}
> +
> +	tst_reap_children();
> +
> +	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "2");
> +	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "2");
> +	SAFE_CHMOD(DIR, 0020 | S_ISVTX);
> +
> +	if (!SAFE_FORK()) {
> +		SAFE_SETUID(LTP_USR_UID2);
> +		TST_EXP_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777), EACCES);
> +		TST_EXP_FAIL(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777), EACCES);
> +
> +		exit(0);
> +	}
> +
> +	tst_reap_children();
> +	SAFE_UNLINK(TEST_FIFO_PATH);
> +}
> +
> +static void setup(void)
> +{
> +	umask(0);
> +	SAFE_MKDIR(DIR, 0777 | S_ISVTX);
> +	dir_fd = SAFE_OPEN(DIR, O_DIRECTORY);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (dir_fd != -1)
> +		SAFE_CLOSE(dir_fd);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.test_all = run,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{PROTECTED_REGULAR, NULL, TST_SR_TCONF},
> +		{PROTECTED_FIFOS, NULL, TST_SR_TCONF},
> +		{}
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "30aba6656f61"},
> +		{}
> +	}
> +};


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
