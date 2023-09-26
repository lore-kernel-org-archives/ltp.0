Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D86E7E635
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 13:41:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58E8F3CDC7F
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 15:41:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21E773CDC7D
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 15:41:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5FBFC1400BE4
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 15:41:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6ED481F86C;
 Tue, 26 Sep 2023 13:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695735679;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=efA1+0HOAUQNlCVcX4rDCIZ7hWGaZGFr1Nb1dnjKH9Q=;
 b=w/sFsrY8ztOMpyo5HwMRmA6SrCx/S23oDPQBHChPrCLElLo9riC65Ap8gNXefZO0Y4ZLbi
 f1dQaLIWr+vyo2V0/Q+yUiWvbKYSuoOJB52X6JOxetMT+a71Ti6h2ZEHbYoFTZZo7mEZKF
 TJTEqTjT5ArhzlPX8p77XJIpzhba2mg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695735679;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=efA1+0HOAUQNlCVcX4rDCIZ7hWGaZGFr1Nb1dnjKH9Q=;
 b=KUf6rH29kxBycN0fLnnWIwsHDJ9dPQuwwPEIBbzwT5iKsgGkFg9mo9eZa496SMfpatagXZ
 RMfPubm9+5ujWKCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A8551390B;
 Tue, 26 Sep 2023 13:41:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jYvlAn/fEmUUPwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Sep 2023 13:41:19 +0000
Date: Tue, 26 Sep 2023 15:41:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230926134117.GB159673@pevik>
References: <20230920095318.340582-1-pvorel@suse.cz>
 <CAEemH2fKvKrN_S1j34UpfzDpqob_sasuxGt8Ji81TkzEFpt_UQ@mail.gmail.com>
 <CAASaF6xMijTern9QA4B3zT93kDaZdxK_JMa=+bVMctOtdG5m7g@mail.gmail.com>
 <ZRLLubfGMq3wVqUX@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZRLLubfGMq3wVqUX@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/5] Release scripts and docs
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
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > But I doubt that we really need the scripts to do release work
> > > automatically since we _only_ do the release every four months.
> > > It seems to bring additional maintenance work unnecessarily.

> > > I personally think the manual step is detailed enough for us.
> > > But anyway, now you have done the automation, I don't have
> > > an objection to your patch set, just feel that we automate for the
> > > sake of automation :).

> > > I'd like to hear more opinions, but if most of us think the script is
> > > necessary, I'm happy to accept them as well.

> > As someone who hasn't done release before, I'd probably do it
> > manually first-time to double-check each step.

> > It's probably not necessary, but people who did releases many times may
> > find it useful - I'm assuming the release procedure isn't changing
> > that frequently.

> I do have a similar script to tag git and release tarballs, doing that
> manually every time is really error prone, so it's good idea to include
> these in the repository.

Thanks for your feedback. Of course, I'm open to any concerns about the actual
implementation.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
