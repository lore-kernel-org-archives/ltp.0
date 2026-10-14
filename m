Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D84DCC6B1D
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 11:39:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 716D53EA78A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 13:39:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D90A3E6C83
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 13:39:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 391CD1A00A44
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 13:39:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 679362213E;
 Wed, 14 Oct 2026 11:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791977960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcAbWqRlu12eL/jqxhsthKN+x9XwSIOhwmm7H57wVcM=;
 b=hYw144Ds8gu2a6kx8iQ9gzYFP70JJ9xq9nR+zYgPIobMSZUqnpBCEBl0UpMq0TiopmW3wO
 TFFiWhenti7PM1AuA4Rh7EkJbu74SoM4kVa05bK+g0J8goLJH1jSt6Q7xyxHx9QRjWIIu+
 WkR2TcitnnVI2LgSCNLTR8AQ4LOMD1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791977960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcAbWqRlu12eL/jqxhsthKN+x9XwSIOhwmm7H57wVcM=;
 b=hA2kUAoAqsvZb+b5ARytmQq3TDYUOUay0jn4h8onvP95IWPwJsQzPvm9SdLSZxQfGypexD
 e7+Wko4uQp8cAIBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hYw144Ds;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hA2kUAoA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791977960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcAbWqRlu12eL/jqxhsthKN+x9XwSIOhwmm7H57wVcM=;
 b=hYw144Ds8gu2a6kx8iQ9gzYFP70JJ9xq9nR+zYgPIobMSZUqnpBCEBl0UpMq0TiopmW3wO
 TFFiWhenti7PM1AuA4Rh7EkJbu74SoM4kVa05bK+g0J8goLJH1jSt6Q7xyxHx9QRjWIIu+
 WkR2TcitnnVI2LgSCNLTR8AQ4LOMD1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791977960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcAbWqRlu12eL/jqxhsthKN+x9XwSIOhwmm7H57wVcM=;
 b=hA2kUAoAqsvZb+b5ARytmQq3TDYUOUay0jn4h8onvP95IWPwJsQzPvm9SdLSZxQfGypexD
 e7+Wko4uQp8cAIBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D4B9133F1;
 Wed, 14 Oct 2026 11:39:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CHKFKOdpz2qTQAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 14 Oct 2026 11:39:20 +0000
Date: Wed, 14 Oct 2026 13:39:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <as9p9q27TFl3-EQP@yuki.lan>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
 <20260831-fchroot-v4-9-57cceb68f927@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260831-fchroot-v4-9-57cceb68f927@suse.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,linux.it:url];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 679362213E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH STAGING v4 09/16] fchroot06: test path walks under
 failfs root
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
> Verify that once the root is in failfs only lookups anchored at a
> file descriptor keep working: relative lookups from the working
> directory and from a pre-opened directory fd succeed, absolute
> symlinks fail with EOPNOTSUPP and ".." walks clamp at the top of the
> mount tree, landing on the real root.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/staging                               |   1 +
>  testcases/kernel/syscalls/fchroot/.gitignore  |   1 +
>  testcases/kernel/syscalls/fchroot/fchroot06.c | 126 ++++++++++++++++++++++++++
>  3 files changed, 128 insertions(+)
> 
> diff --git a/runtest/staging b/runtest/staging
> index 49f51d637..8b6b1ecd9 100644
> --- a/runtest/staging
> +++ b/runtest/staging
> @@ -5,3 +5,4 @@ fchroot02 fchroot02
>  fchroot03 fchroot03
>  fchroot04 fchroot04
>  fchroot05 fchroot05
> +fchroot06 fchroot06
> diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
> index 0697f10eb..12151270a 100644
> --- a/testcases/kernel/syscalls/fchroot/.gitignore
> +++ b/testcases/kernel/syscalls/fchroot/.gitignore
> @@ -3,3 +3,4 @@ fchroot02
>  fchroot03
>  fchroot04
>  fchroot05
> +fchroot06
> diff --git a/testcases/kernel/syscalls/fchroot/fchroot06.c b/testcases/kernel/syscalls/fchroot/fchroot06.c
> new file mode 100644
> index 000000000..8f678344f
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fchroot/fchroot06.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Test path walks under the failfs root.
> + *
> + * Once :manpage:`fchroot(2)` moved the process root into failfs, only
> + * lookups anchored at a file descriptor keep working:
> + *
> + * - lookups relative to the working directory, which stays in the real
> + *   filesystem, keep working
> + * - lookups anchored at a pre-opened directory fd keep working, including
> + *   resolution of relative symlinks
> + * - absolute symlinks restart the walk at the failfs root and fail with
> + *   ``EOPNOTSUPP``
> + * - ".." walks clamp at the top of the mount tree, not at the failfs
> + *   root, so walking up from the working directory lands on the real
> + *   root
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
> +#include <sys/stat.h>
> +#include "tst_test.h"
> +#include "lapi/fcntl.h"
> +#include "lapi/syscalls.h"
> +#include "tst_safe_file_at.h"
> +
> +#define RELDIR "rel"
> +#define ABSDIR "abs"
> +
> +static char upwards[PATH_MAX];
> +
> +static void run(void)
> +{
> +	if (SAFE_FORK())
> +		return;
> +
> +	struct stat realroot, st;
> +	int dfd, fd;
> +
> +	SAFE_STAT("/", &realroot);
> +	dfd = SAFE_OPEN(".", O_RDONLY | O_DIRECTORY);
> +
> +	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
> +		"fchroot() with the FD_FAILFS_ROOT sentinel");
> +
> +	fd = TST_EXP_FD(openat(AT_FDCWD, ".", O_RDONLY | O_DIRECTORY));
> +	if (fd != -1)
> +		SAFE_CLOSE(fd);
> +
> +	fd = TST_EXP_FD(openat(dfd, "canary", O_WRONLY | O_CREAT, 0600));
> +	if (fd != -1) {
> +		SAFE_WRITE(SAFE_WRITE_ALL, fd, "x", 1);
> +		SAFE_CLOSE(fd);
> +	}
> +
> +	fd = TST_EXP_FD(openat(dfd, RELDIR, O_RDONLY));
> +	if (fd != -1)
> +		SAFE_CLOSE(fd);
> +
> +	TST_EXP_FAIL2(openat(dfd, ABSDIR, O_RDONLY), EOPNOTSUPP,
> +		"resolution of an absolute symlink");
> +
> +	fd = TST_EXP_FD(openat(AT_FDCWD, upwards, O_PATH));
> +	if (fd != -1) {
> +		SAFE_FSTAT(fd, &st);
> +		SAFE_CLOSE(fd);
> +
> +		TST_EXP_EXPR(st.st_dev == realroot.st_dev &&
> +			st.st_ino == realroot.st_ino,
> +			"'..' walk clamps at the top of the mount tree");
> +	}
> +
> +	SAFE_CLOSE(dfd);
> +
> +	exit(0);

Here as well, no need for the exit(0);

> +}
> +
> +static void setup(void)
> +{
> +	char *tmpdir;
> +	char abs_path[PATH_MAX];
> +	struct stat root_st, st;
> +	int fd, off;
> +
> +	tmpdir = tst_tmpdir_path();
> +	snprintf(abs_path, sizeof(abs_path), "%s/%s", tmpdir, "target");
> +
> +	SAFE_TOUCH("target", 0644, NULL);
> +	SAFE_SYMLINK("target", RELDIR);
> +	SAFE_SYMLINK(abs_path, ABSDIR);
> +
> +	SAFE_STAT("/", &root_st);
> +
> +	off = snprintf(upwards, sizeof(upwards), "..");
> +	while (1) {
> +		fd = SAFE_OPENAT(AT_FDCWD, upwards, O_PATH);
> +		SAFE_FSTAT(fd, &st);
> +		SAFE_CLOSE(fd);

Why not just SAFE_FSTAT(upwards, &st) ?

> +		if (st.st_dev == root_st.st_dev && st.st_ino == root_st.st_ino)
> +			break;
> +
> +		if ((size_t)off + sizeof("/..") > sizeof(upwards))
> +			tst_brk(TBROK, "Path to root too long");
> +
> +		off += snprintf(upwards + off, sizeof(upwards) - off, "/..");

This can probably be simplified to:

	strcpy(upwards + off, "../");
	off += 3;

The string is constant and we already checked that it fits, there is no
need to use the big hammer (snprintf).

And the same for the initial snprintf(), just strcpy(upwards, ".."); off = 2;

> +	}
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
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
