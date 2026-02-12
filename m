Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAE7EE369D
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 16:08:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E9243CF2AC
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 17:07:58 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 317143CB779
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 17:07:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 714521400132
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 17:07:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C3FC13E6C3;
 Thu, 12 Feb 2026 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770912455;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XPnxbqaz/Nc1yhvAmvDoFy2o39vb0mY3UEAlNeTIFX8=;
 b=dFztZ2ndRHdeVDlp3887QXH7QPLUIbZ0bTXilkod81yU9hoHBLKQPVz0BVxX0gQFSphLXj
 lcs4HaU3e8Pj0iA/NfbojfHllN1PrT3CEzzx6mndU6lVCbJBTEAjadJfN0s6YuXv2Y7nwZ
 DRIioxFz38Q74mY+jutGHZqFaBSlCro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770912455;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XPnxbqaz/Nc1yhvAmvDoFy2o39vb0mY3UEAlNeTIFX8=;
 b=eA62dt+HYmAMWYVZ7N3UZkeq4kge/lnhh0NGCvucAIytoxqyF9NGNQM/pPPrR3LPgdhIel
 H7/kcLhqnTGn5yAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=huAkJueO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QQN3rPR9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770912454;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XPnxbqaz/Nc1yhvAmvDoFy2o39vb0mY3UEAlNeTIFX8=;
 b=huAkJueOzSijXXVyU/05YC5HQanCHi8Z3A2x1HDVbpieFNFEpgtluCyjkmhtpuc433g2vH
 Lu2ucQkmxr7EbDEsu3URaJdGalcDctrdPY+g+3wnFUy+6p9LJTdyCmq8qxLDUmT9yVAs3X
 295tG8VorRRPpqybdeNf8NYPV8Br6lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770912454;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XPnxbqaz/Nc1yhvAmvDoFy2o39vb0mY3UEAlNeTIFX8=;
 b=QQN3rPR9n6u1CuopP122NhbCOaf3AGwopHYYs3xfH/dQc0nYxG+rmKshm4hUuA59xq+jhq
 TW+CMQTee9/hKaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EAA13EA62;
 Thu, 12 Feb 2026 16:07:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6z3gC8b6jWlSYAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 12 Feb 2026 16:07:34 +0000
Date: Thu, 12 Feb 2026 17:07:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260212160732.GA54354@pevik>
References: <20260211-fix_doc_build-v1-1-42897785e0c7@suse.com>
 <aYyrcqnGWKhsIUej@yuki.lan> <20260212084804.GA5659@pevik>
 <DGCV06VWH5W4.2S96MUIO5X4ZL@suse.com> <20260212093257.GA8902@pevik>
 <DGCW24NO41YF.34RVLSFL2026H@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DGCW24NO41YF.34RVLSFL2026H@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 URIBL_BLOCKED(0.00)[readthedocs.org:url,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[readthedocs.org:url,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C3FC13E6C3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: fix documentation build with latest
 setuptools
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

Hi Andrea,

> > It is a workaround in a sense because new linuxdoc master thanks to my fix [1]

> Now it's more clear, thanks for fixing it!

> > will not need setuptools any more (which I explained in my patch). Normally we
> > would update, but upstream does not have time to release.

> > Also, new release will use hatch, we'll need to use pyproject.toml instead of
> > requirements.txt.

> Isn't pyproject.toml used specifically for python projects? I'm not sure
> about our LTP documentation setup which is just a sphinx configuration.

Likely, my python fu is very limited.

Anyway, because CI started to fail and also our real doc started to fail (Feb 11
and 12) [1] I agreed with Andrea to merge the fix. I dared to add a comment that
it's workaround.

Kind regards,
Petr

[1] https://app.readthedocs.org/projects/linux-test-project/builds/?version__slug=latest

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
