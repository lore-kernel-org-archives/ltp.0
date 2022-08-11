Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC1BC19F2D
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 08:49:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EB4C3C9600
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 10:49:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5A933C1BB8
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 10:49:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7C871680E2D
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 10:49:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 86E2C5C7A8;
 Thu, 11 Aug 2022 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660207763;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wZEzrI92yfkHnbFN8SjU3ZCdLmT0MH+rdD+qvv6KGBg=;
 b=s9n+G4cRxOBWv3WwJ9HNg+aWjh/syy3LXur2JFVuRM6naCdBo/DcxSAN1GaysOjfsvUNSj
 lSeu4XZ7Y+0RzuF8IZlapdB6gQT1DNmqHHWoLAt+JcHx2k0MIQNz1qDiqYUPgUEKhbws1O
 qMd/RowplH53zG8HbG/aeflSaJ7kyes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660207763;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wZEzrI92yfkHnbFN8SjU3ZCdLmT0MH+rdD+qvv6KGBg=;
 b=71wsXMAQlL0Ib5ZddpF0WoBJ7brIHfS+qm4pCUA6V2ef3rbXdGaA0xhwwXfzTvD2+qe5/y
 RhD2zb5sxRFAqvAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 421CC13A9B;
 Thu, 11 Aug 2022 08:49:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7VbGDZPC9GKDXAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 11 Aug 2022 08:49:23 +0000
Date: Thu, 11 Aug 2022 10:49:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YvTCkcD5heWoA+wJ@pevik>
References: <20220714124611.9772-1-akumar@suse.de> <YtAXuBDka4VC90q/@pevik>
 <4729784.GXAFRqVoOG@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4729784.GXAFRqVoOG@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] open06.c: convert to new LTP API
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it,
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi Petr,

> On Thursday, July 14, 2022 6:48:48 PM IST Petr Vorel wrote:
> > Hi Avinesh,

> > > -	if (mknod(fname, S_IFIFO | 0644, 0) == -1)
> > > -		tst_brkm(TBROK, cleanup, "mknod FAILED");
> > > +	SAFE_MKFIFO(TEMP_FIFO, 0644);
> > You changed test from mknod() to mkfifo(). May I know why?
> > It would be worth to mention the reason in the commit message.

> > Should not we keep mknod() ?
> > SAFE_MKNOD(TEMP_FIFO, S_IFIFO | 0644, 0);

> > According to man mknod(2) your change is correct:

> >        POSIX.1-2001 says: "The only portable use of mknod() is to create
> >        a FIFO-special file.  If mode is not S_IFIFO or dev is not 0, the
> >        behavior of mknod() is unspecified."  However, nowadays one
> >        should never use mknod() for this purpose; one should use
> >        mkfifo(3), a function especially defined for this purpose.

> > Also note LTP tests should test even deprecated kernel API, we *might* want to
> > test both mkfifo() and mknod() via .test_variants. But I'd like to hear the
> > input of the others, because both glibc and musl use SYS_mknod or SYS_mknodat
> > for mkfifo() implementation with very thin wrapper, thus not sure if it's worth
> > to test also mknod().
> I changed to SAFE_MKFIFO as it seemed more intuitive in this open() test,
> but yes, I should have mentioned it in the commit message.
> I have not checked the mkfifo() implementation in libraries, so please
> lmk which one to proceed with here, I will send updated version if needed.

Thinking about it twice, given mknod() / mkfifo() are used in the setup it does
not look worth to run .test_variants just for this. So, unless anybody disagrees,
it's ok to keep SAFE_MKFIFO(). I'll wait little longer before merging it (with
note of changed function in the commit message).

Kind regards,
Petr


> > Kind regards,
> > Petr


> Thanks,
> Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
