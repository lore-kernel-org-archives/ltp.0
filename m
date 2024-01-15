Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F654C3DA79
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 22:52:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1F093CE36F
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 23:52:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE6903CCB0F
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 23:52:27 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C6B58600C22
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 23:52:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5477E21ABC;
 Mon, 15 Jan 2024 22:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705359143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FP4DHX1JTAwbUv9ShrvCVFjs0jNbRlrsRuUMzdwYvxU=;
 b=Zjh36BiiZ6Cp5qMdIprXuIoCuWkBLonGNrQOZn5yx1K9W8OdiKKax533VxxFKyB7IIWoVF
 sff4QJChV+ZW1H5jemvX5v/Bc91UXBqIPMSesvzIb2I+h1NwxkAq28rPEivmbwLyP5MBI6
 rw/MxuWAlupVDdv9eegsJlqdIW8Dp1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705359143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FP4DHX1JTAwbUv9ShrvCVFjs0jNbRlrsRuUMzdwYvxU=;
 b=E2LShrFMdm2PRQ4eqPVG6tW5FfzrER6hz1PbidxHmJUUH9syHDbfgVZb+CeGexUVcDd+Qk
 hqTDwvmTKarETLBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705359142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FP4DHX1JTAwbUv9ShrvCVFjs0jNbRlrsRuUMzdwYvxU=;
 b=q9f8lg2vwtN17RcXXF7D4FA+m2tT8lhonTsDNReAv41zB62B/tvDQh6uRFEfHFql/eY7ug
 Kh0HgY0OoOQbL40K1GaPWcWjZjd2hOepeFEcywFS8DPPUJk8KOZiySqP21G1u4ynhtMOVl
 wxDvgP5uKEry5GKXDflQIwiR4X9+2LM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705359142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FP4DHX1JTAwbUv9ShrvCVFjs0jNbRlrsRuUMzdwYvxU=;
 b=NxEa5t0Pxz/b89BFz53Q9mMmDbEMgobzFabCBDP58GWzDuEE5c9hUkTRtRroG/uAgcjGwz
 VpzHqbHFEvQabIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F6B8136F5;
 Mon, 15 Jan 2024 22:52:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BXUgAia3pWVwewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 15 Jan 2024 22:52:22 +0000
Date: Mon, 15 Jan 2024 23:52:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240115225220.GA2532501@pevik>
References: <20231016123320.9865-1-chrubis@suse.cz>
 <20231016123320.9865-2-chrubis@suse.cz>
 <20240105004236.GA1451456@pevik> <ZaUius9Q_5U113q9@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZaUius9Q_5U113q9@yuki>
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=q9f8lg2v;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NxEa5t0P
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.71 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.00)[40.14%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 5477E21ABC
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] lib: Add tst_fd iterator
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> > In file included from tst_fd.c:22:0:
> > ../include/lapi/bpf.h:188:12: note: 'map_flags' declared here
> >    uint32_t map_flags; /* BPF_MAP_CREATE related
> >             ^
> > make[1]: *** [tst_fd.o] Error 1
> > ../include/mk/rules.mk:15: recipe for target 'tst_fd.o' failed

> Uff, do we still support distros with these header failures?

Unfortunately yes (SLES 12-SP2, somehow covered in CI by openSUSE Leap 42.2).

> I especailly used the lapi/ headers where possible in order to avoid any
> compilation failures, if lapi/bpf.h fails it's lapi/bpf.h that is broken
> though.

...
> > > +static void open_eventfd(struct tst_fd *fd)
> > > +{
> > > +	fd->fd = eventfd(0, 0);
> > > +
> > > +	if (fd->fd < 0) {
> > > +		tst_res(TCONF | TERRNO,
> > > +			"Skipping %s", tst_fd_desc(fd));
> > Why there is sometimes TCONF? Permissions? I would expect some check which would
> > determine whether TCONF or TBROK. Again, I suppose you'll be able to check, when
> > TST_EXP_FAIL() merged, right?

> The TCONF branch is added to the calls that can be disabled in kernel.
> The CONFIG_EVENTFD can turn off the eventfd() syscall so we can't TBROK
> here on a failure.

OK, thx for info!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
