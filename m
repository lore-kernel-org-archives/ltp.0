Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D315C44508
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 11:08:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8181F3E5694
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 13:08:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D4733E5686
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:08:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E8C0B1A00211
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:08:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C8B383DFE;
 Wed, 15 Jul 2026 11:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784113680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=baoemsp0QFUaWQRHULXc1n94TF6AOvQmtrRBU8302IE=;
 b=NOz4H83xS/XaCob/0gjVPF8GrMvPVtgzlUu4Ov5gnrBrukv4ZmdeIv1ieOltBkyjwY+ox8
 6K9gEgZNXMjUgogCwEvSzex48D7mY+2JU8dlcLdsVYe7H7/+elDyIzgy3/Ud7UC2crCtm0
 PsPxRoWlaOrxNiv+RwGnZIEDZMF8wGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784113680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=baoemsp0QFUaWQRHULXc1n94TF6AOvQmtrRBU8302IE=;
 b=fpgWMm3YrGAqb6EhpzxHopQ6mKWZG/T2TNTcMwmuOImwVjngZ7smFDXWjOdEmPo7rdDfbQ
 Lgec3aZ1TRE1ODBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=E1BEhGcJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vxSDnAMR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784113679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=baoemsp0QFUaWQRHULXc1n94TF6AOvQmtrRBU8302IE=;
 b=E1BEhGcJQ247vWj8HsFy5Aiis16SxMGGA6oSs1qS0xlltHZ72avKfg/N1+/XF9BwH3JZvw
 +nFUKZd+K2MhtttTMsxcCOzo3vk/Gp7pU9jjzxV2P5IAq7sxnMJhUulj78gctXDZP9ourP
 O3vp/I90AwcK9r8sVF6tkn41a73RDDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784113679;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=baoemsp0QFUaWQRHULXc1n94TF6AOvQmtrRBU8302IE=;
 b=vxSDnAMROG4g0Uv3K/T4bXF/9tMOwQNbVbO7Qi55nsnf7OKocHZcw2p1tG47qJ/18RqpI0
 KQjGjT3Pl/QzGWBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6984779AD;
 Wed, 15 Jul 2026 11:07:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZtxAKw9qV2ozAwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 15 Jul 2026 11:07:59 +0000
Date: Wed, 15 Jul 2026 13:07:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <aldqB8mG2VkCkcEG@yuki.lan>
References: <20260715094138.1679456-2-chrubis@suse.cz>
 <20260715110223.4165-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260715110223.4165-1-linuxtestproject.agent@gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C8B383DFE
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_TO(0.00)[gmail.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls: Add epoll_ctl07
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> A fallback definition belongs in lapi/epoll.h:
> 
>   #ifndef EPOLLEXCLUSIVE
>   #define EPOLLEXCLUSIVE (1u << 28)
>   #endif

Indeed it fails to compile on older distros, I will add the fallback.

> > +	if (round == NWAITERS)
> > +		tst_res(TPASS, "each event woke exactly one waiter");
> > +
> > +	SAFE_CLOSE(fds[0]);
> > +	SAFE_CLOSE(fds[1]);
> > +}
> 
> run() forks NWAITERS children but never calls tst_reap_children().
> Each child calls exit(0) after the checkpoint wake, so they are all
> finished by the time the loop exits, but the parent leaves them as
> zombies. The structurally identical epoll_wait15.c calls
> tst_reap_children() after its equivalent loop. Should tst_reap_children()
> be called here before or after the result is reported?

Children that exit(0) are autocollected by the test library.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
