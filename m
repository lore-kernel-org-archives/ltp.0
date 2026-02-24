Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508BDE9B269
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 14:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771942678; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=A4F2mZhVVhcnk0KHu4mTpllFawbhRhA3ArPSs5beMTE=;
 b=I/8TTBIQIBrGOgEYSqIGL9sUrax8I8krS/0iNKcs6z0TavO2yINsIAGI2Fv0MYyvYASZf
 4vlvlKSsNGyPoSpODd5bAVsKklWDy4Kgolka4aHcbRi021u6KrLF4VtMUyHnHeaeR5ka+Bk
 Wfpljb+QTePPYb7dBfy6X8d7IpVmDgE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8AFF3D0FA4
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 15:17:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 326643D0F7E
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 15:17:37 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EC51910009B8
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 15:17:35 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48371119eacso65832725e9.2
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 06:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771942655; x=1772547455; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EmF89mX4VNSEwlgPwm3Lg5ko9OjE5j/4MZNOQpZWkt8=;
 b=FGoaVMHuHQK37/LCaBukcMbcpKoeUYZk6eA8K1tnC4NuPaRKj6r1QrKDGP5NdxYWvn
 Z7YEB0A1PG00FgkNNlkVAlO7lg/HZg9ZCrq5I71172Le+UCTmoQQBMTn8Q3zUJAsRXTR
 LhjjOjpECP8f3wAEsrR6j+A6QN6Hjhu3pLVdtMTb3/DJdVfamac1OitDbtb//lD+OLJF
 9EipJBB2TWbKOpQkSbS8oRYIe0sFhk8Umn7rUUqxw/P6e09YBGGInp/z5LqbPi5I+/PH
 SMbQPAJsOYUvdqsNZqjGwxwzdiqiEyq9Cte30xGxdoeVzq73c0YTrJSX0UTk3JE1moFg
 0J7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771942655; x=1772547455;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EmF89mX4VNSEwlgPwm3Lg5ko9OjE5j/4MZNOQpZWkt8=;
 b=SroyR42HSW1E/2YY8FVlm13Sx0LDiPSQ2fQCaUh0ssNHlBV8VNOdsDuncu1R3SWckE
 M+4hjj4g5g0Qgjf9ArhblCEB6mI7Gn/TLJCRQQ5n/olbRtDEjoazf75L2v+mg0OxLuyV
 qhchel5ZU6J+uIk0+bk7HMbCpIFMOQeN9zB6kjRAV3J1+MDXFukZ+7UYS5HVmEjxB13W
 KcfTNpM/KHYngHTHp8/xurJkF+GqKrXn8Hnz7yL1IDeqDnC6AS1cQ/7sznwwTiUtau6q
 V9cof6lg5R0P0iVw7XAy2nwNnXYilSJ+xVIf9j6jImD2hHV+luWX206VSCrueqHSznvQ
 Yhrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKiIaZ/+WNm9POB0JXLrrM6HQTnoLt+sbrxJO5/Xr/I1CRlT427wdRyYhfzj4xhvDWxFE=@lists.linux.it
X-Gm-Message-State: AOJu0YwTFwte2B1l3eCwuBix+lD4207juaWpteVN/xhatHEPZ0KamWcr
 PNLzOyVvO31azgo59AIJmUpd90WNAwp0yOLes+gx3ZpVwhqIimnRSxSYhw78IP3WdKgLAD2RngR
 B6q2bAwM=
X-Gm-Gg: AZuq6aKac+m2SU+AiCGshqsZ1WAkx8pipCbhnDJbBUhfxrR/Y3XcLnuv5LOWvJ72MB8
 +vNtcTryf3phHUQpA5kL035iiHneZl4D1SXROAV7F7Co+tqaYUfsIaGxSsprUT4OqP0QRQVWGSB
 o//II4YCwB5ob/ygq0snbDo/3XEJxLGklKCMtJfinc/Dl1YfU0tAwrerFwDJPkWCFu52RFy5D6G
 2fojH7Yfmcny82U7jEq/Ahj2CwO4fe6HRm2orWjFSJxGM2MYsWrC2PoL21CuUOplw6cH+GIQ9ky
 gm8iDXenKYoAjkUGrEu/nQgASwPj4pMJgb6/AfTN+Avfju9ff9GlkG6Ezd1Iq1K5q//yPehIPLo
 NmLeo7TP49HyEL3FIl6vE71+4sG5ckebC0op8cVaHkuF21jKtnIkvePL5bWq5T7IlR+9/tPgxYT
 nwjyp4BINHPGJlW2dr8zMkWHkd
X-Received: by 2002:a05:600c:3553:b0:47e:e87b:af8 with SMTP id
 5b1f17b1804b1-483a962e491mr205370195e9.21.1771942655222; 
 Tue, 24 Feb 2026 06:17:35 -0800 (PST)
Received: from localhost ([88.128.90.16]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd702e7bsm2267695e9.5.2026.02.24.06.17.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 06:17:34 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 24 Feb 2026 15:17:34 +0100
Message-Id: <DGN98XP7WAZD.310XXFFOA9X2R@suse.com>
To: "Jinseok Kim" <always.starving0@gmail.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <DGN1LFH0ULK0.3D30H8MFVV9GM@suse.com>
 <20260224100723.42877-1-always.starving0@gmail.com>
 <20260224100723.42877-2-always.starving0@gmail.com>
In-Reply-To: <20260224100723.42877-2-always.starving0@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] fstat: add test for multiple file types
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Let's fix the following issues first.

On Tue Feb 24, 2026 at 11:07 AM CET, Jinseok Kim wrote:
> Following review feedback, create a dedicated fstat test that verifies
> S_ISREG(), S_ISDIR(), S_ISFIFO(), S_ISLNK(), S_ISCHR(), S_ISBLK()
> on different file types.
>
> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---
>  testcases/kernel/syscalls/fstat/fstat04.c | 103 ++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/fstat/fstat04.c
>
> diff --git a/testcases/kernel/syscalls/fstat/fstat04.c b/testcases/kernel/syscalls/fstat/fstat04.c
> new file mode 100644
> index 000000000..6aa9a8e79
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fstat/fstat04.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
> + */
> +/*\
> + * Verify that fstat correctly identifies various file types
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/sysmacros.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <errno.h>

More likely these imports are not stricly needed. Please take a look at
it. Also _GNU_SOURCE is not needed.

> +#include "tst_test.h"
> +
> +#define REG_FILE    "regfile"
> +#define DIR_FILE    "dirfile"
> +#define FIFO_FILE   "fifofile"
> +#define SYMLINK     "symlink"
> +#define CHR_DEV     "chrdev"
> +#define BLK_DEV     "blkdev"
> +
> +static int fd = -1;
> +
> +static struct tcase {
> +    const char *desc;
> +    const char *path;
> +    const char *macro_name;
> +    mode_t exp_type;
> +} tcases[] = {
> +    { "regular file",   REG_FILE,  "S_IFREG", S_IFREG },
> +    { "directory",      DIR_FILE,  "S_IFDIR", S_IFDIR },
> +    { "FIFO (pipe)",    FIFO_FILE, "S_IFIFO", S_IFIFO },
> +    { "symbolic link",  SYMLINK,   "S_IFLNK", S_IFLNK },
> +    { "character dev",  CHR_DEV,   "S_IFCHR", S_IFCHR },
> +    { "block dev",      BLK_DEV,   "S_IFBLK", S_IFBLK },
> +};
> +
> +static void verify_fstat(unsigned int i)
> +{
> +    struct tcase *tc = &tcases[i];
> +    struct stat buf;
> +
> +    int flags = O_RDONLY | O_NONBLOCK;
> +
> +    if (tc->exp_type == S_IFDIR)
> +        flags |= O_DIRECTORY;
> +
> +    fd = SAFE_OPEN(tc->path, flags);
> +
> +    SAFE_FSTAT(fd, &buf);
> +    SAFE_CLOSE(fd);
> +
> +    int is_correct = 0;
> +    switch (tc->exp_type) {
> +    case S_IFREG: is_correct = S_ISREG(buf.st_mode); break;
> +    case S_IFDIR: is_correct = S_ISDIR(buf.st_mode); break;
> +    case S_IFIFO: is_correct = S_ISFIFO(buf.st_mode); break;
> +    case S_IFLNK: is_correct = S_ISLNK(buf.st_mode); break;
> +    case S_IFCHR: is_correct = S_ISCHR(buf.st_mode); break;
> +    case S_IFBLK: is_correct = S_ISBLK(buf.st_mode); break;
> +    }
> +
> +    if (is_correct)
> +        tst_res(TPASS, "%s: %s() macro matches", tc->desc, tc->macro_name);
> +    else
> +        tst_res(TFAIL, "%s: %s() macro does NOT match", tc->desc, tc->macro_name);
> +}
> +
> +static void setup(void)
> +{
> +    fd = SAFE_OPEN(REG_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0644);
> +    SAFE_CLOSE(fd);
> +
> +    SAFE_MKDIR(DIR_FILE, 0755);
> +    SAFE_SYMLINK(REG_FILE, SYMLINK);
> +
> +    SAFE_MKNOD(FIFO_FILE, S_IFIFO | 0777, 0);
> +    SAFE_MKNOD(CHR_DEV, S_IFCHR | 0777, makedev(1, 3));
> +    SAFE_MKNOD(BLK_DEV, S_IFBLK | 0777, makedev(7, 3));
> +}
> +
> +static void cleanup(void)
> +{
> +    SAFE_UNLINK(SYMLINK);
> +    SAFE_UNLINK(REG_FILE);
> +    SAFE_RMDIR(DIR_FILE);
> +
> +    SAFE_UNLINK(FIFO_FILE);
> +    SAFE_UNLINK(CHR_DEV);
> +    SAFE_UNLINK(BLK_DEV);

What if all these files/directories don't exist at cleanup?

> +}
> +
> +static struct tst_test test = {
> +    .tcnt = ARRAY_SIZE(tcases),
> +    .setup = setup,
> +    .cleanup = cleanup,
> +    .test = verify_fstat,
> +    .needs_tmpdir = 1,
> +    .needs_root = 1,
> +};
> --
> 2.43.0

I also get:

fstat04.c:61: TPASS: regular file: S_IFREG() macro matches
fstat04.c:61: TPASS: directory: S_IFDIR() macro matches
fstat04.c:61: TPASS: FIFO (pipe): S_IFIFO() macro matches
fstat04.c:63: TFAIL: symbolic link: S_IFLNK() macro does NOT match
fstat04.c:45: TBROK: open(chrdev,2048,0000) failed: EACCES (13)

Please, also fix the following:

open01.c has 1 checkpatch error:
   - Line 43: Code indent should use tabs where possible

fstat04.c has 9 checkpatch errors and 53 warnings:
   - Lines 28-93: Uses spaces instead of tabs for indentation throughout
   - Lines 58-63: Trailing statements should be on next line in switch cases
   - Line 57: Missing blank line after declarations
   - Line 49: Code indent should use tabs

- Add fstat04 to .gitignore
- Add fstat04 fstat04 to runtest/syscalls

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
