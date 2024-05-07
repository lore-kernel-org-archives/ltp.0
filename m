Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D414C25B4F
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 17:03:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF8853CDE27
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 19:03:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5B723CDB88
 for <ltp@lists.linux.it>; Tue,  7 May 2024 19:03:43 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 44922611563
 for <ltp@lists.linux.it>; Tue,  7 May 2024 19:03:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6095F20DAA;
 Tue,  7 May 2024 17:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715101422;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9/6g6rTiwhnaq2SHTx0nCaltq1CiWrlxM+5f+KSoLr0=;
 b=hVdA1bJpYYghQGNLKSQyZBPUo2gFibNxOWHP3T/7CeLiaqfO7C1YISnWS4dgXqSocAEOZw
 Q/gWrgyTQsBPrpEmUyVhzckVjM2sT1s15n5rNLRaZSYFE8g+3yfqrDhUFZog5yrz0ITBYp
 swqQQn/chjocYzL1x5G/XDlPW6WB2/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715101422;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9/6g6rTiwhnaq2SHTx0nCaltq1CiWrlxM+5f+KSoLr0=;
 b=jqO533Fhsga/2OinLWLGjgqBeBoi+UnCQ4hbosl00r/eSWfzEetZD4gdcCC2K8kbl+XMFD
 W9zk4G/kVpySV8DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715101422;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9/6g6rTiwhnaq2SHTx0nCaltq1CiWrlxM+5f+KSoLr0=;
 b=hVdA1bJpYYghQGNLKSQyZBPUo2gFibNxOWHP3T/7CeLiaqfO7C1YISnWS4dgXqSocAEOZw
 Q/gWrgyTQsBPrpEmUyVhzckVjM2sT1s15n5rNLRaZSYFE8g+3yfqrDhUFZog5yrz0ITBYp
 swqQQn/chjocYzL1x5G/XDlPW6WB2/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715101422;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9/6g6rTiwhnaq2SHTx0nCaltq1CiWrlxM+5f+KSoLr0=;
 b=jqO533Fhsga/2OinLWLGjgqBeBoi+UnCQ4hbosl00r/eSWfzEetZD4gdcCC2K8kbl+XMFD
 W9zk4G/kVpySV8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0407A139CB;
 Tue,  7 May 2024 17:03:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UQAeNuxeOmbxdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 07 May 2024 17:03:40 +0000
Date: Tue, 7 May 2024 19:03:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Message-ID: <20240507170331.GF138935@pevik>
References: <20231207194011.273027-1-pvorel@suse.cz>
 <20231207194011.273027-4-pvorel@suse.cz>
 <20231213024617.vx3epsav2n2lxozi@moria.home.lan>
 <ZZvIBO-a1b_nIHJ8@yuki>
 <gjfjylr4bdytdot7ywjispswvgpvjtkdmtsinsbcbc42ik2y3d@ws4tjmwqywrb>
 <ZZ0guBd48WXYapPL@yuki> <ZiJtf07WGFJPb_w2@yuki>
 <20240507081846.GA97446@pevik>
 <xlqa5l5si2mp3troac56tq7q3gansgi2fqs57rd2i2xrudiq34@iit2ymv4pzy6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <xlqa5l5si2mp3troac56tq7q3gansgi2fqs57rd2i2xrudiq34@iit2ymv4pzy6>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] statx04: Skip STATX_ATTR_COMPRESSED on
 Bcachefs
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
Cc: Jan Kara <jack@suse.cz>, Coly Li <colyli@suse.com>,
 Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Tue, May 07, 2024 at 10:18:46AM +0200, Petr Vorel wrote:
> > > Hi!
> > > > > > Quite likely, other filesystems does have an inode flag that is set when
> > > > > > file has been compressed and simply report that in the foo_getattr()
> > > > > > callback. Looking at bcachefs I supose that we need to figure out if the
> > > > > > inode is v3 and then unpack the v3 info to get to the compressed flag,
> > > > > > you probably know best how to do that.

> > > > > I'm still not clear how we want to map STATX_ATTR_COMPRESSED, since it's
> > > > > extents that are compressed, not entire files - and just reporting the
> > > > > compression option is probably not what we want since it can be flipped
> > > > > off, and existing data will still be compressed.

> > > > > Do you know anything about the intended use case?

> > > > As far as I understand the flag it's a hint that the file I/O may be
> > > > slower/need more memory because of the compression.

> > > Ping.

> > > Kent we are getting closer to a next LTP release, are you going to add
> > > the compressed flag support into bcachefs or should we add bcachefs to
> > > the test skiplist?

> > Kent, gentle ping ^.

> Add it to the skiplist for now, thanks

Thanks, whitelist merged with your ABT.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
