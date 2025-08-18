Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0CCCA0EE4
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 20:41:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DB0F3CC71C
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 22:41:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 039353C06B5
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 22:41:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D8E8260240B
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 22:41:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB2841F453;
 Mon, 18 Aug 2025 20:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755547335;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y+auqnjggHVAQRLBWPSG9sJydxmLzxwNTkkpqwglif8=;
 b=RMyInwxaLuTxbxPLUkbQ7Moq+TzfaZ2F+g9zZvrdtA3EcqmIpc06GJhF/TR+gey9RqUa3G
 qX+HtaCZ1KCei+mApg443IkvGKBdGLG3CSeMZ7rfSFeDe2LbDrFFdVqoBDcpfjLWHE46To
 sSr7XQKneki4kZF6D8Otl5v2xKyCXlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755547335;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y+auqnjggHVAQRLBWPSG9sJydxmLzxwNTkkpqwglif8=;
 b=ePzW4GBURB4bO/x1WbfcHk96mMyIncLaVfG/WwbLQ+tL7VLO6REtKKdvqa2zMWkp2vkR/r
 9ow11HeKXoAl4eAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755547334;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y+auqnjggHVAQRLBWPSG9sJydxmLzxwNTkkpqwglif8=;
 b=F/ufllJoa9F9V/qLHkgdcmGm70pAZD2D5j/IQ1LC2jasiwFlf+PyO0tYF70+iD7VjSsNKd
 oGPIO1GVSTK+GqemZi0GMRZ8lTUaESWK5q50hwWE0BGMYQKe4C2RkUMViljxiJlCT3Nyip
 iCqxF47XpJK+fth/yuRtXF5Lbt+yKcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755547334;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y+auqnjggHVAQRLBWPSG9sJydxmLzxwNTkkpqwglif8=;
 b=tfV7uGFixHx4x1WV7pPqi1czdI6DA9A6ouQ3M0O3tVHI4WZvcwGZ/wKneLRFjDde1ACfkk
 KMVgr0eezAs96sBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61E3F13A55;
 Mon, 18 Aug 2025 20:02:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UFrmDMaGo2hvegAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 18 Aug 2025 20:02:14 +0000
Date: Mon, 18 Aug 2025 22:02:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Pedro Falcato <pfalcato@suse.de>
Message-ID: <20250818200210.GA178161@pevik>
References: <20250814152659.1368713-1-florian.schmaus@codasip.com>
 <20250818130038.GA21418@pevik>
 <wfecvwzibjekda24wzhou5ppngxhptrmn4ks4kg4adwwiizefz@z2ddqcqhr6pd>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <wfecvwzibjekda24wzhou5ppngxhptrmn4ks4kg4adwwiizefz@z2ddqcqhr6pd>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Florian, Pedro,

> On Mon, Aug 18, 2025 at 03:00:38PM +0200, Petr Vorel wrote:
> > Hi Florian, Pedro,

> > > This avoids selecting signal 34 when the test is run using
> > > musl. Signal 34 is used internally by musl as SIGSYNCCALL.
> > > Consequently, musl's signal() will return with an error status and
> > > errno set to EINVAL when trying to setup a signal handler for signal
> > > 34, causing the sigrelse01 test to fail.

> > +1, now it works on both glibc and musl (and hopefully in the rest of libc).

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Tested-by: Petr Vorel <pvorel@suse.cz>

> > > Thanks to Pedro Falcato for suggesting using SIGRTMIN and SIGRTMAX for
> > > this check.

> > nit: @Florian instead of the above I'll add:
> > Suggested-by: Pedro Falcato <pfalcato@suse.de>

> > @Pedro Can I merge with your RBT?

> Assuming you mean Reviewed-by, yep, all fine by me.

Thank you both! Patch merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
