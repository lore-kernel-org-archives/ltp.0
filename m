Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647A8E743F3
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 08:15:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A38603CE123
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 10:15:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAF873CB62A
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 10:15:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 64D3E14001EB
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 10:15:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C50C1F390;
 Fri, 29 Sep 2023 08:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695975323;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1rW1BlNDaJxh6jqUrC2YgpUXd8GbW9Q+xUUF7ipM5o=;
 b=QhK9qxqo3tL0UVapVontyGL5PLXVZAkSxfeLYm9NetYgwkWzE78ncgZ5lifKqreDT/ngc/
 Nu7FKVfclzvhB48LDr+nEbhtl6oTU9URFauzJw70BDH4B+j59wOtqhPs/UIf6q0zt2uzNL
 sRmwRyGA+M9yD+Y0ixsrY64z+OvZJhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695975323;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1rW1BlNDaJxh6jqUrC2YgpUXd8GbW9Q+xUUF7ipM5o=;
 b=hJK5dinjBs2tnYra+Yo2TWHeeekfY60EofXKdE8xvAxHwQ0gueFrqiDdzNYokiPSo/6e//
 jAmhvXFiLDGK2RAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA09813434;
 Fri, 29 Sep 2023 08:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XR/xL5qHFmVDZAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 29 Sep 2023 08:15:22 +0000
Date: Fri, 29 Sep 2023 10:15:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20230929081521.GA351787@pevik>
References: <20230928104458.12115-1-rpalethorpe@suse.com>
 <20230928181124.GA309263@pevik> <87h6nde7hu.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87h6nde7hu.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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

> >> RFC comments:
> >>     * Add git clean -fdX which should remove any build artifacts
> >>       this is different from the suggestion of just doing a check. I just
> >>       found it easier to remove the build files.
> > FYI what we do in release scripts, is to do a local clone to a different
> > directory [2]:
> > git clone ltp ltp-full-YYYYMMDD

> > Not sure what is faster.

> I guess that is something a script could also do then 'git clean'
> becomes a null op. git clean -X will only remove untracked files so
> pending changes should get picked up. Which is probably what people want
"remove untracked files" - if you develop a new test, forget to add it with 'git
add' and run the container, you will get disappointed :).

> during development. Doing a fresh checkout is probably more like a hard
> reset and clean.

The benefit is that you have not only a clean git repo for the container,
but also not touching your working copy directory. But unless nobody else
raise any concern, I'm ok with your current proposal.

> AFAICT git clean is very quick, far faster than 'make distclean'.


> >>     * Added seperate alpine and tumbleweed runtime scripts. Again it's
> >>       different from the suggestion just because it's easier to add
> >>       seperate scripts than adding a switch
> > +1

> > But maybe put it into container directory, because it's not used in
> > GitHub CI?

> I was thinking it could be used in CI. All we need is a CI that runs VMs
> and we can do some testing. (e.g. srchut).

Makes sense. Also, having scripts on two directories can lead to confusion,
let's keep it in ci directory.

...
> >> +#!/bin/sh -eux
> > nit: out of curiosity, why -u (fail unset variables and parameters)?

> I find it finds errors in shell scripts or when using them. E.g. typo's
> in env variable names. I just include it wherever possible.

+1, maybe we should add it to the current ci scripts as well (+ use params
instead of setting it via set command, it should work in dash and busybox shell
as well).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
