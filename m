Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B6FC05027
	for <ltp@archiver.kernel.org>; Wed,  1 Feb 2023 12:50:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5FE43CC54A
	for <ltp@archiver.kernel.org>; Wed,  1 Feb 2023 13:49:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4191C3CB7E6
 for <ltp@lists.linux.it>; Wed,  1 Feb 2023 13:49:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BB0A8600BF8
 for <ltp@lists.linux.it>; Wed,  1 Feb 2023 13:49:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CC6CF33D33;
 Wed,  1 Feb 2023 12:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675255785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=upZfVHs9LCAfzIDpwu2/60JcTbS6WWxiFDA5DKaL4qM=;
 b=3JRiWjAwJWYSg+12suWFJoHSFrz0ju9uruPPmYWJdzSjI4F1hNHhtRNTPNxnh6oYlxM7j2
 IUV2Avdnm38v6mbizYsajK1lR7uQlJnxmV9z9UR6H5uX7C0WLflaxgUoazCODz3Zjn8qd2
 /mvXWQrD6ZhaPXl982Npy4nekSATJ4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675255785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=upZfVHs9LCAfzIDpwu2/60JcTbS6WWxiFDA5DKaL4qM=;
 b=LDrNP8dToV9736ztZmDjD+bI1YppKtnJwmEk79UBmckvns5AmGKJzISa32sKNbeYv2zaVh
 MXDV9v5Fa+yY5vCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3BA313A10;
 Wed,  1 Feb 2023 12:49:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YFulJelf2mMwRQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 01 Feb 2023 12:49:45 +0000
Date: Wed, 1 Feb 2023 13:49:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Y9pf5075zsuAhznN@pevik>
References: <20230129115021.25778-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230129115021.25778-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fsconfig: New case cover CVE-2022-0185
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

...
> +++ b/include/lapi/fsmount.h
> @@ -11,12 +11,15 @@
>  #include "config.h"
>  #include <sys/syscall.h>
>  #include <sys/types.h>
> -#include <sys/mount.h>

>  #ifndef HAVE_FSOPEN
>  # ifdef HAVE_LINUX_MOUNT_H
>  #  include <linux/mount.h>
> +# else
> +#  include <sys/mount.h>
>  # endif
> +#else
> +# include <sys/mount.h>
>  #endif
Does <linux/mount.h> conflicts with <sys/mount.h>? Or why is this needed?

>  #include "lapi/fcntl.h"
> diff --git a/runtest/syscalls b/runtest/syscalls
> index ae37a1192..b4cde8071 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -383,6 +383,7 @@ fremovexattr02 fremovexattr02

>  fsconfig01 fsconfig01
>  fsconfig02 fsconfig02
> +fsconfig03 fsconfig03

NOTE: you also need to add a new record in testcases/kernel/syscalls/fsconfig/.gitignore.

> diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> new file mode 100644
> index 000000000..e076c2f09
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
NOTE, there should be docparse label:
 * [Description]
> + * Test add some coverage to CVE-2022-0185.
> + * Try to trigger a crash.
> + * References links:
> + * https://www.openwall.com/lists/oss-security/2022/01/25/14
> + * https://github.com/Crusaders-of-Rust/CVE-2022-0185
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
Sooner or later we should add SAFE_FSOPEN(), but that can wait.

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
> +
> +	for (unsigned int i = 0; i < 2; i++) {
> +		TEST(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
> +		if (TST_RET == -1)
> +			tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
TST_EXP_PASS() or other could here be used (it should be changes also in fsconfig01.c).

Hm, there is a kernel fix from 5.17 [1]. But test fails when I run it on 6.2.0-rc5:

tst_supported_fs_types.c:165: TINFO: Skipping FUSE based ntfs as requested by the test
tst_supported_fs_types.c:157: TINFO: Skipping tmpfs as requested by the test
tst_test.c:1634: TINFO: === Testing on ext3 ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
mke2fs 1.46.5 (30-Dec-2021)
fsconfig03.c:44: TFAIL: fsconfig(FSCONFIG_SET_STRING) failed: EINVAL (22)

Isn't it the opposite: we expect to fail, thus TST_EXP_FAIL() should here be
used?

> +	}
> +	tst_res(TPASS, "Try fsconfig overflow on %s done!", tst_device->fs_type);
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
> +	.skip_filesystems = (const char *const []){"fuse", "ext2", "xfs", "tmpfs", NULL},

I wonder why this is should not be run on XFS and ext2.

Also, while we have CVE and kernel fix [1], it should be marked in struct tst_test:

	.tags = (const struct tst_tag[]) {
		{"linux-git", "722d94847de2"},
		{"CVE", "2020-29373"},
		{"CVE", "2022-0185"},
		{}
	}

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=722d94847de2


> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
