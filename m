Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0DFCD4F54
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 12:17:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF1A53C9D40
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 14:17:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0C3E3C5D31
 for <ltp@lists.linux.it>; Wed, 27 May 2026 14:17:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 339671400DC1
 for <ltp@lists.linux.it>; Wed, 27 May 2026 14:17:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B88A36AA81;
 Wed, 27 May 2026 12:17:15 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A09D05A814;
 Wed, 27 May 2026 12:17:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UilDJsvgFmptXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 27 May 2026 12:17:15 +0000
Date: Wed, 27 May 2026 14:17:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260527121714.GA246122@pevik>
References: <20260527103756.448843-1-chrubis@suse.cz>
 <20260527112911.GA194670@pevik> <ahbgAdCYu46rp83q@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahbgAdCYu46rp83q@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: B88A36AA81
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/madvise06: Fix sporadic not enough RAM
 TCONFs
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

> Hi!
> > > On systems with <= 2GB RAM the test produced sporadic TCONFs. That is
> > > because even if the test setup does sync() and drops caches the system
> > > starts fauting in pages immediatelly after caches were dropped. It may
> > > easily happen that system may fault in a few hundred of MBs of memory
> > > betwen the write to drop_caches and the time sysinfo() syscall returns.

> > > The correct fix is to use the MemAvailable metric from /proc/meminfo
> > > that includes both free memory and caches and is more realistic estimate
> > > of how much memory can be consumed by a test. We even have helper
> > > functions in the test library so we simply make use of them.

> > Thanks for an investigation!
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > ...
> > > -	sysinfo(&sys_buf_start);
> > > -	if (sys_buf_start.freeram < 2 * CHUNK_SZ) {
> > > -		tst_brk(TCONF, "System RAM is too small (%li bytes needed)",
> > > -			2 * CHUNK_SZ);
> > > +	long long avail_mem = tst_available_mem();
> > > +	long long avail_swap = tst_available_swap();
> > > +	long long chunk_kb = 2 * CHUNK_SZ / 1024;
> > > +
> > > +	if (avail_mem < chunk_kb) {
> > > +		tst_brk(TCONF, "System RAM is too small %llikB (%llikB needed)",
> > > +			avail_mem, chunk_kb);

> > nit: I'd print also the current (not big enough) values (I know that the old code).

> Huh? That's what the test does after my changes, we print both avail_mem
> and chunk_kb after the change.

I'm sorry to be blind today. Thanks for doing that.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
