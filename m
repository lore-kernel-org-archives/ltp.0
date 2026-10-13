Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59E5CC6B12
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 16:02:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A8453EB110
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 18:02:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D04853E8CB6
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 18:02:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 44EEA1000246
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 18:01:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 31B5B21F9C;
 Tue, 13 Oct 2026 16:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791907319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JH+jEkN9YgM+sCYhMj/aKvdOVsSn6Not228SU0sPCRc=;
 b=AA0CV6A5/61XLdpeuxlwQ1CNCCH0t/s12wPiCSv5f5D8sKqjpd1v2ghnOcb5QcLy1SXAkG
 9PKDdQr3e0dw1YWqkexeMl8cwgcb5ZRQMDT4ShGYdwC4mzRhLoOE4jCxRI+ikYkdi35Hcr
 U5Op1oKwm//GAWENfLmIYGXgirzfmQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791907319;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JH+jEkN9YgM+sCYhMj/aKvdOVsSn6Not228SU0sPCRc=;
 b=RFYmzsoSHdNylUSzk7p6ia1shgKIPr2rPrGVpynfCziRuLS/YKI7/v24Xj+PxfLtJ7aUhn
 S6tGgU9ShFKzCPDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791907318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JH+jEkN9YgM+sCYhMj/aKvdOVsSn6Not228SU0sPCRc=;
 b=XSUJ4nxx0CMl/QlGo3IW20toO9W5PMdMc2HuJk4Cp8c/asDUoF98qpc7VTrnfQwWiwheJr
 Xv4zOvLg5NM8k+/HdSTOLmzH/OAYNuZLM6xLeAqjLwrTCv6qrO6fzHFiNBWHWbIHdoP5gs
 tdXIBHALb2hirnOamuv5N8woXI72HwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791907318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JH+jEkN9YgM+sCYhMj/aKvdOVsSn6Not228SU0sPCRc=;
 b=tIJJZpoBT9ZCuiczfXMtZ4dOGIKQbQF0T2Eeoh6sjiQDfxWP9TlbR2D4F11L9eXUz3ZBg7
 9MKIJNV+Gd/dlgDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0303E13341;
 Tue, 13 Oct 2026 16:01:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IgOHM/VVzmp0IQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 13 Oct 2026 16:01:58 +0000
Date: Tue, 13 Oct 2026 18:02:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <as5WBKmXm22S6PrQ@yuki.lan>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
 <20260831-fchroot-v4-11-57cceb68f927@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260831-fchroot-v4-11-57cceb68f927@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH STAGING v4 11/16] fchroot08: test failfs root fork
 inheritance
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Verify that the root moved into failfs by fchroot() lives in the
> fs_struct which is duplicated on fork, so a child of a process with
> the failfs root also fails every absolute path lookup with
> EOPNOTSUPP.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/staging                               |  1 +
>  testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
>  testcases/kernel/syscalls/fchroot/fchroot08.c | 69 +++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+)
> 
> diff --git a/runtest/staging b/runtest/staging
> index b8954bb5a..8dfe95c4a 100644
> --- a/runtest/staging
> +++ b/runtest/staging
> @@ -7,3 +7,4 @@ fchroot04 fchroot04
>  fchroot05 fchroot05
>  fchroot06 fchroot06
>  fchroot07 fchroot07
> +fchroot08 fchroot08
> diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
> index bfa2a8ce1..0a2510d8a 100644
> --- a/testcases/kernel/syscalls/fchroot/.gitignore
> +++ b/testcases/kernel/syscalls/fchroot/.gitignore
> @@ -6,3 +6,4 @@ fchroot05
>  fchroot06
>  fchroot07
>  fchroot07_child
> +fchroot08
> diff --git a/testcases/kernel/syscalls/fchroot/fchroot08.c b/testcases/kernel/syscalls/fchroot/fchroot08.c
> new file mode 100644
> index 000000000..3180191e7
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fchroot/fchroot08.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Test that the failfs root is inherited across :manpage:`fork(2)`.
> + *
> + * The root moved into failfs by :manpage:`fchroot(2)` lives in the
> + * fs_struct which is duplicated on :manpage:`fork(2)`, so a child of a process with the
> + * failfs root also fails every absolute path lookup with ``EOPNOTSUPP``.
> + *
> + * Root is required because entering failfs with the ``FD_FAILFS_ROOT``
> + * sentinel requires ``CAP_SYS_CHROOT``.
> + *
> + * The test runs in a forked child so the root of the parent process is
> + * left untouched.
> + */
> +
> +#define _GNU_SOURCE
> +#include <fcntl.h>
> +#include <sys/wait.h>
> +#include "tst_test.h"
> +#include "lapi/fcntl.h"
> +#include "lapi/syscalls.h"
> +
> +#define ABSDIR "abs"
> +
> +static void run(void)
> +{
> +	if (SAFE_FORK())
> +		return;
> +
> +	pid_t pid;
> +
> +	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
> +		"fchroot() with the FD_FAILFS_ROOT sentinel");
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		TST_EXP_FAIL2(open(ABSDIR, O_PATH), EOPNOTSUPP,
> +			"absolute lookup in a forked child");
> +		exit(0);
> +	}
> +
> +	SAFE_WAITPID(pid, NULL, 0);
> +
> +	exit(0);
> +}
> +
> +static void setup(void)
> +{
> +	char *tmpdir;
> +	char abs_path[PATH_MAX];
> +
> +	tmpdir = tst_tmpdir_path();
> +	snprintf(abs_path, sizeof(abs_path), "%s/%s", tmpdir, "target");
> +
> +	SAFE_TOUCH("target", 0644, NULL);
> +	SAFE_SYMLINK(abs_path, ABSDIR);

I do not understand why we do the symlink here?

Why don't we pass the abs_path to the syscall directly?

> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.needs_tmpdir = 1,
> +};
> 
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
