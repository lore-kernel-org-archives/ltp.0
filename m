Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE78C87FC5
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 17:04:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4B8E3CCE4C
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 19:04:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B518C3C9E07
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 19:04:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D4A106001E8
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 19:04:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AB7852199F;
 Thu, 24 Jul 2025 17:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753376670;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MZF9AdWvwT8VEasp0EpycUPLgZib0p0g1423x7A6a88=;
 b=mXEe+/bpsNRdmwNGC0C9If0jehlDBrccjPfbpra+yyNfH+pm+cXdCYu83has74HSZpdEyp
 cRnzF4p2EYg8POG/uVEPBCfH9pG7cUPVV4sxTgXt8H1PeBPKhard3FafCPyEgFMwNA7s1F
 BzhBGJ59GHjoNnsid/KzRIOl8EGuJ24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753376670;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MZF9AdWvwT8VEasp0EpycUPLgZib0p0g1423x7A6a88=;
 b=qB4ZsOFRsjPvcOLYO7dQy5xpNoB2FJ01Zi+XDhCIcF6pcKYA0qaXmGsBpjYcQ3CWAMVKM4
 08070aaIAs/vFeBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="mXEe+/bp";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qB4ZsOFR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753376670;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MZF9AdWvwT8VEasp0EpycUPLgZib0p0g1423x7A6a88=;
 b=mXEe+/bpsNRdmwNGC0C9If0jehlDBrccjPfbpra+yyNfH+pm+cXdCYu83has74HSZpdEyp
 cRnzF4p2EYg8POG/uVEPBCfH9pG7cUPVV4sxTgXt8H1PeBPKhard3FafCPyEgFMwNA7s1F
 BzhBGJ59GHjoNnsid/KzRIOl8EGuJ24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753376670;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MZF9AdWvwT8VEasp0EpycUPLgZib0p0g1423x7A6a88=;
 b=qB4ZsOFRsjPvcOLYO7dQy5xpNoB2FJ01Zi+XDhCIcF6pcKYA0qaXmGsBpjYcQ3CWAMVKM4
 08070aaIAs/vFeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BF0E136DC;
 Thu, 24 Jul 2025 17:04:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3e5bGJ5ngmgOYAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 24 Jul 2025 17:04:30 +0000
Date: Thu, 24 Jul 2025 19:04:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250724170424.GA108771@pevik>
References: <20250721200428.2627117-1-wegao@suse.com>
 <20250722185503.3224765-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250722185503.3224765-1-wegao@suse.com>
X-Rspamd-Queue-Id: AB7852199F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei, all,

> Add a new test to verify that mount will raise ENOENT if we try to mount
> on magic links under /proc/<pid>/fd/<nr>.
> Refer to the following kernel commit for more information:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d80b065bb172

...
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mount/mount08.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * Verify that mount will raise ENOENT if we try to mount on magic links
> + * under /proc/<pid>/fd/<nr>.
> + */
> +
> +#include "tst_test.h"
> +#include <sys/mount.h>
> +#include "tst_safe_file_at.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define FOO MNTPOINT "/foo"
> +#define BAR MNTPOINT "/bar"
> +
> +static void run(void)
> +{
> +	char path[PATH_MAX];
> +	int fd, proc_fd;
> +
> +	fd = SAFE_OPEN(FOO, O_RDONLY | O_NONBLOCK, 0640);
> +
> +	sprintf(path, "/proc/%d/fd/%d", getpid(), fd);
> +
> +	proc_fd = SAFE_OPENAT(AT_FDCWD, path, O_PATH | O_NOFOLLOW);
> +
> +	sprintf(path, "/proc/%d/fd/%d", getpid(), proc_fd);
> +
> +	TST_EXP_FAIL(
> +		mount(BAR, path, "", MS_BIND, 0),
> +		ENOENT,
> +		"mount(%s)", path

FYI Test is failing on Tumbleweed 6.15.7, can you please have look?
mount08.c:32: TFAIL: mount(/proc/130511/fd/4) expected ENOENT: EACCES (13)

As Tumbleweed is very close to mainline kernel it will probably fail on mainline
as well. But maybe it's one of few Tumbleweed patches which causes that.

Kind regards,
Petr

> +	);
> +
> +	SAFE_CLOSE(fd);
> +	SAFE_CLOSE(proc_fd);
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_TOUCH(FOO, 0777, NULL);
> +	SAFE_TOUCH(BAR, 0777, NULL);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "d80b065bb172"},
> +		{}
> +	}
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
