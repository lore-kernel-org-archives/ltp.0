Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010B8C636D7
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 14:16:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4346F3CC09B
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 15:16:00 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFB093C1047
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 15:15:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 112221A007FE
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 15:15:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E2B363758F;
 Thu,  9 Feb 2023 14:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675952145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jr/LLjAsaAj77o9wuY9NJYK4gZ6TPadfKMM5iqkFqmE=;
 b=EFcoNWA4+5ceYkrzOZasmyamVh0KYAclaY6NW/ieZKyKUdNWRKa21lyUtoxRtJE+S2jQ1K
 D/IEuWOhf3CPJqgo4M16UBgl1kUBeOuJM9V/kbj1tGeUNUIgrnx6OwQk/qn9dYxts7dMaL
 4N9JQHkQKEygWjrd4/hUQnrnObseO8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675952145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jr/LLjAsaAj77o9wuY9NJYK4gZ6TPadfKMM5iqkFqmE=;
 b=RioHm7ECtx0jMq5SnpbHO5k8toA3LV5csDtZQNG3agY1ZCPIwnOq6qMY8msS29uLySOXTr
 qgVp6nFvj2AoYdDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3C80138E4;
 Thu,  9 Feb 2023 14:15:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id joVkKhEA5WPWDgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Feb 2023 14:15:45 +0000
Date: Thu, 9 Feb 2023 15:15:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Y+UAENJVDUSDPAay@pevik>
References: <20230129115021.25778-1-wegao@suse.com>
 <20230209131902.12260-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230209131902.12260-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fsconfig: New case cover CVE-2022-0185
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

There is still problem with ntfs:

tst_test.c:1634: TINFO: === Testing on ntfs ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
The partition start sector was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
fsconfig03.c:29: TBROK: fsopen() failed: ENODEV (19)

Therefore I'd skip it:
.skip_filesystems = (const char *const []){"ntfs", NULL},

> There are reproducers available for CVE-2022-0185
> https://www.openwall.com/lists/oss-security/2022/01/25/14

nit: I'd also change the commit message subject (i.e. first line) to something like
"fsconfig03: New test CVE-2022-0185"

(have taht 03)

> has links or even a zip file for an exploit
> https://github.com/Crusaders-of-Rust/CVE-2022-0185
nit: also add blank line here (readability).

> The exploits are kind of complicated as they try to be complete,
> but the exploitation vector is the fsconfig() syscall,
> this case used for add some coverage to that to detect it.

> Signed-off-by: Wei Gao <wegao@suse.com>
...
> +++ b/runtest/syscalls
> @@ -383,6 +383,7 @@ fremovexattr02 fremovexattr02

>  fsconfig01 fsconfig01
>  fsconfig02 fsconfig02
> +fsconfig03 fsconfig03

There should be *also* entry in runtest/cve:
CVE-2022-0185 fsconfig03

...
> +++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
If you used code from elsewhere (although rewritten), you should add the
copyright of the author.
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test add some coverage to CVE-2022-0185.
> + * Try to trigger a crash.
> + * References links:
> + * https://www.openwall.com/lists/oss-security/2022/01/25/14
> + * https://github.com/Crusaders-of-Rust/CVE-2022-0185
> + */

I suggest something like this (you would understand me if you had run 'cd
metadata && make' and then had ../looked at resulted ../docparse/metadata.html):

 /*\
  * [Description]
  *
  * Test for CVE-2022-0185.
  *
  * References links:
  * - https://www.openwall.com/lists/oss-security/2022/01/25/14
  * - https://github.com/Crusaders-of-Rust/CVE-2022-0185
  */

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
> +
> +	for (unsigned int i = 0; i < 5000; i++)
> +		TEST(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));

@Richie, interesting, make check cannot detect FSCONFIG_SET_STRING
(from <linux/mount.h> or <sys/mount.h>):
CHECK testcases/kernel/syscalls/fsconfig/fsconfig03.c
fsconfig03.c:44:17: error: undefined identifier 'FSCONFIG_SET_STRING'

> +
> +	tst_res(TPASS | TTERRNO, "Try fsconfig overflow on %s done! Failed as expected", tst_device->fs_type);
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
> +	.min_kver = "5.17",
You probably add it because 722d94847de29 comes from 5.17-rc1, but that should
go away, because this fix has been backported to (at least) sles kernels (which
are older).

> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "722d94847de29"},
> +		{"CVE", "2020-29373"},
IMHO CVE-2020-29373 is about io_uring
https://nvd.nist.gov/vuln/detail/CVE-2020-29373
Does it really belong to this test? If yes, it has another kernel fix.
And you don't mention it in docparse description.

> +		{"CVE", "2022-0185"},
> +		{}
> +	}
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
