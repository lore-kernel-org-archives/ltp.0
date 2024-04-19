Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEC2C4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 13:12:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0C5E3CFD8E
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 15:12:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BFF83CEFF0
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 15:12:15 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BCFE760DB57
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 15:12:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 352B45D6F7;
 Fri, 19 Apr 2024 13:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713532333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gRUQmY+zTFLbDhdPnN9JYqdwMNywIx2NLL3xZ9/bCg0=;
 b=0sBHJN19cARBqVlEw4zBmsAZ98rYt7F+IIaxCjz152F5P8CUmQA/2ACzZ8m1Ig5YXt2FHZ
 lNCRSKQ3ipgYlXo2WmTFkN4kGi8dV3miOwpSoA8mMWq9YT1K2F7O7JL++He9gq0Oe/zzSV
 jejtJoiyYHWqsXe/FbTPf76fqlhI7pM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713532333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gRUQmY+zTFLbDhdPnN9JYqdwMNywIx2NLL3xZ9/bCg0=;
 b=OXf3BwBDCB8QUNbQ3lofpseinFvlmWqPVqemifXt827kyytgpIycs9xZXYpuysjGMvpkCO
 AKc6zFxVjRLd5yBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0sBHJN19;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OXf3BwBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713532333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gRUQmY+zTFLbDhdPnN9JYqdwMNywIx2NLL3xZ9/bCg0=;
 b=0sBHJN19cARBqVlEw4zBmsAZ98rYt7F+IIaxCjz152F5P8CUmQA/2ACzZ8m1Ig5YXt2FHZ
 lNCRSKQ3ipgYlXo2WmTFkN4kGi8dV3miOwpSoA8mMWq9YT1K2F7O7JL++He9gq0Oe/zzSV
 jejtJoiyYHWqsXe/FbTPf76fqlhI7pM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713532333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gRUQmY+zTFLbDhdPnN9JYqdwMNywIx2NLL3xZ9/bCg0=;
 b=OXf3BwBDCB8QUNbQ3lofpseinFvlmWqPVqemifXt827kyytgpIycs9xZXYpuysjGMvpkCO
 AKc6zFxVjRLd5yBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 230331395B;
 Fri, 19 Apr 2024 13:12:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gzueBq1tImY7UAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 19 Apr 2024 13:12:13 +0000
Date: Fri, 19 Apr 2024 15:11:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Message-ID: <ZiJtf07WGFJPb_w2@yuki>
References: <20231207194011.273027-1-pvorel@suse.cz>
 <20231207194011.273027-4-pvorel@suse.cz>
 <20231213024617.vx3epsav2n2lxozi@moria.home.lan>
 <ZZvIBO-a1b_nIHJ8@yuki>
 <gjfjylr4bdytdot7ywjispswvgpvjtkdmtsinsbcbc42ik2y3d@ws4tjmwqywrb>
 <ZZ0guBd48WXYapPL@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZZ0guBd48WXYapPL@yuki>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 352B45D6F7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.97 / 50.00]; BAYES_HAM(-2.96)[99.84%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
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
Cc: Jan Kara <jack@suse.cz>, Brian Foster <bfoster@redhat.com>,
 fstests@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > Quite likely, other filesystems does have an inode flag that is set when
> > > file has been compressed and simply report that in the foo_getattr()
> > > callback. Looking at bcachefs I supose that we need to figure out if the
> > > inode is v3 and then unpack the v3 info to get to the compressed flag,
> > > you probably know best how to do that.
> > 
> > I'm still not clear how we want to map STATX_ATTR_COMPRESSED, since it's
> > extents that are compressed, not entire files - and just reporting the
> > compression option is probably not what we want since it can be flipped
> > off, and existing data will still be compressed.
> > 
> > Do you know anything about the intended use case?
> 
> As far as I understand the flag it's a hint that the file I/O may be
> slower/need more memory because of the compression.

Ping.

Kent we are getting closer to a next LTP release, are you going to add
the compressed flag support into bcachefs or should we add bcachefs to
the test skiplist?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
