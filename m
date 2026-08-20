Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEDAC5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 15:55:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0B033CE2A0
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 17:55:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00FB73C0857
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 17:54:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 50A30600724
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 17:54:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 97A3A85192;
 Thu, 20 Aug 2026 15:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787241287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7+YwMs8z9WKtBDPv7Ji/t0XAYU+DIQ7bfZXrJkjfqvw=;
 b=YPhtXmuKKzfIYQBmPS5hwWKpdKKcX1vKEH3iiUFDbh8/G4bvy6yU66Dq0bwigBs2hEnaz3
 gEHA8d9v4S+sqq1DArxOaXqI/BnnWP8MZl67kFBhmIGpRM96kxcv/Ml0PrI77CkjZSeVHm
 peWp72BXZ/+hUuTuldz8IDCqES7+xAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787241287;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7+YwMs8z9WKtBDPv7Ji/t0XAYU+DIQ7bfZXrJkjfqvw=;
 b=GzNhRhERMCPbPau3umDC6ASiJ8xtwH+6Cel32tQeb7QmQZGyO0UjBRaL91803LWPyMCRRX
 /R5zMAr32lECz1BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sBA4e3jq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/AQL+W7a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787241283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7+YwMs8z9WKtBDPv7Ji/t0XAYU+DIQ7bfZXrJkjfqvw=;
 b=sBA4e3jqzRlckav3RRRBLubLTkQLmalqdXMBCb0srxol4HtxxGllhz1cFZZd0r2zDn2ykF
 2H/gWto+JS5AMFn5XJr4YztUP+PApr3xuZCmDt4wrFy4YMBFprvmP6lht+VEvPOEUqunRH
 84e6+5sO6i/FXAYukHy22StN3Y0XjeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787241283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7+YwMs8z9WKtBDPv7Ji/t0XAYU+DIQ7bfZXrJkjfqvw=;
 b=/AQL+W7a6Jxhxt9QKa1IZmKAyE44eJB8LBIFzn71I0/eMQnuLNUxr7rFHYwV+0AGdIORKx
 tt6PVOC7QdU4VuAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E549927A8;
 Thu, 20 Aug 2026 15:54:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qb/NLEIjh2pBQwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 20 Aug 2026 15:54:42 +0000
Date: Thu, 20 Aug 2026 17:54:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aocjQn12Uf0Y9tV4@yuki.lan>
References: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
 <20260820-fchroot-v2-9-062ed20957a0@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260820-fchroot-v2-9-062ed20957a0@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 97A3A85192
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.it:url,suse.cz:email,suse.cz:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH STAGING v2 09/16] fchroot06: test path walks under
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
> +	fd = SAFE_OPENAT(AT_FDCWD, ".", O_RDONLY | O_DIRECTORY);
> +	SAFE_CLOSE(fd);

This is a test right? So it should be TST_EXP_FD(openat(...));

> +	fd = SAFE_OPENAT(dfd, "canary", O_WRONLY | O_CREAT, 0600);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, "x", 1);
> +	SAFE_CLOSE(fd);
> +
> +	fd = SAFE_OPENAT(dfd, RELDIR, O_RDONLY);
> +	SAFE_CLOSE(fd);

These as well.

> +	TST_EXP_FAIL2(openat(dfd, ABSDIR, O_RDONLY), EOPNOTSUPP,
> +		"resolution of an absolute symlink");
> +
> +	fd = SAFE_OPENAT(AT_FDCWD, upwards, O_PATH);
> +	SAFE_FSTAT(fd, &st);
> +	SAFE_CLOSE(fd);

And here.

> +	TST_EXP_EXPR(st.st_dev == realroot.st_dev &&
> +		st.st_ino == realroot.st_ino,
> +		"'..' walk clamps at the top of the mount tree");
> +
> +	SAFE_CLOSE(dfd);
> +
> +	exit(0);
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
> +
> +		if (st.st_dev == root_st.st_dev && st.st_ino == root_st.st_ino)
> +			break;
> +
> +		off += snprintf(upwards + off, sizeof(upwards) - off, "/..");
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
