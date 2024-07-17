Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3850C3DA4B
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 13:22:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 523083D0C85
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 15:22:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 354433D0C85
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 15:21:55 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 28A1B140BB60
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 15:21:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7BCDE1FB80;
 Wed, 17 Jul 2024 13:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721222513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bLeJY7+WEb98X1mWnSdh0JIRHRD8EAAPIsodwos6Z1k=;
 b=My9Oca1aA+JBFeo/A4+eADdhiQhxoJNobnkD9wd4RjLc+MoV4vrFzvgZcqQRTaL5ujsnhP
 u1yFWDjJVxhcfWv463oBcdpCbXW3xPfDMwcpnu9iQeH9oD/GI+jx8EGx649yOtj35qpHfF
 NOzSfbD0VBYA1nSEIgcVKoEF1XVdU3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721222513;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bLeJY7+WEb98X1mWnSdh0JIRHRD8EAAPIsodwos6Z1k=;
 b=F1e+0gmtuBwOqBxUooYBNJ4D1LTLSeRvkm5OjRGQRv1j1xd17cjSy0HZ8fatbxcL2iGemk
 2hOck8HfpC0FemDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=f3QOcUbf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Sz6+kXHQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721222512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bLeJY7+WEb98X1mWnSdh0JIRHRD8EAAPIsodwos6Z1k=;
 b=f3QOcUbfegQocm435evMtVI5aDCsMWlMIv+dqpqxX+5S8E0Jawy39xtx1YNHuoQyXQg7Rf
 5wrXRc2ASYORTNeLlvgwejaiKWqwx+k5TCKUuidt2WY1msgOQcZtmFT2f3wFcFlAKryIUc
 q3Fux4W6IZg/CZPtoT69gn6OEOeWT0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721222512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bLeJY7+WEb98X1mWnSdh0JIRHRD8EAAPIsodwos6Z1k=;
 b=Sz6+kXHQzMhMiStIu6Jrqgt8HZ5TGjAu4yogzLVsu/oWLr/hY7YsAw5gGeCuUHZkCI1UAY
 GEDP0Ynd7Opqe0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67450136E5;
 Wed, 17 Jul 2024 13:21:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KGM1GHDFl2aNbwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Jul 2024 13:21:52 +0000
Date: Wed, 17 Jul 2024 15:24:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZpfGCTTX4BtnKf34@rei>
References: <20240522-process_mrelease-v1-0-41fe2fa44194@suse.com>
 <20240522-process_mrelease-v1-3-41fe2fa44194@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240522-process_mrelease-v1-3-41fe2fa44194@suse.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7BCDE1FB80
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] Add process_mrelease02 test
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

On Wed, May 22, 2024 at 04:33:07PM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> This test verifies that process_mrelease() syscall correctly raises
> the errors.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                                   |  1 +
>  .../kernel/syscalls/process_mrelease/.gitignore    |  1 +
>  .../syscalls/process_mrelease/process_mrelease02.c | 75 ++++++++++++++++++++++
>  3 files changed, 77 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 46a85fd31..c2fe919f0 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1051,6 +1051,7 @@ preadv203_64 preadv203_64
>  profil01 profil01
>  
>  process_mrelease01 process_mrelease01
> +process_mrelease02 process_mrelease02
>  
>  process_vm_readv01 process_vm01 -r
>  process_vm_readv02 process_vm_readv02
> diff --git a/testcases/kernel/syscalls/process_mrelease/.gitignore b/testcases/kernel/syscalls/process_mrelease/.gitignore
> index 673983858..f1e7a8fea 100644
> --- a/testcases/kernel/syscalls/process_mrelease/.gitignore
> +++ b/testcases/kernel/syscalls/process_mrelease/.gitignore
> @@ -1 +1,2 @@
>  /process_mrelease01
> +/process_mrelease02
> diff --git a/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c b/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c
> new file mode 100644
> index 000000000..ac13317ee
> --- /dev/null
> +++ b/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that process_mrelease() syscall is raising errors:
> + * * EBADF when a bad file descriptor is given
> + * * EINVAL when flags is not zero
> + * * EINVAL when memory of a task cannot be released because it's still running
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +static int badfd = -1;
> +static int pidfd;
> +
> +static struct tcase {
> +	int needs_child;
> +	int *fd;
> +	int flags;
> +	int exp_errno;
> +	char *msg;
> +} tcases[] = {
> +	{0, &badfd,  0, EBADF,  "bad file descriptor"},
> +	{1, &pidfd, -1, EINVAL, "flags is not 0"},
> +	{1, &pidfd,  0, EINVAL,  "memory of running task cannot be released"},

We can easily trigger ESCHR as well, just fork a child that just exits,
get pidfd to that child and then wait the child.

> +};
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	if (tc->needs_child) {
> +		pid_t pid;
> +
> +		pid = SAFE_FORK();
> +		if (!pid) {
> +			tst_res(TINFO, "Keep child alive");
> +
> +			TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +			exit(0);
> +		}
> +
> +		TST_CHECKPOINT_WAIT(0);
> +
> +		pidfd = SAFE_PIDFD_OPEN(pid, 0);
> +	}

We can set up several types of a child processes in the test setup,
there is no need to do this on every iteration.

Similarily for the ESCHR case we can just do the same for EINVAL cases.
For the invalid flags we would need a process that did actually exit but
wasn't waited for. And for the second EINVAL case we would need a
running process, so perhaps just a child that sleeps in pause().

> +	TST_EXP_FAIL(tst_syscall(__NR_process_mrelease, *tc->fd, tc->flags),
> +		tc->exp_errno,
> +		"%s", tc->msg);
> +
> +	if (tc->needs_child) {
> +		SAFE_CLOSE(pidfd);
> +
> +		TST_CHECKPOINT_WAKE(0);
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.min_kver = "5.15",
> +	.needs_checkpoints = 1,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_MMU=y",

I do not think this is necessary, LTP does not run on non-MMU targets
anyways.

> +		NULL,
> +	},
> +};

Also I think that it would make sense to CC Michal Hocko on the v2 since
he did review the kernel patches for this syscall.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
