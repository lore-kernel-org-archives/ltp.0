Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DC2C46CA1
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 10:34:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7F893CE4F1
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 12:34:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65A6E3C9274
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 12:34:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 45BA9201DB0
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 12:34:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2744C21A2D;
 Mon, 18 Sep 2023 10:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695033274;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1nKVBvVMlCBiWzlukr1VOLwWBvHl8WZv6Bfk0Y8nhKA=;
 b=vWN4LwZx0X+YM5ydgOyhkxhO+OYV2DkszoAWmljhAhVhRdremY6v55QleBAVBqKAQBtABD
 vpvjv/C/EK0x+TLUCylp79Y7tEsvlR1ue/Nx9Cr7x5zUgHIxLhoqjEERwyK7sm3CZsGEWd
 7Ej9ubm2eGlQTaWdpPocVrppf7abo/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695033274;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1nKVBvVMlCBiWzlukr1VOLwWBvHl8WZv6Bfk0Y8nhKA=;
 b=dLnOCSxVkNalyLjaoFM4S4/zNOKPlQZ1THTpoHARGSi70/4awH9Q2hTxBFgE7ViHsu1TJn
 EHrc/Craxihl79CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 074641358A;
 Mon, 18 Sep 2023 10:34:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FwR2ALonCGXPOwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 18 Sep 2023 10:34:34 +0000
Date: Mon, 18 Sep 2023 12:34:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230918103432.GA12384@pevik>
References: <20230918082506.17464-1-andrea.cervesato@suse.de>
 <20230918082506.17464-3-andrea.cervesato@suse.de>
 <20230918091756.GB30304@pevik> <ZQgarkBUEyDd4lxF@yuki>
 <ZQgbbx2MEsJaKWwR@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZQgbbx2MEsJaKWwR@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add Linux Test eXecutor inside tools
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
> > Unfortunately this does not work well either because the ltx does not
> > have install targed and trying to install a file from a subdirectory is
> > not possible with the LTP build system. I've tried that and it didn't
> > work.

> > Let's merge this version that works, we can try to do make things better
> > later on.

> Also one more point $(MAKE) -C ltx-src does not support out-of-tree
> build and while it's probably fine for 'make check' not to support it,
> since that is a developer tooling, it should work fine for ltx that is
> going to be packaged/installed on the SUT.
Very good point! It'd be nice to note this reason in the git commit message.

> So I suppose that we are stuck with the LTP ltx Makefile unless we:

> - add support for out-of-tree build to ltx/Makefile
> - drop out-of-tree build support from LTP

I guess even Buildroot and Yocto does not use out-of-tree build.
Maybe we should really remove the support.

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
