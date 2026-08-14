Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9471DC5CFC1
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 10:50:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BFC23C72EC
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 12:50:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C34F73C57AC
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:50:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9556060084B
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:50:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 806B53EA7;
 Fri, 14 Aug 2026 10:50:39 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E97078337;
 Fri, 14 Aug 2026 10:50:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id s2h0Gf/yfmpKOQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 14 Aug 2026 10:50:39 +0000
Date: Fri, 14 Aug 2026 12:50:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <an7y_pMz9noBnKcW@yuki.lan>
References: <20260810160048.1040517-1-pvorel@suse.cz>
 <20260810160048.1040517-4-pvorel@suse.cz>
 <anxTyVyeeMo6EQfG@yuki.lan> <20260812130025.GB1758016@pevik>
 <an7pLCWfdgEPV6G1@yuki.lan> <20260814104002.GA1950245@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260814104002.GA1950245@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 806B53EA7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/7] lib: Add support for max_kver to struct
 tst_test and tst_fs
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
> > Which ones?
> 
> I'm about to merge the original approach for fanotify20 (just to join split
> string):
> https://lore.kernel.org/ltp/20260616210448.12175-2-anonymemeow@gmail.com/

Yes please. Feel free to add my Reviewed-by:

> I guess these 2 could be merged:
> https://lore.kernel.org/ltp/20260810160048.1040517-6-pvorel@suse.cz/
> https://lore.kernel.org/ltp/20260810160048.1040517-5-pvorel@suse.cz/

Reviewed.

> And then we are done with the test fixes, I wonder if it's worth to add
> lib/newlib_tests/tst_max_kver_old.c (only this one) from this patchset
> 
> https://lore.kernel.org/ltp/20260810160048.1040517-8-pvorel@suse.cz/

So you stil want to add .max_kver to the tst_test structure?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
