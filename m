Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB30EA4FB2
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 12:01:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B1E33CE00D
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 13:01:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C518D3CE00D
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 13:01:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2FF25140033C
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 13:01:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B8A035BD0C;
 Mon, 23 Feb 2026 12:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771848079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ht32MSpAUV1ANarzz1Gg4LTAaZvGNl5zWU30JbFf3x0=;
 b=AV9l/t90e05sEfRHdaNJbdAFp9IQjDm66a8qZFAZpp4BwzqneLPBvvdnMjDE66zwabjltf
 3cnhe41gpyIi9O+lLzsVcEbBxVr1MLWziOQxAN4whUbxe2RtgPVUuhin9Tnt4TfSe1OLGr
 AhOovJw68T4dz/MAR/n9p1xo7hl8IXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771848079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ht32MSpAUV1ANarzz1Gg4LTAaZvGNl5zWU30JbFf3x0=;
 b=du7/UgClCDwCyLDItCUctW+AKpij8EOHfbmV1UERsYcQhBK5MKSsWLcQwPaJk0QQntLSv4
 syrsIbd+FBPP/7DA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="sl/k1kp8";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QaxzwmTK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771848074;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ht32MSpAUV1ANarzz1Gg4LTAaZvGNl5zWU30JbFf3x0=;
 b=sl/k1kp8P+TBTdIhhy2fMtGPSdgIZlls/sMMfh4YcxZ9r8OgkRmjUwAvaj2mtUReRsSxw7
 iNVejIzNjFTQfCjUvzfb1gUFl6oooxxpB3s8PoJKMLG7FuHChRSdhE0pdyO8+Q6BHwbCsT
 y9fHjTlnQJoED5eSRBCsFc7phuDpA3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771848074;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ht32MSpAUV1ANarzz1Gg4LTAaZvGNl5zWU30JbFf3x0=;
 b=QaxzwmTKh2EmjeNL/iUPXnK3ePtNXtAkihRu9UQQz2BUe1qWr3dYnbnSvSM5JlrUs6As3c
 tMn4ffpJwVdkauCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 470613EA68;
 Mon, 23 Feb 2026 12:01:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JJKuD4pBnGmFSgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 23 Feb 2026 12:01:14 +0000
Date: Mon, 23 Feb 2026 13:01:11 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Message-ID: <20260223120111.GA462451@pevik>
References: <20260221135338.26236-2-sebastian.chlad@suse.com>
 <20260222203442.GB417048@pevik>
 <CAJCsO8eTiS5Z1Upon-gUj6R9f=TW3BJaRqmDwdxEwSMyvnwB1A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJCsO8eTiS5Z1Upon-gUj6R9f=TW3BJaRqmDwdxEwSMyvnwB1A@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[tst_net.sh:url,tst_test.sh:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: B8A035BD0C
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfs: Adapt the lib to allow to test in 2-host mode
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>,
 Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sebastian,

...
> > ... if you remove exportfs from TST_NEEDS_CMDS you can use the same code
> > for
> > both netns and 2 based setup (tst_rhost_run should work well on netns).


> good point. I have tested v2 which I will send shortly.

+1

> > I was thinking about having a special variable for checking rhost only, but
> > given that tst_test.sh is now also deprecated, we will have to solve this
> > in
> > shell loader.

> I was also thinking about it but in the end I think it could be just yet
> another variable to control the test flow, so one more thing
> to worry about... and as far as I see relying on the presence of already
> defined variables seems good enough.

Until shell loader came I thought we'd parse tests which use tst_test.sh
(I thought therefore these variables would be used in metadata).

Now I'm thinking whether write the minimal tst_net.sh functionality directly in C
as either new library (code in libs/) or just core library extension (lib/*.c).
For sure it'd be quicker just to put subset of required code into new script,
but it's worth to consider it. That would also help rewrite tests in C in the
future.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
