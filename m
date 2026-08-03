Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F29C55184
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 09:22:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 526603E4B7F
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 11:22:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F29813E16F8
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 11:22:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 785DB10006CC
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 11:22:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0ABCD3F54;
 Mon,  3 Aug 2026 09:22:12 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFABF779A1;
 Mon,  3 Aug 2026 09:22:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A4OHOcNdcGrUFAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 03 Aug 2026 09:22:11 +0000
Date: Mon, 3 Aug 2026 11:22:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <anBdxCKHlpedf2rf@yuki.lan>
References: <20260731054548.133241-1-pvorel@suse.cz>
 <6a6c5226.d5b2c389.166717.d42a@mx.google.com>
 <20260803091348.GA216243@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260803091348.GA216243@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 0ABCD3F54
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> since we have all active LTP maintainers enabled as patchwork maintainers in the
> kernel.org instance [1] I'd like in few hours merge this patch to finally move
> to patchwork.kernel.org. FYI we already have 18 patches on it, AI review is
> there as well.
> 
> @Cyril @Li @Jan: Could you please ack this patch?

Acked-by: Cyril Hrubis <chrubis@suse.cz>

Btw, we may want to add the patchwork link into kernel MINTAINTERS file, 

> I wonder when to stop receiving patches on the old ozlabs instance [2] We should
> probably ask for it soon so that people don't think we stop maintaining it.

Sounds about right.

> I hoped that the last patch on that instance would be "Switch to
> patchwork.kernel.org" [3], but there are new patches now. OTOH we then no longer
> get updates for the old patchsets (there are 54 patches which aren't on the new
> kernel.org instance + already 6 duplicates).
>
> Other question is when to ask about for removing the old instance. I'd keep it
> at least for some time (can be useful + there might be bookmarks, instance has
> 13079 patches, first one in 2018-02-28). WDYT?

I would keep it around at least for a year or two, I sometimes look up
old patches there.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
