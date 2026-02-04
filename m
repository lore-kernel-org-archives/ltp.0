Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13787E95392
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 12:47:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A15C13CE0FC
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 13:47:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D194B3C769B
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 13:46:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 756E21000A02
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 13:46:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 528695BD0C;
 Wed,  4 Feb 2026 12:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770209210;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9qqOWfw4Mvwa4gtLNVlem8cSG+MU9cgnYycIOe8LxMo=;
 b=xwA7zMQvbtf6EozyIctTMoqiZlexmwESMg1VIkSiD55MVo1S/sSw+KkVuOa84zwQFf7QrJ
 msoGHPMDTPp82+PW+JSafghfE58lsPoYpFjBHO7JbCy98LeeJi6I7Xvpz/TKb92c5xbkIM
 EglB2SBnmsEOU8RxCnKd0KOrBNhDhNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770209210;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9qqOWfw4Mvwa4gtLNVlem8cSG+MU9cgnYycIOe8LxMo=;
 b=LU9L4VnK//7mtHaKYG1CWuSYgADI+bzUXv4JVb8e5mZ61NQu7zpnPuO5mphLwBg9upb7Fo
 4/EmaL217gZvpHBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770209210;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9qqOWfw4Mvwa4gtLNVlem8cSG+MU9cgnYycIOe8LxMo=;
 b=xwA7zMQvbtf6EozyIctTMoqiZlexmwESMg1VIkSiD55MVo1S/sSw+KkVuOa84zwQFf7QrJ
 msoGHPMDTPp82+PW+JSafghfE58lsPoYpFjBHO7JbCy98LeeJi6I7Xvpz/TKb92c5xbkIM
 EglB2SBnmsEOU8RxCnKd0KOrBNhDhNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770209210;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9qqOWfw4Mvwa4gtLNVlem8cSG+MU9cgnYycIOe8LxMo=;
 b=LU9L4VnK//7mtHaKYG1CWuSYgADI+bzUXv4JVb8e5mZ61NQu7zpnPuO5mphLwBg9upb7Fo
 4/EmaL217gZvpHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5E9F3EA64;
 Wed,  4 Feb 2026 12:46:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id c0WmNrk/g2nHUAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Feb 2026 12:46:49 +0000
Date: Wed, 4 Feb 2026 13:46:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260204124640.GA244528@pevik>
References: <20260204115339.224261-1-pvorel@suse.cz>
 <20260204115339.224261-5-pvorel@suse.cz>
 <DG664MTNCKXU.10ZGQ5CGF7DC9@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DG664MTNCKXU.10ZGQ5CGF7DC9@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[free.fr];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[14]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,suse.de,suse.cz,redhat.com,virtuozzo.com,lists.yoctoproject.org,sony.com,free.fr,bootlin.com,linaro.org];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] kirk: Remove runltp-ng symlink
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
 Tim Bird <Tim.Bird@sony.com>, Julien Olivain <ju.o@free.fr>,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, all,
> Hi!

> On Wed Feb 4, 2026 at 12:53 PM CET, Petr Vorel wrote:
> > kirk is here long enough to remove the symlink.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  tools/kirk/Makefile | 2 --
> >  1 file changed, 2 deletions(-)

> > diff --git a/tools/kirk/Makefile b/tools/kirk/Makefile
> > index 876eb3e2ed..859afde6e6 100644
> > --- a/tools/kirk/Makefile
> > +++ b/tools/kirk/Makefile
> > @@ -17,8 +17,6 @@ ifneq ($(wildcard $(abs_srcdir)/kirk-src/libkirk/*.py),)
> >  	install -m 00644 $(abs_srcdir)/kirk-src/libkirk/*.py $(BASE_DIR)/libkirk
> >  	install -m 00644 $(abs_srcdir)/kirk-src/libkirk/channels/*.py $(BASE_DIR)/libkirk/channels
> >  	install -m 00775 $(abs_srcdir)/kirk-src/kirk $(BASE_DIR)/kirk
> > -
> > -	cd $(BASE_DIR) && ln -sf kirk runltp-ng
> >  endif

> >  include $(top_srcdir)/include/mk/generic_leaf_target.mk

> This is the only point where im not 100% sure. I'm wondering if we
> should keep a symlink to `runltp`, just in case people will have CI
> working on LTP.

I'm not sure if hiding 'kirk' under 'runltp' symlink is a good idea. If yes,
there should be a big warning if people run it via symlink (detect in
kirk-src/kirk that it was run via 'runltp').

Do you agree with removing 'runltp-ng' symlink?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
