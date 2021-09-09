Return-Path: <SRS0=gXt9=N7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71722C433EF
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 10:55:49 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692FA61100
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 10:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 692FA61100
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF8483C8D8C
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 12:55:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 650FF3C21F7
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 12:55:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 747D01A006A4
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 12:55:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 24FB022358;
 Thu,  9 Sep 2021 10:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631184935;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VY3oELlZo7/YZY+Wv5Kyd9ynpbtrsGWH3mxk2yUtnyk=;
 b=1P5u0oY0/vy9yscejbXNBfNUK6RXwLBDDX8Eb8VrbWxLdqcr2+5Sk67RVW4msw2d0MiA9E
 lFKnpw6ZC/pqabOVBhWafUKqO54WJIjzOS4ZlmvIoxxKzC/TcVmHCG+wxsQQFMi7JDN206
 tgsw4GvJ20e581JLlc6w5KxkbllPpns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631184935;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VY3oELlZo7/YZY+Wv5Kyd9ynpbtrsGWH3mxk2yUtnyk=;
 b=TksY3JqqZ9Mg7X1hw77VnpQs49qvghf4XRiJ5UPj3WL3j5BIIT80oxNrSrpBcPcmUs96q3
 pJhZIqp73mOjkGBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF68A13B0C;
 Thu,  9 Sep 2021 10:55:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BN0VNSboOWFhRAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Sep 2021 10:55:34 +0000
Date: Thu, 9 Sep 2021 12:55:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YTnoJTqXum64Q488@pevik>
References: <20210902103740.19446-1-pvorel@suse.cz>
 <20210902103740.19446-5-pvorel@suse.cz> <YTDRzA6Vbimc69Xz@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YTDRzA6Vbimc69Xz@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] doc: Update for vendored checkbashisms.pl
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210909105533.7CPVR1mLhypfVlCASGl4S_8rmILgcZVSbet4Tdc5XjE@z>

Hi Cyril,

thanks, merged up to this commit (the 5th one was replaced).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
