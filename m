Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4ABC8303C
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 13:16:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAF2A3C9939
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 15:16:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E71C3C282E
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 15:15:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8196360069F
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 15:15:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A96221166;
 Mon,  7 Jul 2025 13:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751894146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+l46Xw4YvsppOkbZO/22qPgtRd7Zs0+BFdM5LEMuKr0=;
 b=BMoqc5yNpjVhkaSwpfDhvwSLnv0/MzN5DAPIh+i/TLTaaSkxG9NWQY2Sh5m4qg85Ajy0wV
 nuM1fb5aE5FrQHYQzEfRA2SQ996S8IJhXJRxASQNIHA1KRw46qecpsLDMeeLl2LrHcxO8/
 N3eHGTNtQ5ne8tmb/eXMgg1FwkhXZIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751894146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+l46Xw4YvsppOkbZO/22qPgtRd7Zs0+BFdM5LEMuKr0=;
 b=g3+AOtumv6Mf8SPxckEno4+lcyH/96f3EQ2uFnD/Jvbf26QncGKZywRFQYeFl2gLmFF5JX
 AdObemHKG/tWp8DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751894146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+l46Xw4YvsppOkbZO/22qPgtRd7Zs0+BFdM5LEMuKr0=;
 b=BMoqc5yNpjVhkaSwpfDhvwSLnv0/MzN5DAPIh+i/TLTaaSkxG9NWQY2Sh5m4qg85Ajy0wV
 nuM1fb5aE5FrQHYQzEfRA2SQ996S8IJhXJRxASQNIHA1KRw46qecpsLDMeeLl2LrHcxO8/
 N3eHGTNtQ5ne8tmb/eXMgg1FwkhXZIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751894146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+l46Xw4YvsppOkbZO/22qPgtRd7Zs0+BFdM5LEMuKr0=;
 b=g3+AOtumv6Mf8SPxckEno4+lcyH/96f3EQ2uFnD/Jvbf26QncGKZywRFQYeFl2gLmFF5JX
 AdObemHKG/tWp8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6623213757;
 Mon,  7 Jul 2025 13:15:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rgePF4LIa2iJFgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 07 Jul 2025 13:15:46 +0000
Date: Mon, 7 Jul 2025 15:16:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aGvIp2YEPoJOhnjY@yuki.lan>
References: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
 <20250704-ioctl_pidfd_suite-v2-7-88a6466d9f62@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250704-ioctl_pidfd_suite-v2-7-88a6466d9f62@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 7/8] Add ioctl_pidfd05 test
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
> +	int pidfd = 0;
> +	pid_t pid_child;
> +
> +	memset(args, 0, sizeof(struct tst_clone_args));
> +
> +	info_invalid->dummy = 1;
> +
> +	args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
> +	args->pidfd = (uint64_t)&pidfd;
> +	args->exit_signal = SIGCHLD;
> +
> +	pid_child = SAFE_CLONE(args);
> +	if (!pid_child)
> +		exit(0);
> +
> +	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, NULL), EINVAL);
> +	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid), EINVAL);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.forks_child = 1,
> +	.min_kver = "6.15",

If I'm looking right PIDFD_INFO has been added to 6.13. So in this case
I would allow the call to fail with ENOTTY before 6.13 instead.

> +	.bufs = (struct tst_buffers []) {
> +		{&args, .size = sizeof(*args)},
> +		{&info_invalid, .size = sizeof(*info_invalid)},
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
