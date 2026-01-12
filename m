Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF165C9EC6B
	for <ltp@archiver.kernel.org>; Mon, 12 Jan 2026 11:05:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 393233C2E84
	for <ltp@archiver.kernel.org>; Mon, 12 Jan 2026 12:05:40 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43ACA3C21E4
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 12:05:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9A8E71A00980
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 12:05:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B959633721;
 Mon, 12 Jan 2026 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768215917;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iwt22LjCjySBCVGGjhebFVRy+RW9t8knOFuB0xACVQw=;
 b=Kh1t6wSIECnYNPdX/23BoVNgf2gIEr0pYOhIoMlxtEjKqRF4nGGnDSSm6N5MC6CSqlexxe
 fswqM57SjEhXPN/AaJePWXuwclIOSQO2AqRyALPPWtII8MVYAA/9aQltZ7kofvKPKe8JQP
 CS7SpbthhasL79itJgFzUy8R5tKDKBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768215917;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iwt22LjCjySBCVGGjhebFVRy+RW9t8knOFuB0xACVQw=;
 b=HEn3lm08q2L3fQZmmT9nf2aqD4HXonPSyVB3aaF5PGYjb76ejUg+EySIkFj/Dkyf+ZthaW
 hh3fs5cVIaQQDmAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Kh1t6wSI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HEn3lm08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768215917;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iwt22LjCjySBCVGGjhebFVRy+RW9t8knOFuB0xACVQw=;
 b=Kh1t6wSIECnYNPdX/23BoVNgf2gIEr0pYOhIoMlxtEjKqRF4nGGnDSSm6N5MC6CSqlexxe
 fswqM57SjEhXPN/AaJePWXuwclIOSQO2AqRyALPPWtII8MVYAA/9aQltZ7kofvKPKe8JQP
 CS7SpbthhasL79itJgFzUy8R5tKDKBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768215917;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iwt22LjCjySBCVGGjhebFVRy+RW9t8knOFuB0xACVQw=;
 b=HEn3lm08q2L3fQZmmT9nf2aqD4HXonPSyVB3aaF5PGYjb76ejUg+EySIkFj/Dkyf+ZthaW
 hh3fs5cVIaQQDmAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B3C83EA63;
 Mon, 12 Jan 2026 11:05:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id T/0nCG3VZGliHAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 12 Jan 2026 11:05:17 +0000
Date: Mon, 12 Jan 2026 12:05:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260112110515.GA257831@pevik>
References: <20251110024805.31070-1-wegao@suse.com>
 <20251223020836.9439-1-wegao@suse.com>
 <20251223020836.9439-3-wegao@suse.com> <aVzdrAgv9qdxZSt_@yuki.lan>
 <aV36R8E-KMD_dTf8@autotest-wegao.qe.prg2.suse.org>
 <20260107080957.GD727950@pevik> <20260107082727.GE727950@pevik>
 <aV4ujjfb7JBB2zaQ@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aV4ujjfb7JBB2zaQ@yuki.lan>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B959633721
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/4] tst_test.c: Add tst_cmd_present check if a
 command is present
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

> Hi!
> > 1) tst_brk for not checked command at the end.
> > 2) tst_brk for NULL otherwise we get segfault. Maybe check also for empty
> > command before attempting to do anything else.

> Technically the empty command will end up in the tst_brk() at the end,
> so I would add only the NULL check.

Sure, just the message will be a bit confusing:
'' not checked.

That's why I checked also for empty command.
Anyway, v7 is out with cmd[0] == '\0' as well. But it can be removed during
merge.
https://lore.kernel.org/ltp/20260109061716.20258-3-wegao@suse.com/

> > index bf92e6cc92..cf67c2a9f0 100644
> > --- lib/tst_test.c
> > +++ lib/tst_test.c
> > @@ -1379,12 +1379,16 @@ bool tst_cmd_present(const char *cmd)
> >  {
> >  	struct tst_cmd *pcmd = tst_test->needs_cmds;

> > +	if (!cmd || cmd[0] == '\0')
> > +		tst_brk(TBROK, "Invalid cmd");
> > +
> >  	while (pcmd->cmd) {
> >  		if (!strcmp(pcmd->cmd, cmd))
> >  			return pcmd->present;

> >  		pcmd++;
> >  	}
> > +	tst_brk(TBROK, "'%s' not checked", cmd);
> >  	return false;
> >  }


> > 3) Shouldn't we use tst_brk_() to point to the code in the test instead of
> > tst_brk()? If yes, we probably want to have tst_cmd_present_() as library
> > internal (static, with const char *file, const int lineno parameters) which
> > calls tst_brk_() and tst_cmd_present() as public (the only with signature in
> > header).

> I do not think that this is that important to have, the
> tst_cmd_present() calls are going to be quite rare and hence easy to
> locate in the sources.

OK, that simplifies things.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
