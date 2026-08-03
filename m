Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7270FC5518E
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 10:34:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C55173E719A
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 12:34:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EF553CC870
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 12:33:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DB779600790
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 12:33:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6064E3F7E;
 Mon,  3 Aug 2026 10:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785753221;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6klcfZT6uym2nqpMm49DxMN+2B8F4myEXquy95Ue264=;
 b=tnpXPRsyCxa7YeAIe1uzoGfINkFvv3AwHU6Avw5GIlV08Cq+E5PAr/fsZpFD8+LCta4vuj
 1Wh2aCznMCvxpHYCQgYObDU9E8BOBT1M+7DZEBw6Ov9Z60tBRbhPeZeIVGtC+UCF8CXd42
 3+Mq/xwvv8Utp1lddlYNYxefTKePWhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785753221;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6klcfZT6uym2nqpMm49DxMN+2B8F4myEXquy95Ue264=;
 b=BgglUmihfmviMIPfVCplqMyLbDJWgjCrlNMR5AuogabLJvHQnEm9+aVMybhndaGELCCiUo
 r8MOtAYvLyS7xjDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qtZtfmL2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=apEiAEdG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785753217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6klcfZT6uym2nqpMm49DxMN+2B8F4myEXquy95Ue264=;
 b=qtZtfmL2jxw4IWw4RIRj4ZtWyeiwW79EBQlFNGVUP9jnSORCxAXVlT2F8e7ttfDYT9JGqK
 BZIZmFsP/FLX4mM/mV544+0ejloMzUOCIAec53y+IXpqModgYBb8zhKZqVYQaEhQXb3GuP
 2Fj4hhCPe/kjeY6Xf060HlstHHYvOPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785753217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6klcfZT6uym2nqpMm49DxMN+2B8F4myEXquy95Ue264=;
 b=apEiAEdG70lS/07w7wFHAv3ABc8uT4NuwA0kItCMvceo4l+tyu4ZIgijbFDQdAfHp1mxFT
 vHMzT7VbLAvf2RBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F16D3779A1;
 Mon,  3 Aug 2026 10:33:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 89R0OYBucGo+WgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 03 Aug 2026 10:33:36 +0000
Date: Mon, 3 Aug 2026 12:33:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260803103335.GD217746@pevik>
References: <20260731054548.133241-1-pvorel@suse.cz>
 <6a6c5226.d5b2c389.166717.d42a@mx.google.com>
 <20260803091348.GA216243@pevik> <anBdxCKHlpedf2rf@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <anBdxCKHlpedf2rf@yuki.lan>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6064E3F7E
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[suse.cz:replyto,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Switch to patchwork.kernel.org
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

Hi Cyril, all,

> Hi!
> > since we have all active LTP maintainers enabled as patchwork maintainers in the
> > kernel.org instance [1] I'd like in few hours merge this patch to finally move
> > to patchwork.kernel.org. FYI we already have 18 patches on it, AI review is
> > there as well.

> > @Cyril @Li @Jan: Could you please ack this patch?

> Acked-by: Cyril Hrubis <chrubis@suse.cz>

Thank you!

> Btw, we may want to add the patchwork link into kernel MINTAINTERS file, 

Very good point, thanks! I'll send a patch adding a new one once we switch.

> > I wonder when to stop receiving patches on the old ozlabs instance [2] We should
> > probably ask for it soon so that people don't think we stop maintaining it.

> Sounds about right.

> > I hoped that the last patch on that instance would be "Switch to
> > patchwork.kernel.org" [3], but there are new patches now. OTOH we then no longer
> > get updates for the old patchsets (there are 54 patches which aren't on the new
> > kernel.org instance + already 6 duplicates).

> > Other question is when to ask about for removing the old instance. I'd keep it
> > at least for some time (can be useful + there might be bookmarks, instance has
> > 13079 patches, first one in 2018-02-28). WDYT?

> I would keep it around at least for a year or two, I sometimes look up
> old patches there.

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
