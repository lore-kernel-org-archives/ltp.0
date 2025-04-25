Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853ECC369D1
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 09:06:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A9273C5860
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 11:06:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F29293C5860
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 11:06:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7085010001DE
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 11:06:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8A940210F4;
 Fri, 25 Apr 2025 09:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745571995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VaN6rCgXGXGj7lJ3/ZI3tDpRTxBYKE7cHmXc9YbiFbE=;
 b=2ROj8tLUodn3dLIDGj4t48sorND6fP3Wvn8p+i8R2TIf6T1HxbioyV63FZkylH8ejq8aHQ
 1fDm8omvQRQan6D+dIY27nTgahGa0dHdSNPAhwLy6nUG8IPJcAbbg0AkhJoSPBYrQicD2j
 rnZP8+ue574dTqebxOOyA79mvr+BXOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745571995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VaN6rCgXGXGj7lJ3/ZI3tDpRTxBYKE7cHmXc9YbiFbE=;
 b=gADz4EGBQWdT33XQb3oEzb0nC4jmp89b/hbAfCziN3AVgO/pa86ETWxLUxPZZYVfx1N7QQ
 ZsxP0oPGdYG2XDBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2ROj8tLU;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gADz4EGB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745571995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VaN6rCgXGXGj7lJ3/ZI3tDpRTxBYKE7cHmXc9YbiFbE=;
 b=2ROj8tLUodn3dLIDGj4t48sorND6fP3Wvn8p+i8R2TIf6T1HxbioyV63FZkylH8ejq8aHQ
 1fDm8omvQRQan6D+dIY27nTgahGa0dHdSNPAhwLy6nUG8IPJcAbbg0AkhJoSPBYrQicD2j
 rnZP8+ue574dTqebxOOyA79mvr+BXOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745571995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VaN6rCgXGXGj7lJ3/ZI3tDpRTxBYKE7cHmXc9YbiFbE=;
 b=gADz4EGBQWdT33XQb3oEzb0nC4jmp89b/hbAfCziN3AVgO/pa86ETWxLUxPZZYVfx1N7QQ
 ZsxP0oPGdYG2XDBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7891013A79;
 Fri, 25 Apr 2025 09:06:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id orGzHJtQC2gYCwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 25 Apr 2025 09:06:35 +0000
Date: Fri, 25 Apr 2025 11:07:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: lufei <lufei@uniontech.com>
Message-ID: <aAtQvzjrXc49XoHH@yuki.lan>
References: <20250423044601.9320-1-lufei@uniontech.com>
 <20250423120516.10680-1-lufei@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250423120516.10680-1-lufei@uniontech.com>
X-Rspamd-Queue-Id: 8A940210F4
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/unshare: New test: CLONE_NEWNS
 unshares fs info
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
> +#define TMP "/tmp1"
> +
> +static char *cwd;
> +static char *tmpdir;
> +static char *c_cwd;
> +static char *p_cwd;
> +static size_t size = 1024;
> +
> +static void setup(void)
> +{
> +	cwd = SAFE_MALLOC(size);
> +	SAFE_GETCWD(cwd, size);
> +
> +	tmpdir = tst_tmpdir_genpath(TMP);
> +	SAFE_MKDIR(tmpdir, 0700);

There no need for absolute paths, the test starts with CWD pointing to
the newly created temporary directory. So all that we need to do is to
use relative paths with:

#define TESTDIR "test_dir"

	SAFE_MKDIR(TESTDIR, 0700);

And then later do SAFE_CHDIR(TESTDIR) in the child.

> +	c_cwd = SAFE_MALLOC(size);
> +	p_cwd = SAFE_MALLOC(size);

We do not need two of these, we can use the same buffer both in child
and parent.

> +}
> +
> +static void cleanup(void)
> +{
> +	free(c_cwd);
> +	free(p_cwd);
> +	free(cwd);
> +}
> +
> +
> +static void run(void)
> +{
> +	struct tst_clone_args args = {
> +		.flags = CLONE_FS,
> +		.exit_signal = SIGCHLD,
> +	};
> +
> +	if (!SAFE_CLONE(&args)) {
> +
> +		TST_EXP_PASS(unshare(CLONE_NEWNS));
> +
> +		SAFE_CHDIR(tmpdir);
> +		SAFE_GETCWD(c_cwd, size);
> +
> +		if (strcmp(cwd, c_cwd) == 0)
> +			tst_res(TFAIL, "current dir not changed");
> +		else
> +			tst_res(TPASS, "current dir changed to %s", c_cwd);
> +	} else {
> +		SAFE_WAIT(NULL);
> +
> +		SAFE_GETCWD(p_cwd, size);
> +
> +		if (strcmp(cwd, p_cwd) == 0)
> +			tst_res(TPASS, "cwd unshared");
> +		else
> +			tst_res(TFAIL, "cwd not unshare as expected");
                                                  ^
						unshared
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.forks_child = 1,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
> -- 
> 2.39.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
