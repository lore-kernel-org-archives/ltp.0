Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EFBC5B56A
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 17:15:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A727A3D046F
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 19:15:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DB9A3CC174
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 19:14:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B726F6002C6
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 19:14:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3C36380F0A;
 Mon, 10 Aug 2026 17:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786382079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gyljK6+28ca+nNLJjvuOx2hseC/0VvRxSxV892v/9jE=;
 b=IILO9Nl18myMKcKD2h1V3qeMtIPkXGRNtQOFDmsNNXaYlI8R/zzU6ImjE/G96zAOeCzEFi
 9CIBnrQYTqwCGPr7JziTBsXWRG4K68PXyAuGedyCEPz4KLrIFV+6h11d4qAOeUB+9RlNpg
 QAP+j/eCeQ/hWrj/fo0vNkeXaiIjCuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786382079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gyljK6+28ca+nNLJjvuOx2hseC/0VvRxSxV892v/9jE=;
 b=yrtsilpomNnwpNsgtlHNRXzjQjWR35LI6EWKTQZAbOc6YYE0PCERu8x96s0mjBP2fCQJua
 NUeBwUGJHwuekfAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gq1M3uZS;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=H2ZNPJK6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786382075;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gyljK6+28ca+nNLJjvuOx2hseC/0VvRxSxV892v/9jE=;
 b=gq1M3uZS4Op583GhY4dpDzE3Ms1d4IPbuUIlXur+1bjYm6wBW8av7XbHS84ngxUHaW2eKK
 duwTCWCSo9EKmo7FuFiVyD8uFWTaGvVMXpENQ353IxbGTNw3kNwK57znVcRdm+T3JSrOm/
 luutB3wQlj+9sJQ6PRjBH2/Wq+VwEwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786382075;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gyljK6+28ca+nNLJjvuOx2hseC/0VvRxSxV892v/9jE=;
 b=H2ZNPJK6sxJPnZA+xv4A0WM1ZvzarBI5LxR0yE2yByakBFJdMuxV04ScJFuyUBpGZ8WINi
 ymq7Gx+BbHqx8FCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13338779B2;
 Mon, 10 Aug 2026 17:14:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ll80A/sGemp5cgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 17:14:35 +0000
Date: Mon, 10 Aug 2026 19:14:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260810171429.GC1049677@pevik>
References: <20260810-shell_oom_protection-v4-1-4dac0dbb0414@suse.com>
 <20260810131014.85243-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260810131014.85243-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 TAGGED_RCPT(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 3C36380F0A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shell: enable OOM protection by default
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Hi Andrea,

> On Aug 10, 2026, Andrea Cervesato wrote:
> > shell: enable OOM protection by default

> > +	if ! echo "$value" > "$path"; then
> > +		tst_res TWARN "Can't adjust score"
> > +	fi

> Could this avoid reporting TWARN when CAP_SYS_RESOURCE is absent, as
> tst_memutils.c does? Lowering oom_score_adj requires that capability, so
> every unprivileged shell test now gets a warning result. The new self-test
> itself reports TCONF but exits 36 because this TWARN remains counted.

Ah, this really needs to be guarded behind  if [ "$(id -ru)" != 0 ]; then 

If you're in a mood for it, you could factor out [ "$(id -ru)" != 0 ] check into
it's own function tst_check_root or tst_is_root which would be then used in
tst_require_root and in this function.

I repeat my suggestion from last revision: add a helper into testcases/lib which
will just call C function. That way the behavior will be the same (use
capabilities). That would be more clearer solution.

Kind regards,
Petr

> > +	(
> > +		TST_CHILD=1
> > +		_tst_disable_oom_protection
> > +		trap '_tst_cleanup_timer; _tst_write_results' EXIT
> > +
> > +		if [ "$TST_ALL_FILESYSTEMS" = 1 ]; then
> > +			_tst_run_tcases_per_fs
> > +		else
> > +			_tst_run_iterations
> > +		fi
> > +	) &
> > +
> > +	wait $!
> > +	ret=$?

> How can the protected parent perform cleanup if this child is OOM-killed
> or times out? TST_DO_CLEANUP and TST_MOUNT_FLAG are set only in the
> subshell. On an abnormal child exit, the parent therefore reports TBROK
> without calling TST_CLEANUP or unmounting a device mounted by
> _prepare_device(), leaving external test state behind.

Sounds serious :). I'll comment on the patch itself.

Kind regards,
Petr

> Verdict - Needs revision

> ---
> Note:

> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.

> Regards,
> LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
