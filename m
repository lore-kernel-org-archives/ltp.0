Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0149BCFB444
	for <ltp@archiver.kernel.org>; Mon,  7 Oct 2024 15:05:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF9423C63C5
	for <ltp@archiver.kernel.org>; Mon,  7 Oct 2024 17:05:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 279023C1D06
 for <ltp@lists.linux.it>; Mon,  7 Oct 2024 17:04:58 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B57C2600F33
 for <ltp@lists.linux.it>; Mon,  7 Oct 2024 17:04:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4131821B3C;
 Mon,  7 Oct 2024 15:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728313496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hDiWMxDNTtjZESqjgsm0J34q6GQJHh5QVnimEZjK7/k=;
 b=DY0Lr3lMuOgs9DZEnDuDWK8oZc1oXXbefq9KJefHIGieHoY/6x+I4BUFo49Zw2TxiLeGTl
 IdTgZTUNIoyP51ZSHHvNIOSDJa1g6//G5cGku+FEkR6P27KLfuwng9BdR43juR/V2wRNnT
 XnKRUiwDwWwWag/xYsxKr8pt3spSA3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728313496;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hDiWMxDNTtjZESqjgsm0J34q6GQJHh5QVnimEZjK7/k=;
 b=fCujeGPlnJcBAf5ubkH4bzRcuYAbWBp4rJ3QfclJ53l4Nytx4u2eSYNPLqGySy7Idbe0eF
 DY9bwgy+hLMpHVBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DY0Lr3lM;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fCujeGPl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728313496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hDiWMxDNTtjZESqjgsm0J34q6GQJHh5QVnimEZjK7/k=;
 b=DY0Lr3lMuOgs9DZEnDuDWK8oZc1oXXbefq9KJefHIGieHoY/6x+I4BUFo49Zw2TxiLeGTl
 IdTgZTUNIoyP51ZSHHvNIOSDJa1g6//G5cGku+FEkR6P27KLfuwng9BdR43juR/V2wRNnT
 XnKRUiwDwWwWag/xYsxKr8pt3spSA3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728313496;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hDiWMxDNTtjZESqjgsm0J34q6GQJHh5QVnimEZjK7/k=;
 b=fCujeGPlnJcBAf5ubkH4bzRcuYAbWBp4rJ3QfclJ53l4Nytx4u2eSYNPLqGySy7Idbe0eF
 DY9bwgy+hLMpHVBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3208A132BD;
 Mon,  7 Oct 2024 15:04:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0xs0C5j4A2eFCAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 07 Oct 2024 15:04:56 +0000
Date: Mon, 7 Oct 2024 17:03:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZwP4VxOgCOI-BWMw@yuki.lan>
References: <20240812-process_mrelease-v2-0-e61249986a0a@suse.com>
 <20240812-process_mrelease-v2-3-e61249986a0a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240812-process_mrelease-v2-3-e61249986a0a@suse.com>
X-Rspamd-Queue-Id: 4131821B3C
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] Add process_mrelease02 test
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
> +/*\
> + * [Description]
> + *
> + * This test verifies that process_mrelease() syscall is raising errors:
> + * * EBADF when a bad file descriptor is given
> + * * EINVAL when flags is not zero
> + * * EINVAL when memory of a task cannot be released because it's still running
> + * * ESRCH when child has been closed
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +static int badfd = -1;
> +static int pidfd;
> +
> +enum {
> +	NO_CHILD,
> +	EXIT_CHILD,
> +	WAIT_CHILD,
> +};
> +
> +static struct tcase {
> +	int child_type;
> +	int *fd;
> +	int flags;
> +	int exp_errno;
> +	char *msg;
> +} tcases[] = {
> +	{NO_CHILD, &badfd, 0, EBADF, "bad file descriptor"},
> +	{WAIT_CHILD, &pidfd, -1, EINVAL, "flags is not 0"},
> +	{WAIT_CHILD, &pidfd, 0, EINVAL, "task memory cannot be released"},
> +	{EXIT_CHILD, &pidfd, 0, ESRCH, "child is not running"},
> +};
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	int status;
> +
> +	if (tc->child_type != NO_CHILD) {
> +		pid_t pid;
> +
> +		pid = SAFE_FORK();
> +		if (!pid) {
> +			if (tc->child_type == WAIT_CHILD)
> +				TST_CHECKPOINT_WAIT(0);
> +
> +			exit(0);
> +		}
> +
> +		tst_res(TINFO, "Spawned waiting child with pid=%d", pid);
> +
> +		pidfd = SAFE_PIDFD_OPEN(pid, 0);
> +
> +		if (tc->child_type == EXIT_CHILD)
> +			SAFE_WAITPID(pid, &status, 0);
> +	}

Why don't we instead fork two children in the setup, one of the waits
and second exits and just set the pidfd once?

> +	TST_EXP_FAIL(tst_syscall(__NR_process_mrelease, *tc->fd, tc->flags),
> +		tc->exp_errno,
> +		"%s", tc->msg);
> +
> +	if (tc->child_type != NO_CHILD) {
> +		if (tc->child_type == WAIT_CHILD)
> +			TST_CHECKPOINT_WAKE(0);
> +
> +		SAFE_CLOSE(pidfd);
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
> +};
> 
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
