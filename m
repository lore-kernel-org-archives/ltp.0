Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E404DC9EC71
	for <ltp@archiver.kernel.org>; Mon, 12 Jan 2026 11:08:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 608CA3C30EA
	for <ltp@archiver.kernel.org>; Mon, 12 Jan 2026 12:08:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19A173C21E4
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 12:08:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7E5021400436
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 12:08:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 410C45BD66;
 Mon, 12 Jan 2026 11:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768216085;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Eakk131Dcddlz/4l36lQgU7JWcC9FFZTfnHpSkBEqc=;
 b=KTyHAL+6f5ictjhHjc8WN4fYpACJVFRv5p9+yAcv9GUtYj+4C0HRyXmM1FwxBHj/4fhTRB
 ly1u2+01zawnGo69Yup3x+3eMFy9uGhZb00oXcm5HxKEbE410JFXNgWujSebhZyfq8aRrY
 S9v6CnJQuJhpzf2jqVcQ2lXr7m+9m9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768216085;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Eakk131Dcddlz/4l36lQgU7JWcC9FFZTfnHpSkBEqc=;
 b=iVaEBJlnyRG9Z1VKQ8khMXUQxQYeLgp5kklAN6LD1+pdpyMRAIQRUM73cLVSwqJBuzUXJQ
 /OyolypN8Y636eAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=U0b3PgbE;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=swo1Dhes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768216084;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Eakk131Dcddlz/4l36lQgU7JWcC9FFZTfnHpSkBEqc=;
 b=U0b3PgbEEyyXrdvG3onfqaf8ytb8voSun/BNt6qdOkcg2m/Pd2T95I7bA+qEfmUSAV981m
 XxpZegCJ7mFcxlHDdsg3mJQtOOW9Hd/U+JsJFUy8lfv6AUF7HYiv72qdoZyx5Ce60qzvw5
 zLgvlfFmtsctZXaLYy9Ifn0zxFm0tYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768216084;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Eakk131Dcddlz/4l36lQgU7JWcC9FFZTfnHpSkBEqc=;
 b=swo1DhesuvJHcvLVM97GjF5PnY1Tx8CqZCk2S5ghTg3y1pFenL4OQxlvuBHtkC5cAcOUNv
 QTPvbqbWqW/142Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B6C13EA63;
 Mon, 12 Jan 2026 11:08:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X4rXOhPWZGlVHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 12 Jan 2026 11:08:03 +0000
Date: Mon, 12 Jan 2026 12:08:02 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
Message-ID: <20260112110802.GB257831@pevik>
References: <20251223020836.9439-1-wegao@suse.com>
 <20260109061716.20258-1-wegao@suse.com>
 <20260109061716.20258-3-wegao@suse.com>
 <20260109191704.GB129283@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260109191704.GB129283@pevik>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 410C45BD66
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/4] tst_test.c: Add tst_cmd_present check if a
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> ...
> > +++ b/lib/tst_test.c
> > @@ -1375,6 +1375,24 @@ static const char *default_fs_type(void)
> >  	return tst_dev_fs_type();
> >  }

> > +bool tst_cmd_present(const char *cmd)
> > +{
> > +	struct tst_cmd *pcmd = tst_test->needs_cmds;
> > +
> > +	if (!cmd || cmd[0] == '\0')

> > +		tst_brk(TBROK, "Invalid cmd");
> I'd still prefer tst_brk_() as I described at v6, but that can be done as a
> separate change. I keep my RBT :).

I see Cyril was OK with keeping tst_brk() in v6, I'm sorry to overlook it.
https://lore.kernel.org/ltp/aV4ujjfb7JBB2zaQ@yuki.lan/

> Kind regards,
> Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
