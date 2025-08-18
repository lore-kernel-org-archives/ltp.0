Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA391CA0ED1
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 15:36:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A0BB3CC912
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 17:36:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19D3A3C0639
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 17:35:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 658161A006F7
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 17:35:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 08A5F21249;
 Mon, 18 Aug 2025 15:35:43 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2DA813A55;
 Mon, 18 Aug 2025 15:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id M/uwJ05Io2gXNAAAD6G6ig
 (envelope-from <pfalcato@suse.de>); Mon, 18 Aug 2025 15:35:42 +0000
Date: Mon, 18 Aug 2025 16:35:44 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <wfecvwzibjekda24wzhou5ppngxhptrmn4ks4kg4adwwiizefz@z2ddqcqhr6pd>
References: <20250814152659.1368713-1-florian.schmaus@codasip.com>
 <20250818130038.GA21418@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250818130038.GA21418@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 08A5F21249
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] sigrelse01: Select signals based on
 SIGRTMIN/SIGRTMAX for musl compat
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

On Mon, Aug 18, 2025 at 03:00:38PM +0200, Petr Vorel wrote:
> Hi Florian, Pedro,
> 
> > This avoids selecting signal 34 when the test is run using
> > musl. Signal 34 is used internally by musl as SIGSYNCCALL.
> > Consequently, musl's signal() will return with an error status and
> > errno set to EINVAL when trying to setup a signal handler for signal
> > 34, causing the sigrelse01 test to fail.
> 
> +1, now it works on both glibc and musl (and hopefully in the rest of libc).
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> 
> > Thanks to Pedro Falcato for suggesting using SIGRTMIN and SIGRTMAX for
> > this check.
> 
> nit: @Florian instead of the above I'll add:
> Suggested-by: Pedro Falcato <pfalcato@suse.de>
> 
> @Pedro Can I merge with your RBT?

Assuming you mean Reviewed-by, yep, all fine by me.

-- 
Pedro

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
