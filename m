Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1ACCD3427
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 17:48:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 371B63E6B12
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 19:48:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F0A43E620E
 for <ltp@lists.linux.it>; Mon,  4 May 2026 19:48:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 20B756005CF
 for <ltp@lists.linux.it>; Mon,  4 May 2026 19:48:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AC61C6B46B;
 Mon,  4 May 2026 17:48:21 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98882593A3;
 Mon,  4 May 2026 17:48:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TsLuI+Xb+Gl7IwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 04 May 2026 17:48:21 +0000
Date: Mon, 4 May 2026 19:48:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <afjb4yWvM8Abh98q@yuki.lan>
References: <20260411092452.211540-1-rbranco@suse.de>
 <20260415080623.164440-1-rbranco@suse.de>
 <afjANI7jr23hP4IJ@yuki.lan>
 <bc75c487-59db-47a8-a2f3-db860919b35b@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bc75c487-59db-47a8-a2f3-db860919b35b@suse.de>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: AC61C6B46B
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] userfaultfd: Use two-step handshake to probe
 features
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
> >> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
> >> +	uffdio_api.api = UFFD_API;
> >> +	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> >> +	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
> >> +		tst_brk(TCONF, "UFFD_FEATURE_PAGEFAULT_FLAG_WP not supported");
> >> +	SAFE_CLOSE(uffd);
> > I do not get why are we adding this code when we do the same just a few
> > lines below. Shouldn't just this suffice?
> 
> That's why the comment is needed because it isn't obvious.
> 
> We need to do the 2 step handshake, first with uffdio_api.features set 
> to zero, then again with the desired features.

The obviously the comment is not useful because it does not explain
anything :-).

Looking at the kernel code, it seems to set the output flags
uncoditionally so we can use that.

Or check for EINVAL when we pass unsupported flags.

However I would put this code into a common header and call it only in
the test setup (so that it's not executed on each test iteration).

#define CHECK_UFFD_FLAG(flag) do { \
        ... \
	if (!(uffdio_api.features & (flag))) \
		tst_brk(TCONF, #flag " not supported"); \
	... \
} while (0)


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
