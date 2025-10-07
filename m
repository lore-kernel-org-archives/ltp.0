Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FFACCD185
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 15:44:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 457EB3CE533
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 17:44:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED7EC3CE486
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 17:44:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 45033600687
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 17:44:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EACAE1F38F;
 Tue,  7 Oct 2025 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759851861;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VQWaA/e2TkiV/Fvale9lqc/4om4sS7j1AGUcAhDpLG4=;
 b=Ncw3kJU8acec7UxUKO/X3i4AdLt7J6wUnOJ1ah5Up25UqicN/n3Y5Dw4heGc7i9OAgmLo/
 e8O/JbiTcZamwApv2j197CwAL+AG3AmMf6tkQgSh1n7wfxz9ms3Pff6CmFMwNLIxs1GVcf
 8tHJdvfE4OD+HEC0RTzZnBIerKpxQBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759851861;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VQWaA/e2TkiV/Fvale9lqc/4om4sS7j1AGUcAhDpLG4=;
 b=QIHZcG7VXJtasLE1JTK/38I/AlTQo6rUBXpn1pgfOA5NzHRnR11u2F6A3zUSkzywCw0FIf
 S3LrHoxxpSVi7LBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759851860;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VQWaA/e2TkiV/Fvale9lqc/4om4sS7j1AGUcAhDpLG4=;
 b=nhkUPHvhp51AvWjSGlZ2kd9c6A9AsQN4foc9d9yvndz0G2Ixbo1TkXBZ3K6t4BdNOaFTqw
 L8MZ4ewwqr4WyYravKt2p7FVEkXNa+PGtDrT0lC7bxT1yQmJqUpXY3WE5ysdorn54VlsTw
 x6lCWuomZPjtJtb15wHjr0xlkZnu5I0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759851860;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VQWaA/e2TkiV/Fvale9lqc/4om4sS7j1AGUcAhDpLG4=;
 b=BaOVGbL0MWy+JgAl+1h1osqoepa8LNnS+kFZmh3YP8UxhZ8Z0hVWuSA8JEtdecIpPE7TzG
 7JjTn9+m39i+JKDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF0B213693;
 Tue,  7 Oct 2025 15:44:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ggx3MVQ15WgrVAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 07 Oct 2025 15:44:20 +0000
Date: Tue, 7 Oct 2025 17:44:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251007154419.GA140031@pevik>
References: <20251006-remove_todo-v1-1-5bab5f6f77f5@suse.com>
 <20251007083814.GA109182@pevik> <aOTnruayNBq5JYDK@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aOTnruayNBq5JYDK@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Remove TODO
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
> > > TODO file is not updated and it talks about goals we already reached via
> > > new LTP documentation. In general, it contains generic and random topics
> > > which none is updating anymore, so it's better to remove it in order to
> > > create less confusion for new comers. If we really want to have a TODO
> > > list, probably the best place would be doc/ folder.

> > I vote to have it. So yes, update it and convert it to REST format and move to
> > doc/.

> Well the TODO list points in there are mostly generic and are not going
> to be finished anytime soon. E.g. "write more syscall tests" I'm not
> sure how useful such documentation will be. Maybe we need a "where to
> start" guide for a new devs, but I'm afraid that it would have to be
> written from scratch.

I'm not against the removal. "Write more syscall tests" contains valid points
(LWN, man pages git repo), but agree it'd have to be completely rewritten.
If anybody writes that, mentioning CVE reproducers in kernel and (g)libc commit
messages would be also useful.

Acked-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
