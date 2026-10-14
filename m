Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07272CC6B1D
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 11:52:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A27573EA786
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 13:52:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 944AC3E6A6C
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 13:52:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 05DA760035C
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 13:52:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4524B21DA2;
 Wed, 14 Oct 2026 11:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791978737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EoU+k9AVK7Ww9pgbGt7cg474zYGlNCYURZ9d9YDTVHw=;
 b=gFNM8xMkUbpc9oWzABYUnNg4h5UnU0lO5zh9GnUWoew1cH5LtWlmjjZuiS+tiXfbUwkqKT
 UykCWNievWk75MlAPmvVQNSeom5pPogrDOMd+pTTW1MaH6aHAYSrnHQd+Egt8L29b+PTWo
 LgpgptGF83VWNfBr7tyTDcAJthtzTdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791978737;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EoU+k9AVK7Ww9pgbGt7cg474zYGlNCYURZ9d9YDTVHw=;
 b=+MCdNljZYuNxH+ccJsQsVXXRxIQ8cdp9hwv54PN4akJmlu5HAX1aWGEY+CuzCrVQ/8Wike
 7lLaFsK0M/fzWSDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791978736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EoU+k9AVK7Ww9pgbGt7cg474zYGlNCYURZ9d9YDTVHw=;
 b=tvZa3ZvIuDEH6kKGj+NFaqltjx4rRyYjSS/8c7xMjv/Whgm4zNaCsgYvducFqJhiLrY/Yn
 SiuUffsmR65trau0SzPMLZz7y1iTjNRAVCQNbgbvQU8qlTqQsnEt8ij28R49SuY+V5rCbe
 4y2hSalJEj6W3Pg0fIrxhTyfBa7Scxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791978736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EoU+k9AVK7Ww9pgbGt7cg474zYGlNCYURZ9d9YDTVHw=;
 b=dkqyjx0tbLdin+PfVh6PEFApVa6dRZzeQ6dE7Ak87rgXJsNKWm0QqTUZ5KErXFDMqF8F9t
 XauoBU1qvHRVp8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15940133F1;
 Wed, 14 Oct 2026 11:52:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jRc6OO9sz2qhTwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 14 Oct 2026 11:52:16 +0000
Date: Wed, 14 Oct 2026 13:52:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <as9s_vmNm66HStbG@yuki.lan>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
 <20260831-fchroot-v4-12-57cceb68f927@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260831-fchroot-v4-12-57cceb68f927@suse.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.com:email,
 imap1.dmz-prg2.suse.org:helo, linux.it:url]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH STAGING v4 12/16] fchroot09: test setns escape
 from failfs root
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
> Verify that entering failfs with fchroot() is hard to undo: a process
> inside counts as chrooted, so the remaining way out is a pre-opened
> mount namespace fd. setns() into it resets both the root and the
> working directory.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/staging                               |  1 +
>  testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
>  testcases/kernel/syscalls/fchroot/fchroot09.c | 86 +++++++++++++++++++++++++++
>  3 files changed, 88 insertions(+)
> 
> diff --git a/runtest/staging b/runtest/staging
> index 8dfe95c4a..23f6c6a20 100644
> --- a/runtest/staging
> +++ b/runtest/staging
> @@ -8,3 +8,4 @@ fchroot05 fchroot05
>  fchroot06 fchroot06
>  fchroot07 fchroot07
>  fchroot08 fchroot08
> +fchroot09 fchroot09
> diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
> index 0a2510d8a..b577da61f 100644
> --- a/testcases/kernel/syscalls/fchroot/.gitignore
> +++ b/testcases/kernel/syscalls/fchroot/.gitignore
> @@ -7,3 +7,4 @@ fchroot06
>  fchroot07
>  fchroot07_child
>  fchroot08
> +fchroot09
> diff --git a/testcases/kernel/syscalls/fchroot/fchroot09.c b/testcases/kernel/syscalls/fchroot/fchroot09.c
> new file mode 100644
> index 000000000..bc9324ceb
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fchroot/fchroot09.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Test that :manpage:`setns(2)` escapes the failfs root.
> + *
> + * Entering failfs with :manpage:`fchroot(2)` is hard to undo: a process
> + * inside counts as chrooted, so :manpage:`chroot(2)` and :manpage:`fchroot(2)`
> + * back out require ``CAP_SYS_CHROOT``. The remaining way out is a pre-opened
> + * mount namespace file descriptor: :manpage:`setns(2)` into it resets both the
> + * root and the working directory.
> + *
> + * Root is required because entering failfs requires ``CAP_SYS_CHROOT`` and
> + * :manpage:`setns(2)` into the mount namespace requires ``CAP_SYS_ADMIN``.
> + *
> + * The test runs in a forked child so the root of the parent process is
> + * left untouched.
> + */
> +
> +#define _GNU_SOURCE
> +#include <fcntl.h>
> +#include <sys/stat.h>
> +#include "tst_test.h"
> +#include "lapi/fcntl.h"
> +#include "lapi/sched.h"
> +#include "lapi/setns.h"
> +#include "lapi/syscalls.h"
> +
> +#define ABSDIR "abs"
> +
> +static void run(void)
> +{
> +	if (SAFE_FORK())
> +		return;
> +
> +	struct stat realroot, st;
> +	int nsfd;
> +
> +	SAFE_STAT("/", &realroot);
> +	nsfd = SAFE_OPEN("/proc/self/ns/mnt", O_RDONLY);
> +
> +	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
> +		"fchroot() with the FD_FAILFS_ROOT sentinel");
> +
> +	TST_EXP_FAIL2(open(ABSDIR, O_PATH), EOPNOTSUPP,
> +		"absolute lookup after entering failfs");
> +
> +	TST_EXP_PASS(setns(nsfd, CLONE_NEWNS),
> +		"setns() back into the mount namespace");
> +
> +	SAFE_CLOSE(nsfd);
> +
> +	SAFE_STAT("/", &st);
> +	TST_EXP_EXPR(st.st_dev == realroot.st_dev &&
> +		st.st_ino == realroot.st_ino,
> +		"root restored after setns()");
> +
> +	SAFE_STAT(".", &st);
> +	TST_EXP_EXPR(st.st_dev == realroot.st_dev &&
> +		st.st_ino == realroot.st_ino,
> +		"working directory restored after setns()");
> +
> +	exit(0);

Here as well, no need for the exit.

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

Here as well, why are all the absolute directories symlinks? It makes
sense to have a test symlink to absolute directory restarts the lookup
and fails, but why don't we use just abs_path in most of the tests?

I suppose that we can even open just "/" with O_PATH to check if the
failfs root is active or not...

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
