Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D585E743FE
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 09:38:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD1E73CB9EF
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 11:38:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCAB73CB9EF
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 11:37:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A0E311000F27
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 11:37:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DBC3221899;
 Fri, 29 Sep 2023 09:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695980274;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uwagea27/ejs0lfM950BIvw7SsOFp8eCKgC6LgUOqCY=;
 b=iuHdKvqt6f/MYD+9EXPUYiZ2UtqyEchyTj2UKmqPgPIVQDj2mYtT/ueti+sacQiElcQ+JU
 jpc2TcpP54skH0/QUjsswql+PYkyYyW36nfwtDIVhzg7ZXracg7AoXTc3yZ97l/GqNoo3X
 BUK88NxNzKBZb4nswaNQp2PRR4h9Kf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695980274;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uwagea27/ejs0lfM950BIvw7SsOFp8eCKgC6LgUOqCY=;
 b=ZT8xlOgOPneAo6/YQ6MNKLzR4PJZKgV8x0na32c9wvScU88dpqkee9Xhh5HSq2nhRzupmt
 qL9T54pIZMM2GpBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7AEF1390A;
 Fri, 29 Sep 2023 09:37:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WhwBK/KaFmX9DgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 29 Sep 2023 09:37:54 +0000
Date: Fri, 29 Sep 2023 11:37:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20230929093753.GA364346@pevik>
References: <20230928104458.12115-1-rpalethorpe@suse.com>
 <20230928181124.GA309263@pevik> <87h6nde7hu.fsf@suse.de>
 <20230929081521.GA351787@pevik> <87cyy1e35e.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87cyy1e35e.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add simple Containerfile
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

Hi Richie,

...
> > The benefit is that you have not only a clean git repo for the container,
> > but also not touching your working copy directory. But unless nobody else
> > raise any concern, I'm ok with your current proposal.

> Ah I think I see your concern now. It does not touch the directory
> outside the container. It copies everything in first (IDK if it actually
> copies the data if you are doing a local build).

Ah, sorry, of course.

> Note that I tried using a .dockerignore to stop build artifacts being
> copied, but it's not as rich as the .gitignore(s) we have sprinkled
> throughout the LTP.

...
> >> >> +#!/bin/sh -eux
> >> > nit: out of curiosity, why -u (fail unset variables and parameters)?

> >> I find it finds errors in shell scripts or when using them. E.g. typo's
> >> in env variable names. I just include it wherever possible.

> > +1, maybe we should add it to the current ci scripts as well (+ use params
> > instead of setting it via set command, it should work in dash and busybox shell
> > as well).

> Yeah, I think it should be the default.

I add it at least to the original scripts in ci directory, it should be safe
here. I'll test tst_test.sh and tst_net.sh and send a patch for this.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
