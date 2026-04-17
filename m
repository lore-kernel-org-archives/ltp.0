Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CD9F4368E
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 10:58:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0178C3E593F
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 12:58:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B09253CD9FD
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 12:58:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 402D61000D42
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 12:58:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6EF916A9B3;
 Fri, 17 Apr 2026 10:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776423493;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=drL5ScZoikveXyTTVRwvTq2u2c64COXPgeCG/kExGDk=;
 b=pK00AlgJr9fbI7ZTPKOQQeq8zoZL5dLpnFXAwlSDutcylcgOZ9ejjiIzTuZgokYKwRBf4i
 1TUNDMaP0OeeRS1RbNSsy6p8QLRcjSiUeUEtgR/f2LhsuH6y4wPSajFb3zw3Wkgz6MtzDK
 bLzyX4/ngm8mgtKC0UBLa0Be30SFKko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776423493;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=drL5ScZoikveXyTTVRwvTq2u2c64COXPgeCG/kExGDk=;
 b=u924mLPcNOZq27BweP1+Ux+7/OYgQMY8LeFzXi86ZgCnlQ/88larE44eK/mRChgAON5CpR
 4EsPlBJgDCKep/Aw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nTD6nzDe;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TjM+AD28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776423489;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=drL5ScZoikveXyTTVRwvTq2u2c64COXPgeCG/kExGDk=;
 b=nTD6nzDeMRVwrWP6/Zbj/DhFOF8svz45J2Tk6+vGG5uULZ9Go6P/1JaFj9ZBRM1D5Fsb1K
 3yNDOtYHRKxEs4U9GZ+pbBwK9YGA/R4QLUr+2Vu/7TIvWXYQucTr130Pvcd0BCctPhew0E
 BKgsq9DNfF2fZeDqjLO3oDr9xJDm7xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776423489;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=drL5ScZoikveXyTTVRwvTq2u2c64COXPgeCG/kExGDk=;
 b=TjM+AD28/HAiqbLGNRkFFAuUww0X3AZPXplJBffR6EegAjeFsvPDDLjp+fK51H2Jr6hdiK
 zGzSFQaFbrEOUVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47DB5593B0;
 Fri, 17 Apr 2026 10:58:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0jevEEES4mnmUwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Apr 2026 10:58:09 +0000
Date: Fri, 17 Apr 2026 12:57:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <20260417105759.GA395133@pevik>
References: <69c280f0.050a0220.2e1b4b.e591@mx.google.com>
 <20260327152751.3637-1-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260327152751.3637-1-always.starving0@gmail.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6EF916A9B3
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] fstat: add test for multiple file types using
 fstat
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

Hi Jinseok,

> Following review feedback, create a dedicated fstat test that verifies
> S_ISREG(), S_ISDIR(), S_ISFIFO(), S_ISCHR(), S_ISBLK() on different file
> types.

> diff --git a/testcases/kernel/syscalls/fstat/fstat04.c b/testcases/kernel/syscalls/fstat/fstat04.c
> new file mode 100644
> index 000000000..8a52de06a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fstat/fstat04.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
> + */
> +/*\
> + * Verify that fstat correctly identifies various file types
nit: Please use :manpage:`fstat(2)` instead of just fstat.
nit: missing dot at the end.

> + */
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/sysmacros.h>
> +#include "tst_test.h"
> +
> +#define MOUNT_PATH	"test_mnt"
> +#define REG_FILE	"regfile"
> +#define DIR_FILE	"dirfile"
> +#define FIFO_FILE	"fifofile"
> +#define CHR_DEV	MOUNT_PATH"/chrdev"
> +#define BLK_DEV	MOUNT_PATH"/blkdev"
> +
> +static struct tcase {
> +	const char *desc;
> +	const char *path;
> +	mode_t exp_type;
> +} tcases[] = {
> +	{ "S_IFREG",	REG_FILE,	S_IFREG },
FYI It's better to use macros to not repeat yourself ("S_IFDIR" and S_IFREG),
together with designated initializers, e.g. what is being used in e.g.
testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c.

#define DESC(x) .desc = #x, .exp_type = x

{ DESC(S_IFREG), .path = REG_FILE },

But I would prefer to drop desc entirely (useless see below).

> +	{ "S_IFDIR",	DIR_FILE,	S_IFDIR },
> +	{ "S_IFIFO",	FIFO_FILE,	S_IFIFO },
> +	{ "S_IFCHR",	CHR_DEV,	S_IFCHR },
> +	{ "S_IFBLK",	BLK_DEV,	S_IFBLK },
How about others two? At least S_IFLNK (symlink) should be simple to add,
I suppose S_IFSOCK (socket) as well.

> +};
> +
> +static void verify_fstat(unsigned int i)
> +{
> +	struct tcase *tc = &tcases[i];
> +	struct stat buf;
> +
> +	int flags = O_RDONLY | O_NONBLOCK;
> +
> +	if (tc->exp_type == S_IFDIR)
> +		flags |= O_DIRECTORY;
> +
> +	int fd = SAFE_OPEN(tc->path, flags);
> +
> +	SAFE_FSTAT(fd, &buf);
> +	SAFE_CLOSE(fd);
> +
> +	switch (tc->exp_type) {
> +	case S_IFREG:
> +		TST_EXP_EXPR(S_ISREG(buf.st_mode), "%s macro matches", tc->desc);
		TST_EXP_EXPR(S_ISREG(buf.st_mode));

Not using desc is IMHO good enough for debugging:
fstat04.c:49: TPASS: Expect: S_ISREG(buf.st_mode)

Original code did not have much of added value:

fstat04.c:49: TPASS: Expect: S_IFREG macro matches

The rest LGTM.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
