Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4BDEB64D7
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 14:57:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FC8F3CE165
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 16:57:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB53D3C9995
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 16:57:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9271660091A
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 16:57:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C6C871F37F;
 Wed, 28 Jun 2023 14:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687964249;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QszVyOn+nxgtpX6wsdxGBHNUpaLhYQqEFSoHMzPGlGo=;
 b=oLK5ESlLIfCfyhNIihG14OUVg9igHbz+dG9FnZNYhN+7BnR3rdzXvO758Kn496bPjFvVr4
 YZk5JmezE1cbo8KP7vmTIUPoWnRGxVwzxqDLt1cIUzwh5fNPNUq+yRF1rzFrv9OZTlnLmb
 zMwbZdxEJUOAVnBUyko/RvSTx6KhXIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687964249;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QszVyOn+nxgtpX6wsdxGBHNUpaLhYQqEFSoHMzPGlGo=;
 b=GpbbQr857EpLdfQil7fM/qHPKk6oNfg1GKRdAi5SMa1sVMQLODso/TxDK+OgapuacNtoOS
 7xTZKj4SUyPCeMDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F2D3138EF;
 Wed, 28 Jun 2023 14:57:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TEs8IVlKnGQbMAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 28 Jun 2023 14:57:29 +0000
Date: Wed, 28 Jun 2023 16:57:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230628145728.GA4099@pevik>
References: <20230628081831.123189-1-pvorel@suse.cz>
 <20230628081831.123189-2-pvorel@suse.cz> <ZJwb_wxDrqIlNqfg@yuki>
 <20230628125144.GA147674@pevik> <ZJw3bPDB76tY3Ioz@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZJw3bPDB76tY3Ioz@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lapi/fcntl.h: Fix O_DIRECT definition for
 various archs
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
Cc: NeilBrown <neilb@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > I have no problem to remove O_DIRECT. The only question is what to do if we need
> > it in the library one day. Will we be ok that whole LTP becaume _GNU_SOURCE due
> > that?

> Nothing stops us from adding _GNU_SOURCE into a lib/foo.c if that is
> ever needed.

You're right, now I wonder why I didn't realize that it does not have to be
added to header file, just to C file :). Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
