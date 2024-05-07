Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA4EC10F1A
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 08:19:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 317353CDB05
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 10:19:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9220A3C8658
 for <ltp@lists.linux.it>; Tue,  7 May 2024 10:18:52 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D7DC51019476
 for <ltp@lists.linux.it>; Tue,  7 May 2024 10:18:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AB47C33B7A;
 Tue,  7 May 2024 08:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715069930;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zOkrveGqa6oClREURdQYzgi7onMOc8kJej0stmVutq0=;
 b=ifWFK39/uD5wviReiWsw8lJT/FT46U2YpAciO8Rp78zdvCut+6Bq5o19pkk57uLjDzk6ss
 yJf1QkWXTq9ADOJGr1ZqE82v86LBa/oNP3vvRaNeabQj3YHnAeJV+3K7jeRF3ORUNXDPTX
 ny30u7ktBtJ/19sPZlgZMFxxxE6Flfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715069930;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zOkrveGqa6oClREURdQYzgi7onMOc8kJej0stmVutq0=;
 b=7N267OB2nE1URNKOCbYC1DtK3Z7yNynfrtFXe2sl+/o24u2thq2HLGOvIVEM/cgiiYrwmu
 MBP3cLB2O5tBkEAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=B+63Sbph;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=izA9Xxxk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715069928;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zOkrveGqa6oClREURdQYzgi7onMOc8kJej0stmVutq0=;
 b=B+63SbphLhDCJ2IODTCnVluWmJri02Lcd1XE9V7K0R/XoGmsh0XDARQ6y9Kqpg4NOby7hT
 UYBiB7wUhM0/Turjw5rx0pkGZa51nDP5mdHkiKBCbMtxepJZg9EDNloM9uA1K5WCJLCtyo
 NqWnOF88mSsmDwDlc1XstlqdvHbx7io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715069928;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zOkrveGqa6oClREURdQYzgi7onMOc8kJej0stmVutq0=;
 b=izA9Xxxk8bsyTU3p9AlwiTuArdsCGmxJdY6I4/4nT9VxYyC28btCSJ0iJO7LZV7jqf4e3Q
 LOI4aeDiS7vnv6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70A6D13A2D;
 Tue,  7 May 2024 08:18:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IBSsGujjOWZWNgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 07 May 2024 08:18:48 +0000
Date: Tue, 7 May 2024 10:18:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240507081846.GA97446@pevik>
References: <20231207194011.273027-1-pvorel@suse.cz>
 <20231207194011.273027-4-pvorel@suse.cz>
 <20231213024617.vx3epsav2n2lxozi@moria.home.lan>
 <ZZvIBO-a1b_nIHJ8@yuki>
 <gjfjylr4bdytdot7ywjispswvgpvjtkdmtsinsbcbc42ik2y3d@ws4tjmwqywrb>
 <ZZ0guBd48WXYapPL@yuki> <ZiJtf07WGFJPb_w2@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZiJtf07WGFJPb_w2@yuki>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AB47C33B7A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.61 / 50.00]; BAYES_HAM(-2.90)[99.59%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
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
 Brian Foster <bfoster@redhat.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 fstests@vger.kernel.org, linux-bcachefs@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > > Quite likely, other filesystems does have an inode flag that is set when
> > > > file has been compressed and simply report that in the foo_getattr()
> > > > callback. Looking at bcachefs I supose that we need to figure out if the
> > > > inode is v3 and then unpack the v3 info to get to the compressed flag,
> > > > you probably know best how to do that.

> > > I'm still not clear how we want to map STATX_ATTR_COMPRESSED, since it's
> > > extents that are compressed, not entire files - and just reporting the
> > > compression option is probably not what we want since it can be flipped
> > > off, and existing data will still be compressed.

> > > Do you know anything about the intended use case?

> > As far as I understand the flag it's a hint that the file I/O may be
> > slower/need more memory because of the compression.

> Ping.

> Kent we are getting closer to a next LTP release, are you going to add
> the compressed flag support into bcachefs or should we add bcachefs to
> the test skiplist?

Kent, gentle ping ^.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
