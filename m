Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BE6C7EE31
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 09:11:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0005F3C7438
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 11:11:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C46D3C3070
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 11:11:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1284660005C
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 11:11:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC3C91F387;
 Fri, 27 Jun 2025 09:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751015481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B37kP2t7Veie8UkSpM/RMyhxc3r5J7tgdfv9y2d26eY=;
 b=U6Z1DNt8wLWEMBe/7Me6jBKtKFimD4pGCuQud2lPAmvLE3Y8mdbAyFsQBMJxIbKfIhZeJ6
 8FyIdfgZk4T8DDQucFkgdZnYdDUy3RaLr6NO4QTrrViLGJIhwFbnfCxwojBdN8c5I21pdA
 YOoP7YlB91a/DoBf5cC4JgDKBwzUhAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751015481;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B37kP2t7Veie8UkSpM/RMyhxc3r5J7tgdfv9y2d26eY=;
 b=vhwAD2IoTZSncGypc8dyBsNE0mMGwY6bniDTsO2ad7yhKYohFQDHXydv77oFH83qDg0XwY
 AiLRmCyUM5RcqDDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751015481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B37kP2t7Veie8UkSpM/RMyhxc3r5J7tgdfv9y2d26eY=;
 b=U6Z1DNt8wLWEMBe/7Me6jBKtKFimD4pGCuQud2lPAmvLE3Y8mdbAyFsQBMJxIbKfIhZeJ6
 8FyIdfgZk4T8DDQucFkgdZnYdDUy3RaLr6NO4QTrrViLGJIhwFbnfCxwojBdN8c5I21pdA
 YOoP7YlB91a/DoBf5cC4JgDKBwzUhAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751015481;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B37kP2t7Veie8UkSpM/RMyhxc3r5J7tgdfv9y2d26eY=;
 b=vhwAD2IoTZSncGypc8dyBsNE0mMGwY6bniDTsO2ad7yhKYohFQDHXydv77oFH83qDg0XwY
 AiLRmCyUM5RcqDDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC1C5138A7;
 Fri, 27 Jun 2025 09:11:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3/3jLDlgXmjuZwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 27 Jun 2025 09:11:21 +0000
Date: Fri, 27 Jun 2025 11:11:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aF5gXnHipDoPXla6@yuki.lan>
References: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
 <20250626-ioctl_pidfd_suite-v1-4-165b9abf0296@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250626-ioctl_pidfd_suite-v1-4-165b9abf0296@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/6] Add ioctl_pidfd02 test
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
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 7f6312ce5fa241a778d8dda7f8ee9edd0a8800e6..23f335846663d62a39e6de3a8f6948c1b0acf8a5 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -613,6 +613,7 @@ ioctl_ficlonerange02 ioctl_ficlonerange02
>  ioctl_fiemap01 ioctl_fiemap01
>  
>  ioctl_pidfd01 ioctl_pidfd01
> +ioctl_pidfd02 ioctl_pidfd02
>  
>  inotify_init1_01 inotify_init1_01
>  inotify_init1_02 inotify_init1_02
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
> index 0000000000000000000000000000000000000000..82dd8c359938cdc7bf69cc2fd6afc90ce2a95290
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Check if the ioctl() function allows retrieval of a child's exit code
> + * using PIDFD_INFO_EXIT from a process that is isolated from the child.
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/pidfd.h"
> +#include "lapi/sched.h"
> +
> +static struct tst_clone_args *args;
> +static struct pidfd_info *info;
> +
> +static void run(void)
> +{
> +	int status;
> +	int pidfd = 0;
> +	pid_t pid_child;
> +
> +	memset(args, 0, sizeof(struct tst_clone_args));
> +
> +	args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
> +	args->pidfd = (uint64_t)&pidfd;
> +	args->exit_signal = SIGCHLD;
> +
> +	pid_child = SAFE_CLONE(args);
> +	if (!pid_child) {
> +		TST_CHECKPOINT_WAIT(0);
> +		exit(100);
> +	}
> +
> +	/* child is not reaped, so ioctl() will pass */
> +	info->mask = 0;
> +	SAFE_IOCTL(pidfd, PIDFD_GET_INFO, info);


It will pass and:

- fill in some fields unconditionally
 - if PIDFD_INFO_CREDS is set the info.*{uid,gid} should be checked
 - if PIDFD_INFO_PID is set the info.*pid should be checked
 - if PIDFD_INFO_CGROUPID is set the info.cgroupid will be also set

- the PIDFD_INFO_EXIT flag will not be set before the process did exit



> +	TST_CHECKPOINT_WAKE(0);
> +	SAFE_WAITPID(pid_child, &status, 0);
> +
> +	/* child is now reaped, so we can ask for the exit status */
> +	info->mask = PIDFD_INFO_EXIT;
> +	SAFE_IOCTL(pidfd, PIDFD_GET_INFO, info);
> +
> +	TST_EXP_EQ_LI(info->mask & PIDFD_INFO_EXIT, PIDFD_INFO_EXIT);
> +	TST_EXP_EQ_LI(WIFEXITED(info->exit_code), WIFEXITED(status));
> +	TST_EXP_EQ_LI(WEXITSTATUS(info->exit_code), WEXITSTATUS(status));

And here we should check that we got the same fields set as in the
previous case when the process was still running plus the exit_code.

I suppose that we will need two info structures so that we can do the
comparsion. Also it wouldn't harm to clear the structures with memset
before use.

> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +	.min_kver = "6.15",
> +	.bufs = (struct tst_buffers []) {
> +		{&args, .size = sizeof(*args)},
> +		{&info, .size = sizeof(*info)},
> +		{}
> +	}
> +};
> 
> -- 
> 2.50.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
