Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789BBCA5FA1
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 13:25:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D09763E58EA
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 15:25:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0A883C5493
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 15:25:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3F5B4600687
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 15:25:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B4C4421A95;
 Tue, 29 Sep 2026 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790688308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pwrp1l1dKqIA/zrORZ9bgE5NNG4aOkhanImrEA6MGhg=;
 b=3X3vdnBNS8JsA002JKAUpvZ1HWQy/bq89/QWSZ1qOUQ7UrukkoenB2whhoEscESmScpHcJ
 WWKQZ72y0x5jjCd96K7wT4UDfwAoeQ6Wx25lMGC2qrBtjkhzXeK3SON9Q0vscUL0CcS2kY
 nLfIvX+EkiL7u6iNFBxz/EiFtg/5KCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790688308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pwrp1l1dKqIA/zrORZ9bgE5NNG4aOkhanImrEA6MGhg=;
 b=V550o0Hm3fpyJaUpyYIuMHarbIpXKeWE5wQqSlJ85LXImJdKlzf/jB3z+p5t/wblHcjHZe
 aiFch/PFblOm+hDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790688304;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pwrp1l1dKqIA/zrORZ9bgE5NNG4aOkhanImrEA6MGhg=;
 b=E8ZAQyI0mhSSqCPHELHEMJXsf+I8bdbwafdFkvHhJrPhW19gJ+xgp0Nyu8juqQjYSrsqbL
 30ah54/3Aqssu8MnFPVK2dqAHt2gRg67o1gLHswN+uBHg9tdEhkVzZT+qu93+GvoMhPvBd
 DNaHXUlZ3zJzy7VFsnhFGBEI3BvQYhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790688304;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pwrp1l1dKqIA/zrORZ9bgE5NNG4aOkhanImrEA6MGhg=;
 b=LpTHFZPLSYeyZQf/GD7/f2ycBOVRojd9OE2KcgJqbFpGAQApwtwDLxjcDpE2swTRRcyFV7
 5dztdJGzRj9fFxAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70EA7136E4;
 Tue, 29 Sep 2026 13:25:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wUr2EDC8u2oaGQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 29 Sep 2026 13:25:04 +0000
Date: Tue, 29 Sep 2026 15:24:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260929132458.GA2471077@pevik>
References: <20260808150331.127440-1-avinesh.kumar@suse.com>
 <20260929114945.GA2456273@pevik> <aruobnaT_g0U7CDo@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aruobnaT_g0U7CDo@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[opengroup.org:url,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,austingroupbugs.net:url];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] openposix: timer_*/speculative: Handle SIGSEGV
 on invalid timer ID
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > I'm not sure if the approach of creating bogus timer_t is a good idea anyway.
> > Shouldn't be just some timer_t tid set to invalid value? That would IMHO be
> > less awkward solution.

> There is no documented invalid value. It's a opaque handle we get from
> libc and different versions of libc interpret the value differently.
> Sometimes it's a pointer, sometimes it is not and we have no idea what
> it is until we try to pass it to the timer functions.

> So choosing safe enough safe value and handling SIGSEGV is probably the
> best we can do.

I trust Cyril that this is safer.

FYI, not sure how much relevant, but the change was reported by Rich Felker
(musl author) in 2013 [1]. IEEE Std 1003.1-2008, 2016 Edition is the first
standard which introduced it as an undefined behavior [2]:

	The behavior is undefined if the value specified by the timerid argument to
	timer_delete() does not correspond to a timer ID returned by timer_create()
	but not yet deleted by timer_delete().

The last standard *without* is IEEE Std 1003.1, 2013 Edition [3].

Kind regards,
Petr

[1] https://austingroupbugs.net/view.php?id=659
[2] https://pubs.opengroup.org/onlinepubs/9699919799.2016edition/functions/timer_delete.html
[3] https://pubs.opengroup.org/onlinepubs/9699919799.2013edition/functions/timer_delete.html

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
