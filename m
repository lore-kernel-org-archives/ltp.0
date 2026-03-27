Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A14710F2847
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 15:46:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E66D13D8BAE
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 16:46:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E2593D0197
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 16:46:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B49631400041
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 16:46:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 18D2C4D321;
 Fri, 27 Mar 2026 15:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774626365;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zNvDWvTs5gokA76mlp6Xv3nT/3ABBuLH22hrucDVTFw=;
 b=Q1Lz47mGmYwOEDN2GP01wR4PllNUUBek0GekwhMBh/q3COeAjytIUFyuOsRe3CryHAyxnB
 aNUwW9CjueDak8yjgOD7SMH/PVlmZMFQG0SwbZPLk8CbKufU51oBIZJPrBYRPWhUMZ/W7q
 EPPTIpXvjwj/WTGLbt3t4X+v1zXuGmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774626365;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zNvDWvTs5gokA76mlp6Xv3nT/3ABBuLH22hrucDVTFw=;
 b=WufjyeiouIUpNxljhOYK8DMRFqUr27LMar5ShL3p/ZtNeNouVUnkruFUUJ/4Qaz9sb1veo
 EGbBXMYsfnf7QfCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774626365;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zNvDWvTs5gokA76mlp6Xv3nT/3ABBuLH22hrucDVTFw=;
 b=Q1Lz47mGmYwOEDN2GP01wR4PllNUUBek0GekwhMBh/q3COeAjytIUFyuOsRe3CryHAyxnB
 aNUwW9CjueDak8yjgOD7SMH/PVlmZMFQG0SwbZPLk8CbKufU51oBIZJPrBYRPWhUMZ/W7q
 EPPTIpXvjwj/WTGLbt3t4X+v1zXuGmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774626365;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zNvDWvTs5gokA76mlp6Xv3nT/3ABBuLH22hrucDVTFw=;
 b=WufjyeiouIUpNxljhOYK8DMRFqUr27LMar5ShL3p/ZtNeNouVUnkruFUUJ/4Qaz9sb1veo
 EGbBXMYsfnf7QfCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5E0A4A0A2;
 Fri, 27 Mar 2026 15:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SAw2NzymxmmkIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Mar 2026 15:46:04 +0000
Date: Fri, 27 Mar 2026 16:46:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it,
 Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260327154603.GC1092845@pevik>
References: <20260326170435.22566-1-pvorel@suse.cz>
 <69c65e5f.050a0220.19109e.1a43@mx.google.com>
 <20260327124052.GB1083266@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260327124052.GB1083266@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/3] lib: LTP_DEBUG cleanup
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Hi Petr,

> > Patches 1/3 and 2/3 look good. Patch 3/3 has a regression
> > and a couple of nits.

> > > [PATCH 3/3]
> > > --- a/lib/tst_test.c
> > > +++ b/lib/tst_test.c
> > > +	{"D::", "-D[1,2]  Prints debug information (can be overwriten by LTP_DEBUG"},

> > Typo: "overwriten" -> "overwritten". Also missing closing ')'.

> > [...]

> > > 	case 'D':
> > > +		if (!getenv("LTP_DEBUG")) {

> > This undoes the empty-string fix from patch 1/3. When
> > LTP_DEBUG="" is set, getenv() returns "" (non-NULL), so -D is
> > skipped here. But in do_setup() the tdebug_env[0] != '\0'
> > check also skips it. Net result: LTP_DEBUG= ./test -D2
> > silently produces no debug output.

> Good point, thanks!

Actually, IMHO you're wrong. 1st commit treat empty LTP_DEBUG
as if it were not set (FYI LTP_DEBUG= and LTP_DEBUG="" are the same in shell -
variable is defined but empty).

And this functionality is kept here deliberately. LTP_DEBUG is always stronger,
that's why it ignores -D.

And why should be variable stronger? Can be set by user of any software. That's
actually the goal of environment variables. So we can run test via kirk/openQA
with LTP_DEBUG=2 to have different behavior without modifying software. But we
can also disable -D settings that way (imagine somebody puts -D1 into their
runner, user of that runner should be able to disable it). I'll describe it in
the commit message to be obvious.

Kind regards,
Petr

> nit: better to discuss in patch itself, discussion on cover letter is somehow
> hidden in patchwork.

> Kind regards,
> Petr

> > Should be something like:

> > 	char *env = getenv("LTP_DEBUG");
> > 	if (!env || !env[0]) {

> > Regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
