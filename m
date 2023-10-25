Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44802C25B47
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 08:12:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37E333CCBA8
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 10:12:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DD8C3C022E
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 10:12:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0D49F208E04
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 10:12:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EC48621D66;
 Wed, 25 Oct 2023 08:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698221521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mrx2PfQu+fKA+MgFxcS6VtVOaEXba2zuqouCvEPofJs=;
 b=NtuBg7LRu2+czdYll93Uk0puzFAR5Q09AFDvxCXt365K9+gv11EfQ6JR2CH1SINaffE6Zg
 KKHK1cjpRnBtCRm0AkmIlrGukcfxsB++e2XRoy+sm6rbt/J28RpD63Ur1ZhmmHAkTBr3Jz
 Xeev2ZNExafqcokmDF4hl/Ak8+KLm/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698221521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mrx2PfQu+fKA+MgFxcS6VtVOaEXba2zuqouCvEPofJs=;
 b=2Rg5INTnPNZUt11Z4tmEYePFfSaUy9Grt/CXHQopNCjHmmstXNNHCmFF3CTuGRonXDyNH9
 b6PYPyPDF+Y+xXCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0E6D138E9;
 Wed, 25 Oct 2023 08:12:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LxvKKdHNOGX4cwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 08:12:01 +0000
Date: Wed, 25 Oct 2023 10:12:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231025081200.GA294660@pevik>
References: <20231024201135.264768-1-pvorel@suse.cz>
 <20231024201135.264768-2-pvorel@suse.cz> <8734xzuq4g.fsf@suse.de>
 <20231025073952.GA286089@pevik> <ZTjJDtrcyjc3UoMV@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZTjJDtrcyjc3UoMV@rei>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-10.11 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.81)[99.17%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lapi: Add uinput.h
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

> Hi!
> > > > +++ b/configure.ac
> > > > @@ -67,6 +67,7 @@ AC_CHECK_HEADERS_ONCE([ \
> > > >      linux/tls.h \
> > > >      linux/tty.h \
> > > >      linux/types.h \
> > > > +    linux/uinput.h \

> > > Do we use this?
> > Yes, see below.

> Ritchie probably means the macro HAVE_LINUX_UINPUT_H that is generated
> by this, and no we do not use that, we include <linux/uinput.h>
> unconditionally.

Ah, thank you. This is obviously missing.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
