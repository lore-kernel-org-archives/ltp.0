Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187B9E77188
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 14:16:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90C2C3C4C16
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 15:16:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1541C3C291A
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 15:16:38 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0F2431BD2567
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 15:16:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 509C01F399;
 Mon,  6 Jan 2025 14:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736172997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5H3POxqp8hoxPbs/YUgus7xP0bMA2CXfJx3Rj5KM8RA=;
 b=u0/JUhjnjrEzb7FZL8nGmRtfNI7uda+/cW1buswgaDbF+rvfM4cGag7XeevUjhbrt11L3Z
 xHx2KV9TCI3KCY6FrWaYpohEuQl32DhP0NR6rKwReiMq3/PnGBxTP9sR7SL6oOYimhwISU
 bmmbZBP6TzlxCUCVUC6OzMo+U7Lnk0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736172997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5H3POxqp8hoxPbs/YUgus7xP0bMA2CXfJx3Rj5KM8RA=;
 b=BUEXLWQlRa5UVSmkxgZqF7CHNCuI0N3vraNQUKvXNbkQ9kkFJhSZvLyqtUX1CuWJ7jqbiz
 cMFpP6CtcEwN6WCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="u0/JUhjn";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BUEXLWQl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736172997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5H3POxqp8hoxPbs/YUgus7xP0bMA2CXfJx3Rj5KM8RA=;
 b=u0/JUhjnjrEzb7FZL8nGmRtfNI7uda+/cW1buswgaDbF+rvfM4cGag7XeevUjhbrt11L3Z
 xHx2KV9TCI3KCY6FrWaYpohEuQl32DhP0NR6rKwReiMq3/PnGBxTP9sR7SL6oOYimhwISU
 bmmbZBP6TzlxCUCVUC6OzMo+U7Lnk0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736172997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5H3POxqp8hoxPbs/YUgus7xP0bMA2CXfJx3Rj5KM8RA=;
 b=BUEXLWQlRa5UVSmkxgZqF7CHNCuI0N3vraNQUKvXNbkQ9kkFJhSZvLyqtUX1CuWJ7jqbiz
 cMFpP6CtcEwN6WCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0FA7137DA;
 Mon,  6 Jan 2025 14:16:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Z/daNcTle2duNwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 06 Jan 2025 14:16:36 +0000
Date: Mon, 6 Jan 2025 15:16:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250106141635.GA323533@pevik>
References: <20250106140402.52196-1-pvorel@suse.cz>
 <119d081a-f1cc-400f-a278-27e6e33495ac@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <119d081a-f1cc-400f-a278-27e6e33495ac@suse.com>
X-Rspamd-Queue-Id: 509C01F399
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] runtest/ltp-aiodio.part4: Remove duplicate
 entries
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

> Hi Petr,

> On 1/6/25 15:04, Petr Vorel wrote:
> > Duplicate content was added in 67ce2884aa (2006).

> > It probably did not make sense to run it more times even at the time,
> > but it certainly does not make sense now (runltp and kirk run tests
> > sequentially one by one).

> > While at it, remove bogus comments.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >   runtest/ltp-aiodio.part4 | 55 ++--------------------------------------
> >   1 file changed, 2 insertions(+), 53 deletions(-)

> > diff --git a/runtest/ltp-aiodio.part4 b/runtest/ltp-aiodio.part4
> > index de00b8a786..8e7354296d 100644
> > --- a/runtest/ltp-aiodio.part4
> > +++ b/runtest/ltp-aiodio.part4
> > @@ -1,65 +1,14 @@
> >   aio01 aio01
> >   aio02 aio02
> > -#Running dio_sparse & dirty tests
> >   DI000 dirty
> >   DS000 dio_sparse
> Uhm, I remember that we discussed with Cyril about it in the past. The dirty
> test was made in order to stress IO before dio_sparse if I'm not wrong.

Andrea, thanks for info.

@Cyril? If relevant maybe we should just document it. Does it apply to all
duplicates? I wonder if it makes sense to run whole runset for 45 min when we
are testing something mainline does not care about it's performance.

https://lore.kernel.org/ltp/20240722090012.mlvkaenuxar2x3vr@quack3/

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
