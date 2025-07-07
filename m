Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55ADCC83F07
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 12:33:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B210D3C6E52
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 14:33:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2741B3C6492
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 14:33:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2F398600727
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 14:33:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 051441F393;
 Mon,  7 Jul 2025 12:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751891589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3B7JZMsOBGMcd1q8OoXF5aaUW4inrt6hgMvuGOHK1gY=;
 b=DjKn7Y5hTydg+16HbbNHxmtA9VH85rTikdhtEM3eTZgu8yidvpAby41xZAYfXTw3BOSnwD
 c7qbZdCwq6uqP0klvsyKUwJrFtiWrxP6P6ttBJUznmIXTO66aFxpobhnWHX9+Vt6uWewin
 PwLTddPohbNqy8pWT2epOuWDMX/IjeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751891589;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3B7JZMsOBGMcd1q8OoXF5aaUW4inrt6hgMvuGOHK1gY=;
 b=uzrhFYCil4MbW2El7pRnV06/IqGyKXFv5fZAKiT18NZtU/RDUv/aOdFtVJ+vP97DI2KV/B
 0IUWBZVKDbhdYbCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DjKn7Y5h;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uzrhFYCi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751891589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3B7JZMsOBGMcd1q8OoXF5aaUW4inrt6hgMvuGOHK1gY=;
 b=DjKn7Y5hTydg+16HbbNHxmtA9VH85rTikdhtEM3eTZgu8yidvpAby41xZAYfXTw3BOSnwD
 c7qbZdCwq6uqP0klvsyKUwJrFtiWrxP6P6ttBJUznmIXTO66aFxpobhnWHX9+Vt6uWewin
 PwLTddPohbNqy8pWT2epOuWDMX/IjeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751891589;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3B7JZMsOBGMcd1q8OoXF5aaUW4inrt6hgMvuGOHK1gY=;
 b=uzrhFYCil4MbW2El7pRnV06/IqGyKXFv5fZAKiT18NZtU/RDUv/aOdFtVJ+vP97DI2KV/B
 0IUWBZVKDbhdYbCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E599F13A5E;
 Mon,  7 Jul 2025 12:33:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /xkTN4S+a2g3CAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 07 Jul 2025 12:33:08 +0000
Date: Mon, 7 Jul 2025 14:33:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aGu-qne-SMpTCEy4@yuki.lan>
References: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
 <20250704-ioctl_pidfd_suite-v2-4-88a6466d9f62@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250704-ioctl_pidfd_suite-v2-4-88a6466d9f62@suse.com>
X-Rspamd-Queue-Id: 051441F393
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/8] Add ioctl_pidfd02 test
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
> diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
> index aa952c1a7bae0ae2dbb04de0595f10d508b6759a..1c81c2bed8db952af0c93fb1ce5bfbad82794b60 100644
> --- a/testcases/kernel/syscalls/ioctl/.gitignore
> +++ b/testcases/kernel/syscalls/ioctl/.gitignore
> @@ -30,3 +30,4 @@
>  /ioctl_ficlonerange02
>  /ioctl_fiemap01
>  /ioctl_pidfd01
> +/ioctl_pidfd02
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..a5a9a561ff676607d68a33ed5572d4c3cdb28f26
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Check if the ioctl() function allows retrieval of a child's exit code
> + * using PIDFD_INFO_EXIT from a process that can be isolated or not from the
> + * child.
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/pidfd.h"
> +#include "lapi/sched.h"
> +
> +static struct tst_clone_args *args;
> +static struct pidfd_info *info0, *info1;
> +
> +static void run(unsigned int isolate)
> +{
> +	int status;
> +	int pidfd = 0;
> +	pid_t pid_child;
> +
> +	memset(args, 0, sizeof(struct tst_clone_args));
> +	memset(info0, 0, sizeof(struct pidfd_info));
> +	memset(info1, 0, sizeof(struct pidfd_info));
> +
> +	if (isolate) {
> +		args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
> +		args->pidfd = (uint64_t)&pidfd;
> +		args->exit_signal = SIGCHLD;
> +
> +		pid_child = SAFE_CLONE(args);
> +	} else {
> +		pid_child = SAFE_FORK();
> +	}
> +
> +	if (!pid_child) {
> +		TST_CHECKPOINT_WAIT(0);
> +		exit(100);
> +	}
> +
> +	if (!isolate)
> +		pidfd = SAFE_PIDFD_OPEN(pid_child, 0);
> +
> +	/* child is not reaped and ioctl() won't provide any exit status info */
> +	info0->mask = PIDFD_INFO_EXIT;
> +	SAFE_IOCTL(pidfd, PIDFD_GET_INFO, info0);
> +	TST_EXP_EQ_LI(info0->mask & PIDFD_INFO_EXIT, 0);
> +	TST_EXP_EQ_LI(info0->exit_code, 0);
> +
> +	TST_CHECKPOINT_WAKE(0);
> +
> +	SAFE_WAITPID(pid_child, &status, 0);
> +
> +	/* child is now reaped and ioctl() will provide the exit status */
> +	info1->mask = PIDFD_INFO_EXIT;
> +	SAFE_IOCTL(pidfd, PIDFD_GET_INFO, info1);
> +
> +	TST_EXP_EQ_LI(info1->mask & PIDFD_INFO_EXIT, PIDFD_INFO_EXIT);
> +	TST_EXP_EQ_LI(WIFEXITED(info1->exit_code), WIFEXITED(status));
> +	TST_EXP_EQ_LI(WEXITSTATUS(info1->exit_code), WEXITSTATUS(status));
> +
> +	TST_EXP_EXPR(info0->exit_code != info1->exit_code,
> +	      "info0->exit_code (%i) != info1->exit_code (%i)",
> +	      info0->exit_code, info1->exit_code);

Wouldn't it be just easier to check that info1->exit_code == 100? We
already asserted that info0->exit_code == 0 and because 100 != 0 we will
get this assertion already covered.

> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = 2,
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +	.min_kver = "6.15",

We just backported this into 6.12 in SUSE so we would need a different
runtime detection than this. Generally it's a good idea to avoid kernel
version checks if possible.

Looking at the kernel code it looks that if the PIDFD_INFO_EXIT is not
supported we will get ESRCH in the second case. So I suppose that better
fix would be to allow ESRCH in the second case if kernel is older than
6.15 instead of skipping the whole test.

> +	.bufs = (struct tst_buffers []) {
> +		{&args, .size = sizeof(*args)},
> +		{&info0, .size = sizeof(*info0)},
> +		{&info1, .size = sizeof(*info1)},
> +		{}
> +	}
> +};
> 
> -- 
> 2.50.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
