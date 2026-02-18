Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAD2E9A02C
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 13:11:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C68013D0707
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 14:11:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 252563CC7E6
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 14:11:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 76E50600669
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 14:11:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 13B193E736;
 Wed, 18 Feb 2026 13:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771420297;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dSZ9Moo6nhZfJwzq6MXw6n5qODwXq5K+6p2STMtwBnY=;
 b=gH5qKXx9dWRELKvbPMUz2IczYpew0VqG5w1aBoRXFWYOnjcW8jiuOiXefCkKvaLlgDrTQd
 vPL0FxoxaeFNa3WcPLjICGPGlp7o5+JG/g2tpAXRNck5t2wIEVIJRQegg7RpFmlcQxnbHV
 fGAUXXyN5Q0kFQkU5Etim6eQZr4pfTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771420297;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dSZ9Moo6nhZfJwzq6MXw6n5qODwXq5K+6p2STMtwBnY=;
 b=ezwPxCDX6WxD8n4zhN9Maj30R60Ush3/Bb0cpp+eJV9biDBJeyAUmS9JJ9v43Hv98EOL5k
 XI86h4t8Yw/NSjBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771420297;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dSZ9Moo6nhZfJwzq6MXw6n5qODwXq5K+6p2STMtwBnY=;
 b=gH5qKXx9dWRELKvbPMUz2IczYpew0VqG5w1aBoRXFWYOnjcW8jiuOiXefCkKvaLlgDrTQd
 vPL0FxoxaeFNa3WcPLjICGPGlp7o5+JG/g2tpAXRNck5t2wIEVIJRQegg7RpFmlcQxnbHV
 fGAUXXyN5Q0kFQkU5Etim6eQZr4pfTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771420297;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dSZ9Moo6nhZfJwzq6MXw6n5qODwXq5K+6p2STMtwBnY=;
 b=ezwPxCDX6WxD8n4zhN9Maj30R60Ush3/Bb0cpp+eJV9biDBJeyAUmS9JJ9v43Hv98EOL5k
 XI86h4t8Yw/NSjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D24FF3EA65;
 Wed, 18 Feb 2026 13:11:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UI4LMIi6lWnCSQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 18 Feb 2026 13:11:36 +0000
Date: Wed, 18 Feb 2026 14:11:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Stephen Bertram <sbertram@redhat.com>
Message-ID: <20260218131131.GA302975@pevik>
References: <20260209234418.2810671-1-sbertram@redhat.com>
 <DGC004SO49C6.LWOJO8CM24XW@suse.com> <20260211085514.GA39031@pevik>
 <CAD_=S2=oSOkBPH-+8_yaw8irCiUnUx15sJpkmxOTowCOkeH8-g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD_=S2=oSOkBPH-+8_yaw8irCiUnUx15sJpkmxOTowCOkeH8-g@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mq_timedreceive01: fails sometimes with EEXIST.
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

Hi Stephen,

> Hi Petr,

> Running with 4 parallel, so passing `-w 4` to kirk or runltp.

> It doesn't happen all the time, but maybe 1 in 4 it will give an EEXIST
> error. And so far it's only happened with one of the 4 instances.

> It happened for me with mq_timedreceive01.

Thanks for info.

BTW this was merged without your Signed-off-by: tag (SOB) [1].

Please next time don't forget to add to the commit message:
Stephen Bertram <sbertram@redhat.com>

Thanks!

Kind regards,
Petr

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
