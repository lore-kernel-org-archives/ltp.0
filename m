Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7B0C87FC5
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 17:11:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE5F13CCE4F
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 19:11:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FDEE3C9E07
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 19:10:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D82F02009B8
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 19:10:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 706C31F7A7;
 Thu, 24 Jul 2025 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753377043;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mNYHAqJl5gRfVz8bAX3LhIAOlnvS8Ko2T0n32pusHzo=;
 b=LhXzxBK5vicYmTxwaKbchjYH7QPVU+IIpoRx4gr4z6zfpg9zu6vYSSg2FORPEZWXsr3ciJ
 BMJCzkDFKmHO+mC5HX3poSar2ZTgtXoqxaA4eMYX0Kv4KMhNbQQew7i16bKKSzeF27LInN
 ZNPgNWPtqDYGQ81tktIriAxFMdoDksY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753377043;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mNYHAqJl5gRfVz8bAX3LhIAOlnvS8Ko2T0n32pusHzo=;
 b=jZf8AxI56m5fETlqfi97ivIZyi5GA6ZazxwL8r1iR9EN9xfGPINbofBCifW2cIMezL/Gkq
 0JkkDoGPvRw3kMCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LhXzxBK5;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jZf8AxI5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753377043;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mNYHAqJl5gRfVz8bAX3LhIAOlnvS8Ko2T0n32pusHzo=;
 b=LhXzxBK5vicYmTxwaKbchjYH7QPVU+IIpoRx4gr4z6zfpg9zu6vYSSg2FORPEZWXsr3ciJ
 BMJCzkDFKmHO+mC5HX3poSar2ZTgtXoqxaA4eMYX0Kv4KMhNbQQew7i16bKKSzeF27LInN
 ZNPgNWPtqDYGQ81tktIriAxFMdoDksY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753377043;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mNYHAqJl5gRfVz8bAX3LhIAOlnvS8Ko2T0n32pusHzo=;
 b=jZf8AxI56m5fETlqfi97ivIZyi5GA6ZazxwL8r1iR9EN9xfGPINbofBCifW2cIMezL/Gkq
 0JkkDoGPvRw3kMCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04FCC13302;
 Thu, 24 Jul 2025 17:10:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Jrd3NxJpgmjUYQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 24 Jul 2025 17:10:42 +0000
Date: Thu, 24 Jul 2025 19:10:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it,
 Andrea Cervesato <andrea.cervesato@suse.de>, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250724171036.GB108771@pevik>
References: <20250721200428.2627117-1-wegao@suse.com>
 <20250722185503.3224765-1-wegao@suse.com>
 <20250724170424.GA108771@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250724170424.GA108771@pevik>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 706C31F7A7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] mount08.c: Restrict overmounting of ephemeral
 entities
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Wei, all,

> > Add a new test to verify that mount will raise ENOENT if we try to mount
> > on magic links under /proc/<pid>/fd/<nr>.
> > Refer to the following kernel commit for more information:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d80b065bb172

> ...
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/mount/mount08.c
> > @@ -0,0 +1,57 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2024 Wei Gao <wegao@suse.com>
> > + */
> > +
> > +/*\
> > + * Verify that mount will raise ENOENT if we try to mount on magic links
> > + * under /proc/<pid>/fd/<nr>.
> > + */
> > +
> > +#include "tst_test.h"
> > +#include <sys/mount.h>
> > +#include "tst_safe_file_at.h"
> > +
> > +#define MNTPOINT "mntpoint"
> > +#define FOO MNTPOINT "/foo"
> > +#define BAR MNTPOINT "/bar"
> > +
> > +static void run(void)
> > +{
> > +	char path[PATH_MAX];
> > +	int fd, proc_fd;
> > +
> > +	fd = SAFE_OPEN(FOO, O_RDONLY | O_NONBLOCK, 0640);
> > +
> > +	sprintf(path, "/proc/%d/fd/%d", getpid(), fd);
> > +
> > +	proc_fd = SAFE_OPENAT(AT_FDCWD, path, O_PATH | O_NOFOLLOW);
> > +
> > +	sprintf(path, "/proc/%d/fd/%d", getpid(), proc_fd);
> > +
> > +	TST_EXP_FAIL(
> > +		mount(BAR, path, "", MS_BIND, 0),
> > +		ENOENT,
> > +		"mount(%s)", path

> FYI Test is failing on Tumbleweed 6.15.7, can you please have look?
> mount08.c:32: TFAIL: mount(/proc/130511/fd/4) expected ENOENT: EACCES (13)

> As Tumbleweed is very close to mainline kernel it will probably fail on mainline
> as well. But maybe it's one of few Tumbleweed patches which causes that.

Maybe it's just the environment in openQA, because running on Tumbleweed VM with
enabled SELinux it works well on both 6.15.6 and 6.16-rc1.

The same applies to recent error on ioctl_pidfd01:
ioctl_pidfd01.c:28: TFAIL: ioctl(memfd secret, PIDFD_GET_INFO, info) expected EINVAL, EBADF, ENOTTY: EACCES (13)

Kind regards,
Petr

> Kind regards,
> Petr

> > +	);
> > +
> > +	SAFE_CLOSE(fd);
> > +	SAFE_CLOSE(proc_fd);
> > +}
> > +
> > +static void setup(void)
> > +{
> > +	SAFE_TOUCH(FOO, 0777, NULL);
> > +	SAFE_TOUCH(BAR, 0777, NULL);
> > +}
> > +
> > +static struct tst_test test = {
> > +	.setup = setup,
> > +	.test_all = run,
> > +	.needs_root = 1,
> > +	.mntpoint = MNTPOINT,
> > +	.tags = (const struct tst_tag[]) {
> > +		{"linux-git", "d80b065bb172"},
> > +		{}
> > +	}
> > +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
