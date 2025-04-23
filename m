Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E323C369D3
	for <ltp@archiver.kernel.org>; Wed, 23 Apr 2025 09:10:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C19CA3CAECC
	for <ltp@archiver.kernel.org>; Wed, 23 Apr 2025 11:10:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D006B3CACDB
 for <ltp@lists.linux.it>; Wed, 23 Apr 2025 11:09:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E3C4B1000372
 for <ltp@lists.linux.it>; Wed, 23 Apr 2025 11:09:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D2A1D21250;
 Wed, 23 Apr 2025 09:09:40 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBDF613A3D;
 Wed, 23 Apr 2025 09:09:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2mdHLFSuCGggCAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 23 Apr 2025 09:09:40 +0000
Date: Wed, 23 Apr 2025 11:10:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: lufei <lufei@uniontech.com>
Message-ID: <aAiud8vv-DHICLXY@yuki.lan>
References: <20250423044601.9320-1-lufei@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250423044601.9320-1-lufei@uniontech.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: D2A1D21250
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/unshare: New test: CLONE_NEWNS unshares
 fs info
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 844ae7a13..57338297a 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1725,6 +1725,7 @@ unlinkat01 unlinkat01
>  unshare01 unshare01
>  unshare02 unshare02
>  unshare03 unshare03
> +unshare04 unshare04
>  
>  #
>  # These tests require an unmounted block device
> diff --git a/testcases/kernel/syscalls/unshare/.gitignore b/testcases/kernel/syscalls/unshare/.gitignore
> index e5b5c261d..b1206e452 100644
> --- a/testcases/kernel/syscalls/unshare/.gitignore
> +++ b/testcases/kernel/syscalls/unshare/.gitignore
> @@ -1,3 +1,4 @@
>  /unshare01
>  /unshare02
>  /unshare03
> +/unshare04
> diff --git a/testcases/kernel/syscalls/unshare/unshare04.c b/testcases/kernel/syscalls/unshare/unshare04.c
> new file mode 100644
> index 000000000..0bbb9d19d
> --- /dev/null
> +++ b/testcases/kernel/syscalls/unshare/unshare04.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 lufei <lufei@uniontech.com>
> + */
> +
> +/*\
> + * This test case is to verify unshare(CLONE_NEWNS) also unshares filesystem
> + * information.
> + *
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "tst_test.h"
> +#include "lapi/sched.h"
> +
> +#ifdef HAVE_UNSHARE

This shouldn't be needed anymore, the minimal glibc we support at the
moment is 2.22, unshare() if I'm looking right is included in glibc 2.4
and newer. I suppose that removing the configure check for unshare() is
long overdue.

> +#define TMP "/tmp"

The test shouldn't expect or touch directories outside the test
temporary directory. If you need a diretory to chdir() into create one
in the test setup() instead.

> +static void run(void)
> +{
> +	char *c_cwd;
> +	char *p_cwd;
> +	size_t size = 1024;
> +
> +	c_cwd = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE,
> +			MAP_SHARED | MAP_ANONYMOUS,
> +			-1, 0);
> +
> +	p_cwd = SAFE_MALLOC(size);

These allocations should be made in test setup and freed in the test
cleanup.

> +	struct tst_clone_args args = {
> +		.flags = CLONE_FS,
> +		.exit_signal = SIGCHLD,
> +	};
> +
> +	if (!SAFE_CLONE(&args)) {
> +
> +		TST_EXP_PASS(unshare(CLONE_NEWNS));
> +
> +		SAFE_CHDIR(TMP);
> +		SAFE_GETCWD(c_cwd, size);
> +	} else {
> +		SAFE_WAIT(NULL);
> +
> +		SAFE_GETCWD(p_cwd, size);
> +
> +		tst_res(TDEBUG, "parent cwd: %s", p_cwd);
> +		tst_res(TDEBUG, "child cwd: %s", c_cwd);
> +
> +		//in parent, cwd stays in tst_tmpdir_path than TMP.
> +		if (strcmp(p_cwd, c_cwd) == 0)
> +			tst_res(TFAIL, "cwd not unshared as expected");
> +		else
> +			tst_res(TPASS, "cwd unshared");

We are validating that the CWD wasn't changed in parent after we have
done unshare() and chdir() in the child. Why do we even compare the
parent CWD againts the child? Rather than that we have to compare the
CWD in the parent againts the CWD at the start of the test.

What we should do is:

- do chdir() in child
- check in child that CWD was changed

- wait child in parent
- check in parent that CWD wasn't changed

For that all we have to do is to do getcwd() in the test setup and then
use it for a comparsion both in the child and parent.

> +	}
> +}
> +
> +static struct tst_test test = {
> +	.forks_child = 1,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.test_all = run,
> +};
> +
> +#else
> +TST_TEST_TCONF("unshare syscall is undefined.");
> +#endif
> -- 
> 2.39.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
