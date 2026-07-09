Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34F1C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 08:36:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0F313E5C62
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 10:36:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 403EA3E28D0
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 10:36:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BEEED1400961
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 10:36:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BD62476062;
 Thu,  9 Jul 2026 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783586187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4OpQSOZJVheQDdAvDc/Uoc98jVbZSHpfbuOpTrgQpAo=;
 b=MzCVKmMT+vN/Lp7RfpDYODbwiKKn01qbNehr0PLXrBkF4hprQUQY49jFj9/7A3t28WEUf0
 XNDOnSCxSeTvAicA0rlBy3obt9/YoNP4NB7v7U0MiGjq9JDyTHe0BdF7ORXZddX4Tp1+tm
 Kxr6Qg9bS9ez33e2WyMAQEHkvMVweAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783586187;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4OpQSOZJVheQDdAvDc/Uoc98jVbZSHpfbuOpTrgQpAo=;
 b=RD1raRREBrQsVCJhgqapAIPZg6uSB9A+lbi3YalfKaWrUEj/DM239yAoskON7DymDDpKHs
 Uy7M5nkItIPu3fCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JbMn78Jo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="sTIQFR/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783586184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4OpQSOZJVheQDdAvDc/Uoc98jVbZSHpfbuOpTrgQpAo=;
 b=JbMn78JoHY1eAanHFlhkfFB8L+FamUs3yYC4Uz7/HaKz4VvN3DZW7HBgDVWrCfjfWsRtzx
 F1Dn0PRBtonmW+mJKMp0hX9+mZpgCXiDDL7xWTQ6qla8/Wj5mx4Es9vOVbayof26TzLfkx
 UmyWj6aCCWMTCmFAYP82/v4d5LuOhck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783586184;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4OpQSOZJVheQDdAvDc/Uoc98jVbZSHpfbuOpTrgQpAo=;
 b=sTIQFR/xyWdpYHZYUduXBNjdoFO2FS/V7LdK2bk2eb+QF4Pnj9lrOHKJzbJzsNV5uYPlw3
 KJsG0YdWVWWLyWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE550779AA;
 Thu,  9 Jul 2026 08:36:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1qqdKYhdT2rIDAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 09 Jul 2026 08:36:24 +0000
Date: Thu, 9 Jul 2026 10:36:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ak9delVGOCdSmFmF@yuki.lan>
References: <20260423120309.18049-8-chrubis@suse.cz>
 <69f06266.050a0220.162ac9.3bf0@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69f06266.050a0220.162ac9.3bf0@mx.google.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BD62476062
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 7/8] syscalls: Add epoll_wait12
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
> > +static int efd = -1, fds[2] = {-1, -1};
> > +
> > +static void fill_pipe(int fd)
> > +{
> > +	char buf[4096];
> > +	struct pollfd pfd = {.fd = fd, .events = POLLOUT};
> > +	int nfd;
> > +
> > +	memset(buf, 'a', sizeof(buf));
> > +
> > +	do {
> > +		SAFE_WRITE(SAFE_WRITE_ANY, fd, buf, sizeof(buf));
> > +		nfd = poll(&pfd, 1, 0);
> 
> Why we don't have a SAFE_POLL() ? I just noticed how many times we are
> following a manual errors handling pattern inside the tests.

I will add it in the v3.

> > +		if (nfd == -1)
> > +			tst_brk(TBROK | TERRNO, "poll()");
> > +	} while (nfd > 0);
> > +}
> > +
> > +static void run(void)
> > +{
> > +	pid_t pid;
> > +
> > +	SAFE_PIPE(fds);
> > +	fill_pipe(fds[1]);
> > +
> > +	efd = SAFE_EPOLL_CREATE1(0);
> > +
> > +	struct epoll_event ev = {
> > +		.events = EPOLLOUT,
> > +		.data.fd = fds[1],
> > +	};
> > +
> > +	SAFE_EPOLL_CTL(efd, EPOLL_CTL_ADD, fds[1], &ev);
> > +
> > +	pid = SAFE_FORK();
> > +	if (!pid) {
> > +		SAFE_CLOSE(fds[0]);
> > +
> > +		TEST(epoll_wait(efd, &ev, 1, 5000));
> 
> We have SAFE_EPOLL_WAIT(), is there a reason why not to use it?
> Do we want to track the TST_RET ?

We do not use SAFE_MACROS() for the syscall that we test, because we
want to report the failure as TFAIL and not as TBROK.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
