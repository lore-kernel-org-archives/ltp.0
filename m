Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF83C4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 12:19:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 294053CB678
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 13:19:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B5B43CB491
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 13:19:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BF53110149CA
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 13:19:44 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0F0BE2209B;
 Thu, 14 Dec 2023 12:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702556382;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1y+JivZhWRTEhaorK/HIQrTPlTYrQSnDiNg8AtmJMzM=;
 b=A6zBNo5NrkX2G0rKsRqHd26BGY5ItjLDr4Wt9oevSL05IQN6AlMlBrLZf7V8CbO/xh/r0s
 YdinL18SsWV8GM6wIsB/viBbwt/M8tdLonJOipYb84vgt04gR+P1I9ty4VQUX5LjmSjMeQ
 cTpcFB/qzl+UpTtQHhHOcz/iyupQE1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702556382;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1y+JivZhWRTEhaorK/HIQrTPlTYrQSnDiNg8AtmJMzM=;
 b=niXBkIlxONi9jgHbaLKAk/Jn5ni7xWWl8jfdt47W5NfAirNaIn7S2hu303xywWoXhh3ZDD
 SG6o8b1F2EomQzDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702556382;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1y+JivZhWRTEhaorK/HIQrTPlTYrQSnDiNg8AtmJMzM=;
 b=A6zBNo5NrkX2G0rKsRqHd26BGY5ItjLDr4Wt9oevSL05IQN6AlMlBrLZf7V8CbO/xh/r0s
 YdinL18SsWV8GM6wIsB/viBbwt/M8tdLonJOipYb84vgt04gR+P1I9ty4VQUX5LjmSjMeQ
 cTpcFB/qzl+UpTtQHhHOcz/iyupQE1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702556382;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1y+JivZhWRTEhaorK/HIQrTPlTYrQSnDiNg8AtmJMzM=;
 b=niXBkIlxONi9jgHbaLKAk/Jn5ni7xWWl8jfdt47W5NfAirNaIn7S2hu303xywWoXhh3ZDD
 SG6o8b1F2EomQzDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 71E37138F2;
 Thu, 14 Dec 2023 12:19:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id U3laF93yemXOcAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 14 Dec 2023 12:19:41 +0000
Date: Thu, 14 Dec 2023 13:19:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231214121935.GA800332@pevik>
References: <20231211161807.526714-1-pvorel@suse.cz>
 <20231211161807.526714-2-pvorel@suse.cz> <ZXoAKxPxfXxU8bxw@rei>
 <20231213234044.GA774490@pevik> <ZXrGTkJIh4YluH3T@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZXrGTkJIh4YluH3T@rei>
X-Rspamd-Queue-Id: 0F0BE2209B
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=A6zBNo5N;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=niXBkIlx;
 dmarc=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz
X-Spamd-Result: default: False [0.29 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_SPF_SOFTFAIL(0.00)[~all];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+];
 MX_GOOD(-0.01)[]; RCPT_COUNT_SEVEN(0.00)[7];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-0.00)[18.07%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DMARC_NA(0.00)[suse.cz];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lib/tests: Add test for testing tst_res()
 flags
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > Maybe it would make sense the loop over the flags here instead, so that
> > > we don't have to produce second TPASS message.

> > I'm not sure if I follow you. I wanted to use the flag in tst_res(),
> > but for these two there would be tst_brk(TBROK) due missing result.

> I mean that if we put TBROK last in the array we can do:

> 	for (i = 0; i < ARRAY_SIZE(...); i++)
> 		tst_res(....);

Yeah, I realized that later (it was too late already when I wrote the question).
My motivation was that extra TPASS also test functionality, we test, that TINFO
and TDEBUG are not results. But this is probably not important, thus I'll just
loop over array. And sure, I'll put TBROK to the end.

Kind regards,
Petr

> I.e. loop over all the flags in a single call of the function, which
> would mean that we do not have to add artificial TPASS at the end.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
