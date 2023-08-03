Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BDDEB64DD
	for <ltp@archiver.kernel.org>; Thu,  3 Aug 2023 12:50:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AEAD3CD873
	for <ltp@archiver.kernel.org>; Thu,  3 Aug 2023 14:50:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38FBC3CB737
 for <ltp@lists.linux.it>; Thu,  3 Aug 2023 14:50:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8DD1E1A0109E
 for <ltp@lists.linux.it>; Thu,  3 Aug 2023 14:50:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A17F1F749;
 Thu,  3 Aug 2023 12:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691067040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LGcSLs4clc0tr+rkh1jzBmTwcMu5HfeANIsispgwirI=;
 b=JoC0688nzeGItGVIKXZxDQxL1toWBzOCJcdmSCUoKRXeEwsPW5R8RxEYDvU5EbKUm7O2FJ
 JdyuSOhpoOtCZd+OzcOpHbXXyERKFFWMp31wvOY/boJFoRG+kQdRzXH7n8Zr31TVkcv0S3
 wywOTedcHltGfwIKgMfLp7J1K6oqk2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691067040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LGcSLs4clc0tr+rkh1jzBmTwcMu5HfeANIsispgwirI=;
 b=ltNoacH8wDwT08dQolvFwHGHctFHioIGYNEax+/JgsWWNlj0OXNQGK9RQoYtuciBDaxBuI
 g8j3XOIO0PBy5TAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A470134B0;
 Thu,  3 Aug 2023 12:50:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zdjwAKCiy2Q2XQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 03 Aug 2023 12:50:40 +0000
Date: Thu, 3 Aug 2023 14:51:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZMui2ci_kS92xCts@yuki>
References: <20230727150013.31835-1-mdoucha@suse.cz>
 <20230727150013.31835-3-mdoucha@suse.cz>
 <20230728083622.GA15664@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230728083622.GA15664@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] Add test for CVE 2023-1829
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +static struct tst_test test = {
> > +	.test_all = run,
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.taint_check = TST_TAINT_W | TST_TAINT_D,
> > +	.needs_kconfigs = (const char *[]) {
> > +		"CONFIG_VETH",
> > +		"CONFIG_USER_NS=y",
> > +		"CONFIG_NET_NS=y",
> > +		"CONFIG_NET_SCH_HTB",
> > +		"CONFIG_NET_CLS_TCINDEX",
> Interesting, CONFIG_NET_CLS_TCINDEX has been removed in 8c710f75256b
> (in v6.3-rc1), therefore the test is only for older kernels.

Nothing wrong with that I suppose, we will have to maintain kernels with
that module for a decade from now anyways...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
