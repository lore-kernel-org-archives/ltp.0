Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC48BC433FE
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 10:04:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A1653CA8A6
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 12:04:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF4BE3CA4E1
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 12:04:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CA1B8201139
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 12:04:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 212BE1F892;
 Fri, 30 Sep 2022 10:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664532243;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T+GCkb7SNAlIJIJLBx00mtghqBBOvtaPpXuCn+DhP90=;
 b=VblQu//J6X054zhdeqzeS3ZdmG+nXDn7qwWb5v1/658AOuKxhu1/KrdBWcj66spfZayz5e
 R2CT99gZSJsreoUy7OgJry5a6MHNZAmSiaIHjhi4OL9r/XX8kovpVy5W0UsP8k/xF/ZKIg
 79ibE0bsL+u9hH2FN2Nt1EURaGzPh94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664532243;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T+GCkb7SNAlIJIJLBx00mtghqBBOvtaPpXuCn+DhP90=;
 b=KWSRJZ6bKAFtfxpAOy9GDMCmPb1xUvN07meqkDMY/G5crjw5KG2e1HrIhHopVQ3hC6xpTE
 GK6BSXBtP1hSLVAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E98BB13677;
 Fri, 30 Sep 2022 10:04:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VSxPNxK/NmPWawAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 30 Sep 2022 10:04:02 +0000
Date: Fri, 30 Sep 2022 12:04:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yza/EMaFAkv+Y+4d@pevik>
References: <20220930091208.5688-1-pvorel@suse.cz> <Yza1B8t2LOueCVUC@yuki>
 <Yza2jwpow0uhaLHu@pevik> <Yza4a2Icm+M9cTiK@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yza4a2Icm+M9cTiK@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] zram01.sh: Fix minimal size for XFS on
 kernel 5.19
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
> > > Looks good to me. Please make sure that this gets tested fairly before
> > > pushing.
> > +1. I've tested it on Tumbleweed, kernel 6.0.0-rc7-1.g74aafe0-default,
> > mkfs.xfs 5.19.0.

> > > Also Li if you can please double check since we are very late in the
> > > release process.
> > +1
> > I can merge it tonight, or wait for Li on next week.

> I'm going to tag the git in the evening/afternoon so it would be nice to
> get this in ASAP.

OK, we have another regression in 1f6bd6e66 ("tst_test.sh: Add
$TST_ALL_FILESYSTEMS"). I'll reply to release thread.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
