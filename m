Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873C0CCF2D6
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 11:20:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD3F53E9ADA
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 13:20:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F22163E28ED
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 13:20:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6FEF16007A2
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 13:20:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C2D2221C15;
 Mon, 19 Oct 2026 11:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792408822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mCrFonIXKnHaGzM6GTBFOmoSXUrE3vyHkhKoPOQ6fNk=;
 b=skPd4LMpGp1g1nrPGfU5Mc4Q02WG29hrTX9zjDS30iInIPB5wF5ptE3zj+rG8AerCAW6Zt
 1K+jhN+rN8eY7b/ab5Z++gr6mscFVGzb4wAExXz7cq7PYaOEz42Dg2l9lpKtSfyPFERVUC
 F3bKd03233t2IYqBafINlr+r2es1EhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792408822;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mCrFonIXKnHaGzM6GTBFOmoSXUrE3vyHkhKoPOQ6fNk=;
 b=L0mHXccGyx65b/kNEkdhbFOYGT9xY0rpFiuzPe+DUmp19nojW7m/ufyu+sCDpdY1eMLcFv
 yr0BdutxSzgkP8Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792408822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mCrFonIXKnHaGzM6GTBFOmoSXUrE3vyHkhKoPOQ6fNk=;
 b=skPd4LMpGp1g1nrPGfU5Mc4Q02WG29hrTX9zjDS30iInIPB5wF5ptE3zj+rG8AerCAW6Zt
 1K+jhN+rN8eY7b/ab5Z++gr6mscFVGzb4wAExXz7cq7PYaOEz42Dg2l9lpKtSfyPFERVUC
 F3bKd03233t2IYqBafINlr+r2es1EhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792408822;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mCrFonIXKnHaGzM6GTBFOmoSXUrE3vyHkhKoPOQ6fNk=;
 b=L0mHXccGyx65b/kNEkdhbFOYGT9xY0rpFiuzPe+DUmp19nojW7m/ufyu+sCDpdY1eMLcFv
 yr0BdutxSzgkP8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94ED4134B3;
 Mon, 19 Oct 2026 11:20:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DPqvGvb81WrRIAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 19 Oct 2026 11:20:22 +0000
Date: Mon, 19 Oct 2026 13:20:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wake Liu <wakel@google.com>
Message-ID: <atX9BkzCNAyth6hm@yuki.lan>
References: <20261014093618.1475191-1-wakel@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261014093618.1475191-1-wakel@google.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] swapon04: Report TCONF when SELinux denies loop
 device I/O
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
> +/*
> + * Kernels without commit f2fed441c69b ("loop: stop using
> + * vfs_iter_{read,write} for buffered I/O") access the backing file through
> + * vfs_iter_{read,write}(), which run LSM permission checks with the
> + * credentials of the loop worker kernel thread. Strict SELinux policies,
> + * such as Android's, do not allow the kernel to access the unlabeled files
> + * on the freshly formatted test filesystem, so any I/O on the loop device
> + * fails with EIO.
> + */
> +static void check_loop_io(void)
> +{
> +	char buf[512];
> +	int fd;
> +
> +	fd = SAFE_OPEN(loop_dev, O_RDONLY);
> +	TEST(read(fd, buf, sizeof(buf)));
> +	SAFE_CLOSE(fd);
> +
> +	if (TST_RET == (long)sizeof(buf))
> +		return;
> +
> +	if (TST_RET == -1 && TST_ERR == EIO && tst_selinux_enforcing())
> +		tst_brk(TCONF | TTERRNO, "I/O on %s is likely denied by SELinux", loop_dev);

If nothing else we whould check for the selinux as a first thing in the
function.

	if (!tst_selinux_enforcing())
		return;

	fd = SAFE_OPEN(loop_dev, ...);
	...

And the check should be skipped on 6.15 and newer, where this problem
does not happen.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
