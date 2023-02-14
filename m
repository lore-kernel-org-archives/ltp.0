Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274E8C05027
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 11:17:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B5FD3CC5A8
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 12:17:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B60613CBF50
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 12:17:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 75D581400BC4
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 12:17:33 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id ABE1B211C5;
 Tue, 14 Feb 2023 11:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676373452;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K07TKZR6mbdIbHuabOYs/c/uSEscpFOX5meICslRjR8=;
 b=QVfeEye1mnYnfdS4J2YavQdFTtzLMYMuH5sqrwSc8Uf5Api0SHpLoUWlrAty/z4iv2C539
 U/Vu/dvQfaN7ESXE8njuTGg0AMVgSoe4KOVcm4ryStcw4qpnKkJeLA0+PQTe6KyuXOlJ2c
 u7h8hBZPBbCguCFT0ricTt3RHkoGIpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676373452;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K07TKZR6mbdIbHuabOYs/c/uSEscpFOX5meICslRjR8=;
 b=+0WTEqqM/IRFtSDAigMKZW8xJ9QLE6uUsMk1qMwPUJlAxC92sW/I5cdP9X2w424ix0wWfh
 1xgl6N5OP9yGhxAQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7AA682C141;
 Tue, 14 Feb 2023 11:17:32 +0000 (UTC)
References: <20230209131902.12260-1-wegao@suse.com>
 <20230213010924.12352-1-wegao@suse.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Tue, 14 Feb 2023 11:05:24 +0000
Organization: Linux Private Site
In-reply-to: <20230213010924.12352-1-wegao@suse.com>
Message-ID: <87a61go5ro.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] fsconfig03: New test CVE-2022-0185
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Wei Gao via ltp <ltp@lists.linux.it> writes:

> There are reproducers available for CVE-2022-0185
> https://www.openwall.com/lists/oss-security/2022/01/25/14
>
> Also with links or even a zip file for an exploit
> https://github.com/Crusaders-of-Rust/CVE-2022-0185
>
> The exploits are kind of complicated as they try to be complete,
> but the exploitation vector is the fsconfig() syscall,
> this case used for add some coverage to that to detect it.

This looks like a very good test. IMO we have the most success with
reproducers, but they are hard to write sometimes.

Please state on which kernel(s) you reproduced the bug and whether you
think the test will reliably reproduce the bug.

From my 10 minutes research it looks like a reliable buffer overflow,
but it's always hard to be certain without being very thorough.

>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  runtest/cve                                   |  2 +
>  runtest/syscalls                              |  1 +
>  testcases/kernel/syscalls/fsconfig/.gitignore |  1 +
>  .../kernel/syscalls/fsconfig/fsconfig03.c     | 89 +++++++++++++++++++
>  4 files changed, 93 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig03.c
>
> diff --git a/runtest/cve b/runtest/cve
> index 1ba63c2a7..7da3ff853 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -77,3 +77,5 @@ cve-2022-2590 dirtyc0w_shmem
>  # Tests below may cause kernel memory leak
>  cve-2020-25704 perf_event_open03
>  cve-2022-4378 cve-2022-4378
> +# Tests below may cause kernel crash
> +cve-2022-0185 fsconfig03
> diff --git a/runtest/syscalls b/runtest/syscalls
> index ae37a1192..b4cde8071 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -383,6 +383,7 @@ fremovexattr02 fremovexattr02
>  
>  fsconfig01 fsconfig01
>  fsconfig02 fsconfig02
> +fsconfig03 fsconfig03
>  
>  fsmount01 fsmount01
>  fsmount02 fsmount02
> diff --git a/testcases/kernel/syscalls/fsconfig/.gitignore b/testcases/kernel/syscalls/fsconfig/.gitignore
> index 2bc54b827..cfedae5f7 100644
> --- a/testcases/kernel/syscalls/fsconfig/.gitignore
> +++ b/testcases/kernel/syscalls/fsconfig/.gitignore
> @@ -1,2 +1,3 @@
>  /fsconfig01
>  /fsconfig02
> +/fsconfig03
> diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> new file mode 100644
> index 000000000..8db76484e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 Alejandro Guerrero <aguerrero@...lys.com>
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +
> +/*\
> + * [Description]
> + *
> + * Test for CVE-2022-0185.
> + *
> + * References links:
> + * - https://www.openwall.com/lists/oss-security/2022/01/25/14
> + * - https://github.com/Crusaders-of-Rust/CVE-2022-0185
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +
> +#define MNTPOINT	"mntpoint"
> +
> +static int fd = -1;
> +
> +static void setup(void)
> +{
> +	fsopen_supported_by_kernel();
> +
> +	TEST(fd = fsopen(tst_device->fs_type, 0));
> +	if (fd == -1)
> +		tst_brk(TBROK | TTERRNO, "fsopen() failed");
> +
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd != -1)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static void run(void)
> +{
> +	char *val = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
> +	long pagesize;
> +
> +	pagesize = sysconf(_SC_PAGESIZE);
> +	if (pagesize == -1)
> +		tst_brk(TBROK, "sysconf(_SC_PAGESIZE) failed");
> +
> +	for (size_t i = 0; i < 5000; i++) {
> +		if (!strcmp(tst_device->fs_type, "btrfs")) {
> +			/* use same logic in kernel legacy_parse_param function */
> +			if (i * (strlen(val) + 2) + (strlen(val) + 1) + 2 > (size_t)pagesize) {
> +				TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
> +									EINVAL);
> +				if (!TST_PASS)
> +					return;
> +			} else {
> +				TST_EXP_PASS_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
> +				if (TST_ERR)
> +					return;

We need to close and reopen the FD inside run() otherwise the test fails
on BTRFS with -i2 because we have already filled the buffer.

> +			}
> +		} else {
> +			TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
> +								EINVAL);
> +			if (!TST_PASS)
> +				return;
> +		}
> +	}

This loop can be rewritten so that there are less branches and
indentation. This makes it easier to read.

	for (size_t i = 0; i < 5000; i++) {
		/* use same logic in kernel legacy_parse_param function */
		const size_t len = i * (strlen(val) + 2) + (strlen(val) + 1) + 2;

		if (!strcmp(tst_device->fs_type, "btrfs") && len <= (size_t)pagesize) {
			TST_EXP_PASS_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
			if (TST_ERR)
				return;
		} else {
			TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
					    EINVAL);
			if (!TST_PASS)
				return;
		}
	}

Otherwise the test looks good.

> +
> +	tst_res(TPASS, "fsconfig() overflow on %s haven't triggerred crash",
> +			tst_device->fs_type);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.format_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const []){"ntfs", "vfat", NULL},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "722d94847de29"},
> +		{"CVE", "2022-0185"},
> +		{}
> +	}
> +};
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
