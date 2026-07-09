Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8532DC43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 13:40:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF7023E294E
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 15:40:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1CB13CD4AD
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:40:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E0DDA1400DC0
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:40:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7E78D7621A;
 Thu,  9 Jul 2026 13:40:33 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DBC5779AA;
 Thu,  9 Jul 2026 13:40:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +X/DGdGkT2p7PAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 09 Jul 2026 13:40:33 +0000
Date: Thu, 9 Jul 2026 15:40:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ak-kwx287miu1Bki@yuki.lan>
References: <20260709085353.345957-1-chrubis@suse.cz>
 <20260709085353.345957-2-chrubis@suse.cz>
 <20260709105159.GA874350@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260709105159.GA874350@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 7E78D7621A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/9] syscalls: Add epoll_create03
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
> > +static void setup(void)
> > +{
> > +	int fd;
> > +
> > +	variant_info();
> > +
> > +	maxfds = SAFE_SYSCONF(_SC_OPEN_MAX);
> > +	fds = SAFE_MALLOC(maxfds * sizeof(int));
> > +	memset(fds, -1, maxfds * sizeof(int));
> > +
> > +	fds[0] = SAFE_OPEN("dummy", O_RDWR | O_CREAT, 0700);
> > +	nfds = 1;
> > +
> > +	for (int i = 1; i < maxfds; i++) {
> > +		fd = dup(fds[0]);
> > +		if (fd == -1)
> > +			break;
> > +		fds[nfds++] = fd;
> > +	}
> 
> How many files are created is done via `ulimit -n`, right? (not sure if there
> is file for it in /proc/sys).

It's not about created files. There is a per-process limit on the number
of file descriptors. That can be accessed either via sysconf() or via
rlimit() and the values are also exported into /proc/$PID/limits.

> Would it be worth we check that? Or at least check that at least 2 files were
> opened? Maybe this check should be rather put into dup03.c.

I guess that it would make more sense to put such check into dup03.c.
However we would have to scan the whole file descriptor table first to
check on how many fds are already open.

Something as;

	int used_fds = 0;

	for (i = 0; i < maxfds; i++) {
		if (fcntl(i, F_GETFD) != -1)
			used_fds++;
	}

Then we can expect that the limit for the test is maxfds - used_fd

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
