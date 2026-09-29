Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970C5C9832A
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 15:54:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DBCD3E6BDA
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 17:54:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 177483D8567
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 17:54:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A0997600AC7
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 17:54:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D246621C30;
 Tue, 29 Sep 2026 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790697239;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3U1KU1v3FPfUPZM7c0qiR4YouZEH2U+LkQu+fRlSqIA=;
 b=NqRKfNnKur9I2iSs7SZjybknYEbzHwEcGzgshGrt6M17IiLChR3iMsHmMct1oOlg46ma5S
 uNgBpxIWprp/Cpn4A49XNQU+5EuAjElKaO1TZhRecOgmRTB2nh9ou0MLLE4Sqt1DHaCru4
 nR1+AuqtpBt3Q76TTrkI+IoUI7zpi1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790697239;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3U1KU1v3FPfUPZM7c0qiR4YouZEH2U+LkQu+fRlSqIA=;
 b=4704/iQaVYyochBvisUqxLZlx61OoU3j1Wt7C85yLmPLFIKdHUob/EQ/K36+aovoCXYVx8
 BuFR4M/aaiKLMjCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790697234;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3U1KU1v3FPfUPZM7c0qiR4YouZEH2U+LkQu+fRlSqIA=;
 b=HBNNAm7q25ZUf96c93eXMkApRKf1yRL+D3m3vV8WJwDj0IpUor9z597slJWqacLX0BDmni
 CtFKgxBnvyb4jtizRu3/HT+QXZ/MgeomtYlExc79k+oX9FLNGxUkuiYk4rmflxMNkTHka2
 z++jQr8/6JxMrO8XKqewIdAFxfwIlro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790697234;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3U1KU1v3FPfUPZM7c0qiR4YouZEH2U+LkQu+fRlSqIA=;
 b=6oTqXZrX+CcnzHQRbPdnDr4jxx6kFy+0DHa9+uy1qWObAxOHO2+gpjeEzGS2HhCjBIaZG2
 FD6V76kNdhqy8+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17A68136E4;
 Tue, 29 Sep 2026 15:53:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YAJONxHfu2oZPAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 29 Sep 2026 15:53:54 +0000
Date: Tue, 29 Sep 2026 17:53:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260929155352.GA2614679@pevik>
References: <arvN7MPnBolwnT3z@yuki.lan>
 <6abbce8c.aec4f0e4.fd74d.fe52@mx.google.com>
 <20260929145817.GD2462033@pevik> <arvZYFctU1IBHCml@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arvZYFctU1IBHCml@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] epoll_ctl06: Fix BPF map on old kernels
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > > Should't this be guarded with kernel version? I.e. only enabled for
> > > > kernels older than 5.8?

> > > At the beginning i did that, but then i thought that probably there are
> > > kernels backporting this feature. i.e. REHL

> > I'd also skip it for older kernel unless somebody reports it's needed.
> > (Simplicity wins in the long term.)

> What i though is that the check should be skipped on kernel newers than
> 5.8 and we should just return 0 here unconditionally.

Ah, I overlooked "enabled for kernels *older* than 5.8". Sure, I also meant
guard only this single test with tst_kvercmp(). Simple, IMHO good enough.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
