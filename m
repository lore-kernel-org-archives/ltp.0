Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B03DD3B998
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 14:50:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84AA33DB1EF
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 15:50:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFC443DB1C1
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 15:50:07 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2B33C101BC60
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 15:50:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 922CB21177;
 Tue, 26 Nov 2024 14:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732632603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I3ilpm7Peq+IjYakIBBsK836jwAmVCakWXh8USWLKGY=;
 b=t1rXiBRvs4gug8o2sxDJhPKzFfPSN0nqtUL8HZj2qszI0ibdnG5lg5y2IUVUcASwiKLDRU
 B3zQsA4/DeMTKNlo/zlTvc8ClOiNm1oyavY4vzDVjfzNKaJT0+DevwzxCykPoACWL/bVAQ
 tN6T0GYQ+La/qvVP1i0uFGpdZAKOvY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732632603;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I3ilpm7Peq+IjYakIBBsK836jwAmVCakWXh8USWLKGY=;
 b=mlEh/HYSa6Ner/0OEK3BLEBtSOUK5rLCsKPAfXHH80WUANPvaLE3VvpLC7Yn0CBeMhjffv
 T0961+ZkMyH+yhCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UCyokEs2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OctBQ7zi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732632602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I3ilpm7Peq+IjYakIBBsK836jwAmVCakWXh8USWLKGY=;
 b=UCyokEs2G0O+Hr6RRGqPtDTkmxUbvXJ4/Rts2TB7werv8izwaDHopeyqnCEMgkHxwIeG8T
 Gk7PJ59bt4uAfzQcfVHFXbbq2wh4qIXY1oJDcWX3zmjwmu8qFdCNV6tEnmiOyPAWvQbosg
 DAzsIcJIKhmX/Zfdqc2XHlvfMF71lPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732632602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I3ilpm7Peq+IjYakIBBsK836jwAmVCakWXh8USWLKGY=;
 b=OctBQ7zicDHbr4gagDHt0afVmZEllx4LEEdm4pOVLoDlbSTcig0qpifwI9JfY2SojetPsL
 LR9i+5x/kjHAamCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8174E13A27;
 Tue, 26 Nov 2024 14:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NEPIHhrgRWcSfwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 26 Nov 2024 14:50:02 +0000
Date: Tue, 26 Nov 2024 15:50:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Z0XgJVa9czWm2YMc@yuki.lan>
References: <20241115164101.17983-1-chrubis@suse.cz>
 <CAASaF6wWy6HwbBRmTQcYg3WRwhxexE1ZUernL4WKQzOJYeO+Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6wWy6HwbBRmTQcYg3WRwhxexE1ZUernL4WKQzOJYeO+Eg@mail.gmail.com>
X-Rspamd-Queue-Id: 922CB21177
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,yuki.lan:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [RFC] lib/tst_test.c: Fix tst_brk() handling
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
> > This makes the tst_brk() handling cleaner and saner as instead of
> > propagating the tst_brk() result in a return value an abort flag is
> > introduced into the shared memory.
> >
> > Now:
> >
> > - All the processes but the library one that reports the results exit
> >   with 0
> > - tst_brk(TBROK, ...) increments result conters, sets the abort flag.
> >   and exit current process
> > - all other tst_brk() variants will just increments the countes and
> >   exits the current process
> 
> It removes the easy way for parent to check that child hasn't run into
> any issues,
> but I can't recall a specific test we have today that depends on it.

I suppose that we can make the tst_brk flag part of a public API if
anyone needs that but I guess that in the case of tst_brk(TBROK, ...)
all we want is to make the test processes exit as soon as possible.

> > This makes the tst_brk() behavior well defined so we can now even call
> > tst_brk() with TFAIL and TPASS as well.
> 
> What's the use-case for it? Wouldn't it be more clear to just report
> TPASS + exit?

I think this makes actually the API more consistent. I.e. tst_res()
reports result and tst_brk() reports result and exits the current
process.

I think that we all carry a mental baggage that associates the tst_brk()
call with an error, but that is something we forced upon ourselves.
AFAIK it's short for tst_break, which itself only suggests that it does
exit the current process, similar to break being used in switch()
statement.

> > Open question (may be done in a separatep patch):
> >
> > Should tst_brk(TBROK, ...) apart from setting the flag also send sigkill
> > signal to the test process group to kill any leftover test processes?
> 
> Or heartbeat checking the abort flag and doing it from the library?

The heartbeat handler may be a good place to put this check into and I
was also thinking of adding checks to all SAFE_MACROS() and make them
something as cancelation points since they are supposed to exit the test
on a failure anyways.

But that could be only done once we have the flag in place and finally
have persistent way how to check that something went wrong.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
