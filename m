Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AFF105A583
	for <ltp@archiver.kernel.org>; Thu, 12 Mar 2026 11:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773314569; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=WLyjhCuPRa+WXHvaXPxgvuCvq5AsuWXZ2DjdfH0hWbE=;
 b=XbwHWE748LrmlGd6Z6w3pRQeNicaEfCHmP6pnkkNHEKcGxYeKTpHIyU/e50TBlHFSLMK1
 bMFKB8H5TdzEEgWuQfg4VXOenspuD7lVVkkmTXww770a2EhxoQATeJe0hINr4/YsQNgEAQ8
 r7XGdelTXVSrCf1MLfa6LfkZ27ifRNw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28BFB3E279E
	for <ltp@archiver.kernel.org>; Thu, 12 Mar 2026 12:22:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33FC93CBF42
 for <ltp@lists.linux.it>; Thu, 12 Mar 2026 12:22:25 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6931D1A00672
 for <ltp@lists.linux.it>; Thu, 12 Mar 2026 12:22:24 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852ff06541so9440055e9.2
 for <ltp@lists.linux.it>; Thu, 12 Mar 2026 04:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773314544; x=1773919344; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=S9TFVBwIfv9bgMM+Z1spW8KhQHNf+mHft8YATnszdM8=;
 b=YX6fnEwU+1ihwvvXL5GvWSqD0Oe4RxKUt3bs1JFtb4r9QonEi+VHEu+XSqkBIBmfqw
 oh/l+qoxX8/g61rifpE7Pm8rpaT0Nqf3LD3aBDtcVMt1br5oF4JyJv0u5G2LSSD0M1UQ
 SPdw/fjdbwGyISqsFpHmPrFSVD2G/+tmF3bLim1xtws9e4Z8nMHHlbrJuTdKSGtlk0ig
 HLWyBm92UhzRCfAap1+gI+AYjzmR8R7npGHh9YWEO47eP3v1iGHqNWeN2bYL2M7Pw8Z4
 I7elCqJwvWikdWtBpX4FWiLlBShGU/YInHUJiWLW4k/0FGAq76xQvWDCev9oKiXIpNO3
 IitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773314544; x=1773919344;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S9TFVBwIfv9bgMM+Z1spW8KhQHNf+mHft8YATnszdM8=;
 b=XTsyDDRcCS3Ge6U90EPqr4Y5T0oKO6fj1qIMKKMKuFUWiignLDMz3lo2dkNcgt+YW8
 TQMt0yiSwoig6SchXidK8EpwARls3EukYFRpaEV6/ZH021c3wKrJ2ZXPZVRcKu5lP/YT
 /0NaqK0qhfi/wLYf5Ntfxr1YJTcekXmhk1P4eZZSjNtbTkQYZDP2P17em6t9mto+DmTc
 wX2RaPQ8wVuUO93GsPhbcunzpwGnNC0d2HQ0vSr7trFm07KJdYdCM6N0Qjis+NIFfqT9
 I1pGT7ZLIcmixIsF7shtYZMBZGrBxz2WZcXocAb6Qr9QdueOfhYr66+aQl/4oDAwI7G+
 brHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvrF/OOOCBNFRxfP3dE9H5K6KJiW1/Tu+JVxbGAXOaEj7+/4eY18wGaPkVu9YeSt+5Wds=@lists.linux.it
X-Gm-Message-State: AOJu0Yyf3K3HESov3N9dv26a6ebC6s532oiPNQzG6dOknAlWA2M8GPT+
 ju9B2An2mBoxJPphMLUMeV6wikvifknkiIY08LtHr4ebFF4dgFHq87csQs0ON1PYiw8=
X-Gm-Gg: ATEYQzxk2cRYrP5l2YpqLwFrb7rKXjDqeFAbCMYFkmt0niWpam/dT46DDxP3+cLsYAN
 eeYph5Od/zw7EvRPunqyMkvxmcamCIWdjbqgzxMzG1VQ2y2EdRc4gUNpK6tJL4b7ZcWNmXb2mBA
 srlrtv7L6hQugawZKz8csjAnZzquHHm3asSGedkbEZYKCMw3owBPyzz+VC0Dzhmu8jXPKTz3mkS
 qo5Z6Fdrc0sHcmm5jWg4oqnEQN1ZGZOYHoMojDbVUVBHbaBvr6f5A5kT8ce1gYT9xoH4FXkUdwV
 Kuc7pe8HoSCl3nLSauA2nUxtnspP/64RYH7vej8ZY7DBMpDipQv7v0oMAs5C0q4arSLBymmjfX4
 jAtXfz7i/Jlc3cgoqtHKeHqerijvR3CSzOl7mYI/yJ39oW3W7us8AWcikZsmWvjcsjn1uscrMsx
 EiW356qOW9n26Ph04swxxsm+pm/aXJOtOh65M/Zokc
X-Received: by 2002:a05:600c:1d0e:b0:485:3f1c:d887 with SMTP id
 5b1f17b1804b1-4854b10d0d6mr104199425e9.26.1773314543640; 
 Thu, 12 Mar 2026 04:22:23 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.60])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b6070acsm104899565e9.8.2026.03.12.04.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:22:23 -0700 (PDT)
Message-ID: <69b2a1ef.050a0220.31a4ce.a1ea@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>, ltp@lists.linux.it
In-Reply-To: <20260303133243.66845-2-always.starving0@gmail.com>
Date: Thu, 12 Mar 2026 11:22:22 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] fstat: add test for multiple file types
 using fstat
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

> Following review feedback, create a dedicated fstat test that verifies
> S_ISREG(), S_ISDIR(), S_ISFIFO(), S_ISLNK(), S_ISCHR(), S_ISBLK()
> on different file types.
> 
> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---
>  runtest/syscalls                           |   2 +
>  testcases/kernel/syscalls/fstat/.gitignore |   2 +
>  testcases/kernel/syscalls/fstat/fstat04.c  | 119 +++++++++++++++++++++
>  3 files changed, 123 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/fstat/fstat04.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 05bb3ceb1..5b34e6bdc 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -435,6 +435,8 @@ fstat02 fstat02
>  fstat02_64 fstat02_64
>  fstat03 fstat03
>  fstat03_64 fstat03_64
> +fstat04 fstat04
> +fstat04_64 fstat04_64
> 
>  #fstatat64/newfstatat test cases
>  fstatat01 fstatat01
> diff --git a/testcases/kernel/syscalls/fstat/.gitignore b/testcases/kernel/syscalls/fstat/.gitignore
> index 9b1089438..a1f538f7e 100644
> --- a/testcases/kernel/syscalls/fstat/.gitignore
> +++ b/testcases/kernel/syscalls/fstat/.gitignore
> @@ -2,3 +2,5 @@
>  /fstat02_64
>  /fstat03
>  /fstat03_64
> +/fstat04
> +/fstat04_64
> diff --git a/testcases/kernel/syscalls/fstat/fstat04.c b/testcases/kernel/syscalls/fstat/fstat04.c
> new file mode 100644
> index 000000000..a7f2302f6
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fstat/fstat04.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
> + */
> +/*\
> + * Verify that fstat correctly identifies various file types
> + */
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/sysmacros.h>
> +#include "tst_test.h"
> +
> +#define REG_FILE    "regfile"
> +#define DIR_FILE    "dirfile"
> +#define FIFO_FILE   "fifofile"
> +#define SYMLINK     "symlink"
> +#define CHR_DEV     "chrdev"
> +#define BLK_DEV     "blkdev"
> +
> +static struct tcase {
> +	const char *desc;
> +	const char *path;
> +	mode_t exp_type;
> +} tcases[] = {
> +	{ "S_IFREG",	REG_FILE,	S_IFREG },
> +	{ "S_IFDIR",	DIR_FILE,	S_IFDIR },
> +	{ "S_IFIFO",	FIFO_FILE,	S_IFIFO },
> +	{ "S_IFLNK",	SYMLINK,	S_IFLNK },
> +	{ "S_IFCHR",	CHR_DEV,	S_IFCHR },
> +	{ "S_IFBLK",	BLK_DEV,	S_IFBLK },
> +};
> +
> +static void verify_fstat(unsigned int i)
> +{
> +	struct tcase *tc = &tcases[i];
> +	struct stat buf;
> +
> +	int flags = O_RDONLY | O_NONBLOCK;
> +
> +	if (tc->exp_type == S_IFDIR)
> +		flags |= O_DIRECTORY;
> +
> +	int fd = open(tc->path, flags);
> +
> +	if (fd < 0) {
> +		tst_res(TCONF | TERRNO, "cannot open %s, skipping", tc->desc);
> +		return;
> +	}
> +
> +	SAFE_FSTAT(fd, &buf);
> +	SAFE_CLOSE(fd);
> +
> +	switch (tc->exp_type) {
> +	case S_IFREG:
> +		TST_EXP_EXPR(S_ISREG(buf.st_mode), "%s macro matches", tc->desc);
> +		break;
> +	case S_IFDIR:
> +		TST_EXP_EXPR(S_ISDIR(buf.st_mode), "%s macro matches", tc->desc);
> +		break;
> +	case S_IFIFO:
> +		TST_EXP_EXPR(S_ISFIFO(buf.st_mode), "%s macro matches", tc->desc);
> +		break;
> +	case S_IFLNK:
> +		tst_res(TCONF, "Symbolic Link not available in this environment");

What's the point of always sending TCONF?

> +		break;
> +	case S_IFCHR:
> +		TST_EXP_EXPR(S_ISCHR(buf.st_mode), "%s macro matches", tc->desc);
> +		break;
> +	case S_IFBLK:
> +		if (S_ISBLK(buf.st_mode))
> +			tst_res(TPASS, "%s macro matches", tc->desc);
> +		else
> +			tst_res(TCONF, "Block device not available in this environment");

And here as well we can use TST_EXP_EXPR()

> +		break;
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_TOUCH(REG_FILE, 0644, NULL);
> +
> +	SAFE_MKDIR(DIR_FILE, 0755);
> +	SAFE_SYMLINK(REG_FILE, SYMLINK);
> +
> +	SAFE_MKNOD(FIFO_FILE, S_IFIFO | 0777, 0);
> +	SAFE_MKNOD(CHR_DEV, S_IFCHR | 0777, makedev(1, 3));
> +	SAFE_MKNOD(BLK_DEV, S_IFBLK | 0777, makedev(7, 3));
> +}
> +
> +static void cleanup(void)
> +{
> +	if (!access(SYMLINK, F_OK))
> +		SAFE_UNLINK(SYMLINK);
> +
> +	if (!access(REG_FILE, F_OK))
> +		SAFE_UNLINK(REG_FILE);
> +
> +	if (!access(DIR_FILE,  F_OK))
> +		SAFE_RMDIR(DIR_FILE);
> +
> +	if (!access(FIFO_FILE, F_OK))
> +		SAFE_UNLINK(FIFO_FILE);
> +
> +	if (!access(CHR_DEV, F_OK))
> +		SAFE_UNLINK(CHR_DEV);
> +
> +	if (!access(BLK_DEV, F_OK))
> +		SAFE_UNLINK(BLK_DEV);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test = verify_fstat,
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +};
> +
> --
> 2.43.0

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
