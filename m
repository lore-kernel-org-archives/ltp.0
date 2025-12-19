Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB03D78783
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 14:41:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D7E33D0547
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 15:41:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02DBC3CF2F9
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 15:41:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CF0A4200BA9
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 15:41:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ACB46336DB;
 Fri, 19 Dec 2025 14:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766155270;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKC4eZNRI3G5PlZJyxDOMdataXSa9ohs9dv+UyNnx80=;
 b=dGyYkg8DdBXsLTLE6o10WceHsju4AOciL7v/FuEUBO/o8QbdvXg8j6tnykLgsYZDhqVK+P
 AKYh+14IAA9jdbw6sCc05pCfoJsk0gNs17ZUsQIbX7oi+WXU2i5lHq09SR4c602KKTyjBI
 iON8W+pOrju1J0uzBOkXoJM1DIzD8Yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766155270;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKC4eZNRI3G5PlZJyxDOMdataXSa9ohs9dv+UyNnx80=;
 b=NTs2zRWnfIxteLV7QdSPEhbRjahasUYZExrCYUXm5gJ12en/XY95ucCvzeNKTAarluDKM5
 d9JK9LgTCekAf6BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uZ+siXFU;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7CQv3sNY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766155269;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKC4eZNRI3G5PlZJyxDOMdataXSa9ohs9dv+UyNnx80=;
 b=uZ+siXFUUgWqWOWSTv+9hLoD2LYrnswfPOYO2nalzZQo9QJIw0FVjnVeOt2GLiT4uc5YGu
 J9oy9W9tE+/Cxr0awTEyU3bKn4OvlCrQOiEY4xI7uUsQfUzjCohxKOYSroP7HHQuCZbf6V
 vKTYZPLMPAqZ59cNC6YK5yWP68TqXp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766155269;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKC4eZNRI3G5PlZJyxDOMdataXSa9ohs9dv+UyNnx80=;
 b=7CQv3sNYYssaMIOS7fYYWB4ZAP325K7iRx5Jz6nWyis2H/zrPKhclZoGuiiWE0zyzj3SlC
 qvRa+cRc39lgPrCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81B4B3EA63;
 Fri, 19 Dec 2025 14:41:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /gMFHQVkRWnkPAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Dec 2025 14:41:09 +0000
Date: Fri, 19 Dec 2025 15:41:02 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Li Wang <liwang@redhat.com>
Message-ID: <20251219144102.GA325483@pevik>
References: <20251219094219.151887-1-pvorel@suse.cz>
 <aUUteQjVmMx1R_X9@yuki.lan> <20251219140216.GA247368@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251219140216.GA247368@pevik>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ACB46336DB
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/1] swapon03: Try to swapon() as many files
 until it fails
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> [ Removing Michal to not bother him with LTP internals ]

> > Hi!
> > >  	tst_res(TINFO, "Successfully created %d swap files", swapfiles);
> > > -	MAKE_SMALL_SWAPFILE(TEST_FILE);

> > This should stay here, right? I suppose that the test works even when we
> > pass non-existing file in the verify_swapon() but we shouldn't bet on
> > that.

> FYI swap file is created by is_swap_supported(TEST_FILE). But sure, I can
> also keep MAKE_SMALL_SWAPFILE(TEST_FILE) to make sure file is also created.
> We talked about related cleanup, which I wanted to postpone, but should I
> refactor is_swap_supported() to not include swapon() call. Because when there
> are too many swap files already mounted, tests is skipped with:

> libswap.c:224: TCONF: Permission denied for swapon()
> due EPERM, which is actually subject of testing for swapon03.c

And, as I posted in v3 [1], we can avoid this work, if we require at least
single swap created by the test. Or, allow a corner case all swaps are used,
but just verify that by counting swap in /proc/swaps.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20251219142512.GC247368@pevik/

> I'm not sure about naming. Maybe have is_swap_supported() without swapon() call
> (for swapon03.c) and create new function is_swapon_supported(), which would call
> is_swap_supported() + swapon() and swapoff() (for all other tests).

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
