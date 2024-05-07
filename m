Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC4DC10F1A
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 17:10:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61C813CDD93
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 19:10:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9303C3CDBB5
 for <ltp@lists.linux.it>; Tue,  7 May 2024 19:10:22 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AF474215F1F
 for <ltp@lists.linux.it>; Tue,  7 May 2024 19:10:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 096593426D;
 Tue,  7 May 2024 17:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715101817;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZOKUnpatth1b1zUgcTKXKQo0PaAikCnEX/XiIcwXPY=;
 b=i10UIPYJ3ZmLyunyDrubyAmIvEa61/pnCdqu3K3SKh7ufcdyzFb6Wr8S8foOQKHAtGYtqm
 9ONWaYmz8d/JGw2F2w8WfaRBoUCattsZIASe8Q179rJWzW/RvSpbJuLRmi6ki67Ktj0DR8
 ygXKxMiJnod3WyLKAVfU9cHpDvVOViw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715101817;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZOKUnpatth1b1zUgcTKXKQo0PaAikCnEX/XiIcwXPY=;
 b=tmU0IhJXYWclpLSSqttKk1SNU0YtkckqxX0fUoQ2QovfaPNemPbMqTZTzlBF08kZOpkHU8
 YrDy6cVnbhTKwEDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715101817;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZOKUnpatth1b1zUgcTKXKQo0PaAikCnEX/XiIcwXPY=;
 b=i10UIPYJ3ZmLyunyDrubyAmIvEa61/pnCdqu3K3SKh7ufcdyzFb6Wr8S8foOQKHAtGYtqm
 9ONWaYmz8d/JGw2F2w8WfaRBoUCattsZIASe8Q179rJWzW/RvSpbJuLRmi6ki67Ktj0DR8
 ygXKxMiJnod3WyLKAVfU9cHpDvVOViw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715101817;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZOKUnpatth1b1zUgcTKXKQo0PaAikCnEX/XiIcwXPY=;
 b=tmU0IhJXYWclpLSSqttKk1SNU0YtkckqxX0fUoQ2QovfaPNemPbMqTZTzlBF08kZOpkHU8
 YrDy6cVnbhTKwEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD20D139CB;
 Tue,  7 May 2024 17:10:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FVEeLHhgOmZTdwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 07 May 2024 17:10:16 +0000
Date: Tue, 7 May 2024 19:10:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org,
 linux-bcachefs@vger.kernel.org,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Message-ID: <20240507171011.GD157588@pevik>
References: <20231116135546.2599273-1-pvorel@suse.cz> <ZXHXxCRa31xO-Lo_@rei>
 <20231207175538.GA248849@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231207175538.GA248849@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Add support bcachefs filesystem
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

Hi all,

> > Hi!
> > > bcachefs has been merged into v6.7-rc1 [1]. Let's add it's support to
> > > LTP .all_filesystems = 1 and TST_ALL_FILESYSTEMS=1.

> > > [1] https://lwn.net/Articles/934692/

> > > Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > > Hi,

> > > this should be merged after v6.7 is released.

> > Agreed, although it's unlikey that they will pull bcachefs off from the
> > tree now. Any way I think that we should add the support to the next
> > release.

> Yep, now it's 6.7-rc4. I'll prepare v2

> > > So far I haven't tested all LTP tests on bcachefs temporary directory.
> > > I have only tested tests which use .all_filesystems = 1 or TST_ALL_FILESYSTEMS=1.
> > > So far it looks like there are only a few tests failing:

> > > statvfs01.c:44: TFAIL: creat(valid_fname, 0444) failed: ENAMETOOLONG (36)

> > That strange, that would mean that statvfs() reports possibly wrong
> > f_namemax. Looking at the code the f_namemax is initialized to
> > BCH_NAME_MAX in bch2_statfs().

> > And the dirent_create_key() does:

> >         if (name->len > BCH_NAME_MAX)
> >                 return ERR_PTR(-ENAMETOOLONG);

> > That does not look like there is any room for a failure. Maybe we can
> > print the buf.f_namemax value in the test and check if it's 512 since
> > that is the value of BCH_NAME_MAX.

FYI Unfortunately ENAMETOOLONG is still problem on statvfs() on bcachefs.

Kind regards,
Petr

...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
