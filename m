Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC637C64ED8
	for <ltp@archiver.kernel.org>; Mon, 27 Feb 2023 16:33:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51B983CBA68
	for <ltp@archiver.kernel.org>; Mon, 27 Feb 2023 17:33:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 880B93CB47B
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 17:33:15 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8E2771400247
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 17:33:14 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id A9915219FF;
 Mon, 27 Feb 2023 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1677515593;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4KaQ3V4fisDim3ttjkw4ecvV/Evmnp7eczDUm4f24oE=;
 b=RzUIpW9tKCfxWdxgnl2C11uSDZ2RTLbWg2oZWPZX9e3M0yLYWk4+dpEu0fstvyB119sX4Q
 ySNCrVi4L3F+jCjYTSHH7NUyDFv29J8TCNBc68thx9816a39hs6VDr8dRa44YI6X9OlGVb
 WzF0OaVprAVkqyF0K2PPWWWt+VrxAYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1677515593;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4KaQ3V4fisDim3ttjkw4ecvV/Evmnp7eczDUm4f24oE=;
 b=1Nub2Tv51nVnLvLwFO+gAhN4HCjVMB4nKK+zaQpDNrzZwcMWVf/4CuXRMou8KZ7kzAJ2l8
 BJpeZKvNiB3nNKCw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A706F2C141;
 Mon, 27 Feb 2023 16:33:12 +0000 (UTC)
References: <20230213010924.12352-1-wegao@suse.com>
 <20230216235218.25757-1-wegao@suse.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Mon, 27 Feb 2023 16:20:02 +0000
Organization: Linux Private Site
In-reply-to: <20230216235218.25757-1-wegao@suse.com>
Message-ID: <877cw3ax15.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] fsconfig03: New test CVE-2022-0185
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

Wei Gao <wegao@suse.com> writes:

> There are reproducers available for CVE-2022-0185
> https://www.openwall.com/lists/oss-security/2022/01/25/14
>
> Also with links or even a zip file for an exploit
> https://github.com/Crusaders-of-Rust/CVE-2022-0185
>
> The exploits are kind of complicated as they try to be complete,
> but the exploitation vector is the fsconfig() syscall,
> this case used for add some coverage to that to detect it.
>
> When kernel < v5.15.16, you can easily reproduce crash use test case
> without check error and return logic in loop.
>
> I have used this test case trigger 5.14.1 kernel crash with ext2/4.
> Just make sure your kernel have not patched by following two commits:
> e192ccc17ecf3 - fix up param length parsing in legacy_parse_param
> cebe85d570cf8 - ext4: switch to the new mount api
>
> Signed-off-by: Wei Gao <wegao@suse.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  runtest/cve                                   |  2 +
>  runtest/syscalls                              |  1 +
>  testcases/kernel/syscalls/fsconfig/.gitignore |  1 +
>  .../kernel/syscalls/fsconfig/fsconfig03.c     | 79 +++++++++++++++++++
>  4 files changed, 83 insertions(+)
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
> index 000000000..c2e908221
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> @@ -0,0 +1,79 @@
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
> +}
> +
> +static void run(void)
> +{
> +	char *val = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
> +	long pagesize;
> +
> +	TEST(fd = fsopen(tst_device->fs_type, 0));
> +	if (fd == -1)
> +		tst_brk(TBROK | TTERRNO, "fsopen() failed");
> +
> +	pagesize = sysconf(_SC_PAGESIZE);
> +	if (pagesize == -1)
> +		tst_brk(TBROK, "sysconf(_SC_PAGESIZE) failed");
> +
> +	for (size_t i = 0; i < 5000; i++) {
> +		/* use same logic in kernel legacy_parse_param function */
> +		const size_t len = i * (strlen(val) + 2) + (strlen(val) + 1) + 2;
> +
> +		if (!strcmp(tst_device->fs_type, "btrfs") && len <= (size_t)pagesize) {
> +			TST_EXP_PASS_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
> +			if (TST_ERR)
> +				return;

Why not keep going if there is an error? Possibly we won't get an Ooops
the first time there is an error, but if we keep going then it will
result in a more serious error. Perhaps in this case it is unlikely, but
I don't see a big downside to keep going.

Generally people pay more attention to stack traces.

> +		} else {
> +			TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
> +					    EINVAL);
> +			if (!TST_PASS)
> +				return;

Same here.

I know it will result in 1000's of lines of noise, but only in the
failure case.

> +		}
> +	}
> +
> +	if (fd != -1)
> +		SAFE_CLOSE(fd);
> +
> +	tst_res(TPASS, "fsconfig() overflow on %s haven't triggerred crash",
> +			tst_device->fs_type);

It's OK to print pass after printing fail if the pass and fail messages
do not contradict each other.

Actually I now remember that we can check for kernel taints, from the
manual:

1.24 Tainted kernels
~~~~~~~~~~~~~~~~~~~~

If you need to detect whether a testcase triggers a kernel warning, bug or
oops, the following can be used to detect TAINT_W or TAINT_D:

[source,c]
-------------------------------------------------------------------------------
#include "tst_test.h"

static struct tst_test test = {
	...
	.taint_check = TST_TAINT_W | TST_TAINT_D,
	...
};

void run(void)
{
	...
	if (tst_taint_check() != 0)
		tst_res(TFAIL, "kernel has issues");
	else
		tst_res(TPASS, "kernel seems to be fine");
}
-------------------------------------------------------------------------------

...

If fsconfig produces an unexpected result, but there is no Oops this is
usefull for debugging. Especially if it is just the test that is broken.

> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
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


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
