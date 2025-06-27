Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3F2C7EE31
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 09:56:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46EF23C7AB1
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 11:56:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E4E53C1924
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 11:56:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C7D9A1A008AC
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 11:56:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C758621164;
 Fri, 27 Jun 2025 09:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751018163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iVi6nQHhJwm8YwGgLsk4bxaB01qdtGI+ERj8KMjXsns=;
 b=0CBlvhOzOYIfvz68cYVRAozVymxfd6iYF7iqONor4kIVNIgprMUlVL1YEz+6nU4rgYP/qZ
 b49i53Cp2Jhnw+5S2SxxLadXIlMDJLoYnJ8mPnUECuofDoEL/buYES3y/F6oYVD5ZvdUez
 xUF/4J6/blEsYHLIkNpu2BPPdJGe9x8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751018163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iVi6nQHhJwm8YwGgLsk4bxaB01qdtGI+ERj8KMjXsns=;
 b=zCSAvXwmVQURcs4h7uQ3yBwszvZc3xzf2Y/rKD/bDWEUFZlQhKdq3JGrMmiltRzQbtcnjZ
 WCVcEe6phET3WgDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751018163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iVi6nQHhJwm8YwGgLsk4bxaB01qdtGI+ERj8KMjXsns=;
 b=0CBlvhOzOYIfvz68cYVRAozVymxfd6iYF7iqONor4kIVNIgprMUlVL1YEz+6nU4rgYP/qZ
 b49i53Cp2Jhnw+5S2SxxLadXIlMDJLoYnJ8mPnUECuofDoEL/buYES3y/F6oYVD5ZvdUez
 xUF/4J6/blEsYHLIkNpu2BPPdJGe9x8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751018163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iVi6nQHhJwm8YwGgLsk4bxaB01qdtGI+ERj8KMjXsns=;
 b=zCSAvXwmVQURcs4h7uQ3yBwszvZc3xzf2Y/rKD/bDWEUFZlQhKdq3JGrMmiltRzQbtcnjZ
 WCVcEe6phET3WgDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACDFD13786;
 Fri, 27 Jun 2025 09:56:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xITEKLNqXmiZdgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 27 Jun 2025 09:56:03 +0000
Date: Fri, 27 Jun 2025 11:56:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aF5q3GYpIvqI82bZ@yuki.lan>
References: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
 <20250626-ioctl_pidfd_suite-v1-5-165b9abf0296@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250626-ioctl_pidfd_suite-v1-5-165b9abf0296@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/6] Add ioctl_pidfd03 test
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
> +	if (!pid_child)
> +		exit(100);
> +
> +	SAFE_WAITPID(pid_child, &status, 0);
> +
> +	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, info), ESRCH);
> +	TST_EXP_EQ_LI(info->mask & PIDFD_INFO_EXIT, 0);

If I'm reading the kernel code correctly, we should get the same result
even before the pid was waited for, so we may as well do this check
twice, once before the WAITPID() and once after the WAITPID().

> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.forks_child = 1,
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
