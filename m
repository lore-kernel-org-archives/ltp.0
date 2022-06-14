Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B659C43334
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 13:11:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68A9E3C9443
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 15:11:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BC413C06E0
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 15:11:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4E57E6009D1
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 15:11:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8745421A82;
 Tue, 14 Jun 2022 13:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655212302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MhCVamP4pmC0xEV6VmxrCMpdxe4VLaVErH0yxs3x4Lk=;
 b=l9hMP78At1bkxUT0kuO0fd7TdmpNo/UFfYBWI2nxSKfSDigMhMxb+HodkzFKQO0yNWRb26
 Nxbu6kD5abIVspKXca0BfH5LGwMKvpTi0UEkqpKdNQExAj9ZX8cOkx1a6s8Z6SKxCkScSY
 6yAzfjUON2MFFF3HDnY7GwKQLCqufAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655212302;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MhCVamP4pmC0xEV6VmxrCMpdxe4VLaVErH0yxs3x4Lk=;
 b=9WndtGyVVUyyVIGoGb7yGUSfcm7ppttxMJBQgSPRxU0ppXXxkTtu0X9wHDXiRTmd2l7fqA
 YtEVM4KaUh+GUtCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72CD31361C;
 Tue, 14 Jun 2022 13:11:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZR2VGw6JqGKXIQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 14 Jun 2022 13:11:42 +0000
Date: Tue, 14 Jun 2022 15:13:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YqiJjYVsrkPgk1fQ@yuki>
References: <YfPiW998P4/j7RWi@pevik>
 <20220203101803.10204-1-rpalethorpe@suse.com>
 <CAEemH2f6ka-vK+O33cxw1ewMWDYZQwtRZUQ3eKFMkynqB2+R3w@mail.gmail.com>
 <YiDDoly4t0N30kfo@pevik> <Yqh/kqJBv2xgV3O1@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yqh/kqJBv2xgV3O1@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Create policy for testing unstable kernel features
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
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> as there is another set of fanotify tests for rc kernel, I'd really like to have
> some policy. Therefore I suggest to stick policy suggested by Richie in this
> patchset [1], i.e. adding tests into runtest/staging until mainline kernel with
> this functionality is released (feature is part of the stable kernel ABI).
> i.e. each kernel release content of this file must be revised and (ideally)
> moved to particular runtest file where it should belong or fixed (in rare
> situations when feature changed) or removed (feature was reverted).
> 
> I volunteer to maintain runtest/staging.

As long as you commit to maintain the staging you have my ack as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
