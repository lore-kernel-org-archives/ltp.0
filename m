Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D35FE7E62E
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 12:16:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E1D03C042F
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 14:16:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91CC13C042F
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 14:16:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1BE491400E73
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 14:16:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7AF5E2183B;
 Tue, 26 Sep 2023 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695730574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sFbRsE1d3HZRtQ4ZhVPqnSCniCn5kLH52aladdIhXFk=;
 b=dAufS2ymJnoV0ROs2NhkTrgjobUfuA1mWwVFAaAl+pB9rQrNqizb6tVMuJOfvqg2xbJ1jc
 mIoBy8YXKB2vQexLCAvwAGbt2AihwyaMq2bcgozjaWM/CggRjVxQjR8wN0F4R2JKnYgfSi
 90IWdkjwJw3I3+PsrFgsHaeo9FquUWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695730574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sFbRsE1d3HZRtQ4ZhVPqnSCniCn5kLH52aladdIhXFk=;
 b=DeYmIVlXF8mBRyGw5h/siAbL/k0QZ9Io4qTxt5FHaT96kNm37hZognz8ATBpyPbhcLhSHY
 ZJNJ60yETYS862CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AA821390B;
 Tue, 26 Sep 2023 12:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uArEGY7LEmWnDQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 26 Sep 2023 12:16:14 +0000
Date: Tue, 26 Sep 2023 14:16:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <ZRLLubfGMq3wVqUX@yuki>
References: <20230920095318.340582-1-pvorel@suse.cz>
 <CAEemH2fKvKrN_S1j34UpfzDpqob_sasuxGt8Ji81TkzEFpt_UQ@mail.gmail.com>
 <CAASaF6xMijTern9QA4B3zT93kDaZdxK_JMa=+bVMctOtdG5m7g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xMijTern9QA4B3zT93kDaZdxK_JMa=+bVMctOtdG5m7g@mail.gmail.com>
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Xiao Yang <yangx.jy@cn.fujitsu.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > But I doubt that we really need the scripts to do release work
> > automatically since we _only_ do the release every four months.
> > It seems to bring additional maintenance work unnecessarily.
> >
> > I personally think the manual step is detailed enough for us.
> > But anyway, now you have done the automation, I don't have
> > an objection to your patch set, just feel that we automate for the
> > sake of automation :).
> >
> > I'd like to hear more opinions, but if most of us think the script is
> > necessary, I'm happy to accept them as well.
> 
> As someone who hasn't done release before, I'd probably do it
> manually first-time to double-check each step.
> 
> It's probably not necessary, but people who did releases many times may
> find it useful - I'm assuming the release procedure isn't changing
> that frequently.

I do have a similar script to tag git and release tarballs, doing that
manually every time is really error prone, so it's good idea to include
these in the repository.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
