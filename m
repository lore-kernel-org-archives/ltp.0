Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842AACCA470
	for <ltp@archiver.kernel.org>; Wed,  8 Oct 2025 10:02:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2A373CE6F7
	for <ltp@archiver.kernel.org>; Wed,  8 Oct 2025 12:02:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C59C3C9B2B
 for <ltp@lists.linux.it>; Wed,  8 Oct 2025 12:02:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5373C1400C48
 for <ltp@lists.linux.it>; Wed,  8 Oct 2025 12:02:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3E2E51F792;
 Wed,  8 Oct 2025 10:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759917728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X/acn4urQ/YTf2qQbLvtI3EboFLtr1AbyAY9w5r3BxE=;
 b=e9kQvz3BUe/9d7eRUdewSuHdUKYYazDm6WY29MWQGC7ZqCr/QuAjmw/Pgei/E5s+6n+E8m
 KFPG9G45mMltB+T5XV/PSVUSi0aLDquQolIdQou0rLhfDL6TpI0faN+z0wdYlK+gIsjWMD
 w81sA8CPNtXRX2YpOrDpzaIAWmaASwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759917728;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X/acn4urQ/YTf2qQbLvtI3EboFLtr1AbyAY9w5r3BxE=;
 b=EpyBLguFe1bkaHwtAJNJ1uWhwMIsP1IM2zTptUi6qJlo7yA9KP5Nrk8g6iFeel26g786YD
 Bh+eBfNbJ6h7WGBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=e9kQvz3B;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EpyBLguF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759917728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X/acn4urQ/YTf2qQbLvtI3EboFLtr1AbyAY9w5r3BxE=;
 b=e9kQvz3BUe/9d7eRUdewSuHdUKYYazDm6WY29MWQGC7ZqCr/QuAjmw/Pgei/E5s+6n+E8m
 KFPG9G45mMltB+T5XV/PSVUSi0aLDquQolIdQou0rLhfDL6TpI0faN+z0wdYlK+gIsjWMD
 w81sA8CPNtXRX2YpOrDpzaIAWmaASwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759917728;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X/acn4urQ/YTf2qQbLvtI3EboFLtr1AbyAY9w5r3BxE=;
 b=EpyBLguFe1bkaHwtAJNJ1uWhwMIsP1IM2zTptUi6qJlo7yA9KP5Nrk8g6iFeel26g786YD
 Bh+eBfNbJ6h7WGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30FD413A96;
 Wed,  8 Oct 2025 10:02:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 60iCCqA25mgHDAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 08 Oct 2025 10:02:08 +0000
Date: Wed, 8 Oct 2025 12:02:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aOY20kqNr9kZAPuY@yuki.lan>
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
 <20251007-xattrat-v2-10-bf458fa66358@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251007-xattrat-v2-10-bf458fa66358@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 3E2E51F792
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 10/10] Add setxattrat02 test
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
> +} tcases[] = {
> +	{
> +		.dfd = &invalid_fd,
> +		.args = &args,
> +		.args_size = sizeof(struct xattr_args),
> +		.exp_errno = EBADF,
> +		.reason = "Invalid directory file descriptor",
> +	},

Maybe it would make sense to use tst_fd to hammer the syscall with all
kinds of strange file descriptors.

> +	{
> +		.dfd = &tmpdir_fd,
> +		.at_flags = -1,
> +		.args = &args,
> +		.args_size = sizeof(struct xattr_args),
> +		.exp_errno = EINVAL,
> +		.reason = "Invalid AT flags",
> +	},
> +	{
> +		.dfd = &tmpdir_fd,
> +		.at_flags = AT_SYMLINK_NOFOLLOW + 1,
> +		.args = &args,
> +		.args_size = sizeof(struct xattr_args),
> +		.exp_errno = EINVAL,
> +		.reason = "Out of bound AT flags",
> +	},
> +	{
> +		.dfd = &tmpdir_fd,
> +		.args = &null_args,
> +		.args_size = sizeof(struct xattr_args),
> +		.exp_errno = EINVAL,
> +		.reason = "Invalid arguments",
> +	},
> +	{
> +		.dfd = &tmpdir_fd,
> +		.args = &args,
> +		.args_size = SIZE_MAX,
> +		.exp_errno = E2BIG,
> +		.reason = "Arguments size is too big",
> +	},
> +	{
> +		.dfd = &tmpdir_fd,
> +		.args = &args,
> +		.args_size = sizeof(struct xattr_args) - 1,
> +		.exp_errno = EINVAL,
> +		.reason = "Invalid arguments size",
> +	},
> +};
> +
> +static void run(unsigned int i)
> +{
> +	struct tcase *tc = &tcases[i];
> +
> +	args->flags = XATTR_CREATE;
> +	args->value = (uint64_t)XATTR_TEST_VALUE;
> +	args->size = XATTR_TEST_VALUE_SIZE;
> +
> +	TST_EXP_FAIL(tst_syscall(__NR_setxattrat,
> +		tc->dfd, FNAME, tc->at_flags, XATTR_TEST_KEY,
> +		tc->args, tc->args_size),
> +		tc->exp_errno, "%s", tc->reason);
> +}
> +
> +static void setup(void)
> +{
> +	char *tmpdir;
> +
> +	tmpdir = tst_tmpdir_path();
> +	tmpdir_fd = SAFE_OPEN(tmpdir, O_DIRECTORY);

Here as well, just use AT_FDCWD.

> +	SAFE_TOUCH(FNAME, 0777, NULL);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (tmpdir_fd != -1)
> +		SAFE_CLOSE(tmpdir_fd);
> +
> +	SAFE_UNLINK(FNAME);
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.bufs = (struct tst_buffers []) {
> +		{&args, .size = sizeof(struct xattr_args)},
> +		{},
> +	}
> +};
> 
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
