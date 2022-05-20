Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBFCC433EF
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 11:30:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65C8D3CAAEA
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 13:30:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF2453CA948
 for <ltp@lists.linux.it>; Fri, 20 May 2022 13:30:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 641B41000DD7
 for <ltp@lists.linux.it>; Fri, 20 May 2022 13:30:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8CFEB21B2A;
 Fri, 20 May 2022 11:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653046217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aLb21+MvJC0LBgr7KuIpOF5cxMPOjVi3p8I1Fj4++CI=;
 b=FJxQ9Tg1bW/w6GVUato4lgk0B/NyH/b/1PKrZ/ZU6+Q91iWhmK7zL/la/2/YN1xGw5U8zU
 X7FZNpXDza+F2aCf969jhAYUbkxx64ji6qvVFRvNhmLrSs4J+szW8dst02HxMUgHOHgJ5d
 0F60CJRIJIP5ejCEp2y3LR+5bhYuWNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653046217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aLb21+MvJC0LBgr7KuIpOF5cxMPOjVi3p8I1Fj4++CI=;
 b=FSRrl07o0EwTB/EHDYP4KLrrRTXG001G/hEsmv5aF3eCUs7LY2MPga0MiseQ2ECVC9/7Hm
 vJRL/dOj+htKfNAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6337913A5F;
 Fri, 20 May 2022 11:30:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YtFEFsl7h2JyKwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 20 May 2022 11:30:17 +0000
Date: Fri, 20 May 2022 13:30:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yod7x/AzRCrFF5kJ@pevik>
References: <20220519121056.1181-1-mdoucha@suse.cz>
 <20220519121056.1181-2-mdoucha@suse.cz> <YodY7QOisdpaI3KK@pevik>
 <10ee5852-9302-22d7-832c-f581ef94c336@suse.cz>
 <YodbppwrK3MfbyFX@pevik> <YoddtIk78PdTp+xZ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YoddtIk78PdTp+xZ@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] pty04: Fix cleanup
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
> > > I don't see why. Running pty07 with -i0 was actually quite helpful in
> > > debugging this issue. If a test fails when executed with -i0, it needs
> > > to be fixed.
> > Do you mean that -i0 is useful to test only setup and cleanup in C API?
> > If we agree we want this (not against it if it's useful), shell API should
> > be unified with it (my concern was that both APIs should behave the same on
> > the same getopt option).

> It never occured to me that -i0 can be used to test that setup and
> cleanup are coded properly but it makes a lot of sense.

OK, I might send a patch for shell implementing it, but it has a lower priority
(there are other patches which should make it to get into the release than
this).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
