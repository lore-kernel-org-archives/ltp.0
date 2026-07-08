Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E59AC43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 18:51:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 391983E6946
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 20:51:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CB503E20C5
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 20:51:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 980B0600951
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 20:51:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D1FE3758C6;
 Wed,  8 Jul 2026 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783536689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c0FjSMjrE921UgXZzfaRjwYXUZqmW10LGyy8xPKuI+g=;
 b=ocWrxmcb3waZShVgc2SBqUn3xaOLmXDwl8o7Qui9eDK4tg9Rs0F2mnaIaiLfWIyG4t0h+6
 8F+XSqDz9YkOHav9/DJxT/jGJqYpgWbcObpaD/5nrAAM+hgp0eEltcCyvNR6/0exbFv3tz
 dLRqNkYDIWdp32jAS23JcDVN76ACAdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783536689;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c0FjSMjrE921UgXZzfaRjwYXUZqmW10LGyy8xPKuI+g=;
 b=w68zRHUBlu/b64oJNAJeWUCIHWmPexFDv6+jzk5i40/zXcJjpyRUxcoEgknw+Fb+AJxdQc
 /8fDQygmi8iIK1DQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=S05IJPmN;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VMdA4oVR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783536688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c0FjSMjrE921UgXZzfaRjwYXUZqmW10LGyy8xPKuI+g=;
 b=S05IJPmNGb63/rWJj3PkyKLyACP/gxDR6/KEdPdoxilljWOwRFZGU/uhgJbUli36lbFUjI
 cITjD4+6fJJDndFL4Cg+3jrPNtSwtQOuZ7N3KgJhl1uqocGqfcNK/locgSGs+BNrdJ6jPl
 ob3HdrdGy6SPuDsYPbSsY9VEPvm3P2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783536688;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c0FjSMjrE921UgXZzfaRjwYXUZqmW10LGyy8xPKuI+g=;
 b=VMdA4oVRjcI728VIFnjZ0Oso7kS2gfbGvuGwAyyYOoh2uop60lKOgrGrSGpJrVfOg7JFSn
 RZUTuRYI1hU1HbCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD0A1779AE;
 Wed,  8 Jul 2026 18:51:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9PDhLDCcTmq0AQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 08 Jul 2026 18:51:28 +0000
Date: Wed, 8 Jul 2026 20:51:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ak6cJvCYTVfheJFA@yuki.lan>
References: <20260423120309.18049-6-chrubis@suse.cz>
 <69f06327.050a0220.2201aa.058f@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69f06327.050a0220.2201aa.058f@mx.google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D1FE3758C6
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/8] syscalls: Add epoll_wait10
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
> > +static void check_epoll_event(const char *desc)
> > +{
> > +	struct epoll_event ret_ev;
> > +	char buf[1024];
> > +
> > +	TEST(epoll_wait(efd, &ret_ev, 1, 1000));
> > +	if (TST_RET < 1) {
> > +		tst_res(TFAIL | TTERRNO,
> > +			"epoll_wait() after %s returned %li", desc, TST_RET);
> 
> return; here.

Notice that we need to drain the notification a the bottom, so the best
we can do is goto drain;

> > +	} else if (!(ret_ev.events & (EPOLLPRI | EPOLLERR))) {
> > +		tst_res(TFAIL,
> > +			"after %s: events %x, expected EPOLLPRI or EPOLLERR",
> > +			desc, ret_ev.events);
> > +	} else {
> > +		tst_res(TPASS,
> > +			"epoll_wait() reported event after %s", desc);
> > +	}
> 
> And here I would use TST_EXP_* instead. But feel free to ignore.

However I will shorten this part to TST_EXP_EXPR() so that we have only
one else branch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
