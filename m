Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F423EFF8855
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 14:13:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DF363E6204
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 16:13:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7797A3CF054
 for <ltp@lists.linux.it>; Tue,  5 May 2026 16:12:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 215272001B3
 for <ltp@lists.linux.it>; Tue,  5 May 2026 16:12:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 451D76A9ED;
 Tue,  5 May 2026 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777990359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xuRm+RE8KzbqTpVAwtgthb/LyAnqx82VN4Vq5DSUrE=;
 b=Ujl007UpsUMbk50iqB9OeUnknwJ7xaLqAVswx9mil+RwIto0O1QG1XMygoR81ya/GU8++C
 lVV59l4V/zOKibYiwgZz+Dwn/5+xcWdApAE3qw51gkVUiWp3jiQPjBdPZt1XFqT+G0OSeJ
 P+BhM7UXCe8/djMEoVGSgErM/3ickaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777990359;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xuRm+RE8KzbqTpVAwtgthb/LyAnqx82VN4Vq5DSUrE=;
 b=gdEEP6HRE0wlgHKe60wnmT1D/t5s4qq0hBcJti3qxYM1TC1v0QgdtRCQdQ2VPm5i5Prr2B
 QZVGfMiqulaS7hAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ujl007Up;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gdEEP6HR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777990359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xuRm+RE8KzbqTpVAwtgthb/LyAnqx82VN4Vq5DSUrE=;
 b=Ujl007UpsUMbk50iqB9OeUnknwJ7xaLqAVswx9mil+RwIto0O1QG1XMygoR81ya/GU8++C
 lVV59l4V/zOKibYiwgZz+Dwn/5+xcWdApAE3qw51gkVUiWp3jiQPjBdPZt1XFqT+G0OSeJ
 P+BhM7UXCe8/djMEoVGSgErM/3ickaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777990359;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xuRm+RE8KzbqTpVAwtgthb/LyAnqx82VN4Vq5DSUrE=;
 b=gdEEP6HRE0wlgHKe60wnmT1D/t5s4qq0hBcJti3qxYM1TC1v0QgdtRCQdQ2VPm5i5Prr2B
 QZVGfMiqulaS7hAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F849593A3;
 Tue,  5 May 2026 14:12:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id msv+Cdf6+Wm8fAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 05 May 2026 14:12:39 +0000
Date: Tue, 5 May 2026 16:12:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <afn62QQkJgwO28hE@yuki.lan>
References: <20260331220354.297027-1-rbranco@suse.de>
 <20260411094742.219667-1-rbranco@suse.de>
 <20260411094742.219667-2-rbranco@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260411094742.219667-2-rbranco@suse.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 451D76A9ED
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/2] userfaultfd: Add new test using
 UFFDIO_CONTINUE
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
> +static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
> +{
> +	static struct uffd_msg msg;
> +	struct uffdio_continue uffdio_continue = {};
> +	struct pollfd pollfd;
> +	int nready;
> +	char z = 'Z';
> +
> +	pollfd.fd = uffd;
> +	pollfd.events = POLLIN;
> +	nready = poll(&pollfd, 1, -1);
> +	if (nready == -1)
> +		tst_brk(TBROK | TERRNO, "Error on poll");
> +
> +	SAFE_READ(1, uffd, &msg, sizeof(msg));
> +
> +	if (msg.event != UFFD_EVENT_PAGEFAULT)
> +		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
> +
> +	if (!(msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_MINOR)) {
> +		tst_brk(TBROK, "expected MINOR fault, got flags=0x%llx",
                          ^
			  TFAIL

This is clearly a test assertion and thus a test failure.

> +			(unsigned long long)msg.arg.pagefault.flags);
> +	}
> +
> +	/* Update the shmem page in page cache before resuming the fault. */
> +	SAFE_PWRITE(1, memfd, &z, 1, 0);
> +
> +	uffdio_continue.range.start =
> +		msg.arg.pagefault.address & ~((unsigned long)page_size - 1);
> +	uffdio_continue.range.len = page_size;
> +
> +	SAFE_IOCTL(uffd, UFFDIO_CONTINUE, &uffdio_continue);
> +
> +	SAFE_CLOSE(uffd);
> +	return NULL;
> +}
> +
> +static void run(void)
> +{
> +	pthread_t thr;
> +	struct uffdio_api uffdio_api = {};
> +	struct uffdio_register uffdio_register;
> +
> +	set_pages();
> +
> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, true);
> +	uffdio_api.api = UFFD_API;
> +	uffdio_api.features = 0;
> +	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> +	if (!(uffdio_api.features & UFFD_FEATURE_MINOR_SHMEM))
> +		tst_brk(TCONF, "UFFD_FEATURE_MINOR_SHMEM not supported");
> +	SAFE_CLOSE(uffd);
> +
> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
> +
> +	uffdio_api.api = UFFD_API;
> +	uffdio_api.features = UFFD_FEATURE_MINOR_SHMEM;
> +
> +	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> +
> +	uffdio_register.range.start = (unsigned long) page;
> +	uffdio_register.range.len = page_size;
> +	uffdio_register.mode = UFFDIO_REGISTER_MODE_MINOR;
> +
> +	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
> +
> +	/*
> +	 * Drop PTEs while retaining the cached shmem page so the next access
> +	 * faults in MINOR mode.
> +	 */
> +	if (madvise(page, page_size, MADV_DONTNEED) < 0)
> +		tst_brk(TBROK | TERRNO, "madvise MADV_DONTNEED failed");
> +
> +	SAFE_PTHREAD_CREATE(&thr, NULL, (void *) handle_thread, NULL);
> +
> +	char c = page[0];
> +
> +	if (c == 'Z')
> +		tst_res(TPASS, "Pagefault handled via UFFDIO_CONTINUE");
> +	else
> +		tst_res(TFAIL, "pagefault not handled via UFFDIO_CONTINUE, got '%c'", c);
> +
> +	SAFE_PTHREAD_JOIN(thr, NULL);
> +	reset_pages();
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	/*
> +	 * UFFDIO_CONTINUE is available since 5.13 but
> +	 * UFFD_FEATURE_MINOR_SHMEM appeared in 5.14
> +	 */
> +	.min_kver = "5.14",

Should we do a runtime check in the test setup here as well?

> +	.cleanup = reset_pages,
> +};
> -- 
> 2.53.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
