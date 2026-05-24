Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06D7CD5BB1
	for <ltp@archiver.kernel.org>; Sun, 24 May 2026 18:17:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF44B3E9E44
	for <ltp@archiver.kernel.org>; Sun, 24 May 2026 20:17:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD7593C74EF
 for <ltp@lists.linux.it>; Sun, 24 May 2026 20:16:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D5ED81400167
 for <ltp@lists.linux.it>; Sun, 24 May 2026 20:16:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 20D4C6B702;
 Sun, 24 May 2026 18:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779646605;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+P6JairdPflhfP2Wc1aKVaso0K0YdWNwL7Z4T8RouMs=;
 b=V8qn250n2XKfjdLGnGtTheyJ1vo56/kkn3Xn/NaIpXDfLkKg9/F8wwzV4vA13rrGtFHqr1
 ztHdiZnOwxLc+ty0RpesgrGFARsxutIt87WD7tJ/T9PnU31N13fNk+L+F2PZudAYI/Ku/X
 7YwNlikziIyscn7My5BnNYRdgjHFWoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779646605;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+P6JairdPflhfP2Wc1aKVaso0K0YdWNwL7Z4T8RouMs=;
 b=mBiv9WaVoe+bOSbuHGbt7zGXgu41O+piqUKONFP/7fhbDVnozeojoh0s9Bv61NwZtYLTIP
 KdQK8KUDEgkZ+tAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=V8qn250n;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mBiv9WaV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779646605;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+P6JairdPflhfP2Wc1aKVaso0K0YdWNwL7Z4T8RouMs=;
 b=V8qn250n2XKfjdLGnGtTheyJ1vo56/kkn3Xn/NaIpXDfLkKg9/F8wwzV4vA13rrGtFHqr1
 ztHdiZnOwxLc+ty0RpesgrGFARsxutIt87WD7tJ/T9PnU31N13fNk+L+F2PZudAYI/Ku/X
 7YwNlikziIyscn7My5BnNYRdgjHFWoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779646605;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+P6JairdPflhfP2Wc1aKVaso0K0YdWNwL7Z4T8RouMs=;
 b=mBiv9WaVoe+bOSbuHGbt7zGXgu41O+piqUKONFP/7fhbDVnozeojoh0s9Bv61NwZtYLTIP
 KdQK8KUDEgkZ+tAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C01D7597FD;
 Sun, 24 May 2026 18:16:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oNUxKIxAE2owNgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Sun, 24 May 2026 18:16:44 +0000
Date: Sun, 24 May 2026 20:16:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Message-ID: <20260524181639.GA26213@pevik>
References: <20260523101749.27657-1-sebastian.chlad@suse.com>
 <20260523165718.26187-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260523165718.26187-1-sebastian.chlad@suse.com>
X-Rspamd-Queue-Id: 20D4C6B702
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] io_uring/pintheft: Add CVE-2026-43494
 regression test
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sebastian,

> Test for PinTheft (CVE-2026-43494), fixed by:
> e17492979319 ("net/rds: reset op_nents when zerocopy page pin fails")

Thanks you!

> The bug is in the RDS zerocopy send error path: when pinning user pages
> for zerocopy send fails partway through, the error cleanup drops a page
> reference that the RDS message cleanup will drop again. Combined with
> io_uring fixed buffer registrations, this double-drop drains the
> FOLL_PIN counter and causes a page-cache overwrite exploitable for local
> privilege escalation (PinTheft).

...
> +static void setup(void)
> +{
> +	struct io_uring_params params = {};
> +	struct iovec fixed_iov;
> +	int val;
> +
> +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
> +	io_uring_setup_supported_by_kernel();
> +
> +	/*
> +	 * The exploit primitive keeps one fixed-buffer registration alive and
> +	 * clones it to another ring.
> +	 */
> +	ring_fd1 = io_uring_setup(1, &params);
> +	if (ring_fd1 < 0)
> +		tst_brk(TBROK | TERRNO, "io_uring_setup() failed for first ring");
> +
> +	memset(&params, 0, sizeof(params));
> +
> +	ring_fd2 = io_uring_setup(1, &params);
> +	if (ring_fd2 < 0)
> +		tst_brk(TBROK | TERRNO, "io_uring_setup() failed for second ring");
> +
> +	rds_fd = socket(AF_RDS, SOCK_SEQPACKET | SOCK_CLOEXEC, 0);
> +	if (rds_fd < 0) {
> +		if (errno == EAFNOSUPPORT || errno == ESOCKTNOSUPPORT ||
> +		    errno == EPROTONOSUPPORT || errno == ENOPROTOOPT)
> +			tst_brk(TCONF | TERRNO, "RDS is not available");
> +
> +		tst_brk(TBROK | TERRNO, "socket(AF_RDS) failed");

Just a quick Sunday evening comment (not yet looking into the reproducer itself).
I wonder if we need this complicated check when we already have kconfig based
checks at the end. Could we just simply use SAFE_SOCKET() here? Or have you
encountered problems with older kernels?

And I haven't found any sysctl check (it's just a kernel module), which would be
then part of lib/tst_kconfig.c.

> +	}
> +
> +	/* PinTheft uses the RDS TCP transport, so base RDS is not enough. */
> +	val = RDS_TRANS_TCP;
> +	TEST(setsockopt(rds_fd, SOL_RDS, SO_RDS_TRANSPORT, &val, sizeof(val)));
> +
> +	if (TST_RET) {
> +		if (TST_ERR == ENOPROTOOPT || TST_ERR == EINVAL)
> +			tst_brk(TCONF | TERRNO, "RDS TCP transport is not available");
> +
> +		tst_brk(TBROK | TERRNO, "setsockopt(SO_RDS_TRANSPORT) failed");
And the same here just SAFE_SETSOCKOPT() ?
> +	}
...
> +	/*
> +	 * Register only the first page as an io_uring fixed buffer. This creates
> +	 * the long-term page pin whose reference accounting the RDS bug damages.
> +	 */
> +	if (io_uring_register(ring_fd1, IORING_REGISTER_BUFFERS, &fixed_iov, 1))
> +		tst_brk(TBROK | TERRNO, "IORING_REGISTER_BUFFERS failed");
> +
> +	buffer_registered = 1;
> +
> +	/*
> +	 * Clone the fixed buffer registration into the second ring, matching the
> +	 * public reproducer's lifetime pattern without performing the later
> +	 * page-cache overwrite stage.
> +	 */
> +	if (clone_buffers(ring_fd2, ring_fd1)) {
> +		if (errno == EINVAL || errno == EOPNOTSUPP)
> +			tst_brk(TCONF | TERRNO, "IORING_REGISTER_CLONE_BUFFERS is not supported");
Also here do we need it? IMHO CONFIG_IO_URING should be enough.
And if errno is really needed, it'd IMHO be better to be in handled in
clone_buffers(), not separately.

> +
> +		tst_brk(TBROK | TERRNO, "IORING_REGISTER_CLONE_BUFFERS failed");
> +	}
...
> +	/* Mirror the public PoC trigger: RDS zerocopy over TCP. */
> +	val = 1;
> +	if (setsockopt(rds_fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val))) {
> +		if (errno == ENOPROTOOPT || errno == EINVAL)
> +			tst_brk(TCONF | TERRNO, "SO_ZEROCOPY not supported on RDS sockets");
And here I'd also simplify with SAFE_SETSOCKOPT().
> +		tst_brk(TBROK | TERRNO, "setsockopt(SO_ZEROCOPY) failed");
> +	}
...
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.timeout = 60,
> +	.forks_child = 1,
> +	.taint_check = TST_TAINT_W | TST_TAINT_D,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_RDS",
> +		"CONFIG_RDS_TCP",
CONFIG_RDS_TCP implies CONFIG_RDS.

Kind regards,
Petr

> +		"CONFIG_IO_URING",
> +		NULL
> +	},
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"/proc/sys/kernel/io_uring_disabled", "0",
> +			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
> +		{}
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "e17492979319"},
> +		{"CVE", "2026-43494"},
> +		{}
> +	}
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
