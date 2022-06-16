Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00462C43334
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 08:25:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13D9B3C6A74
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 10:25:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A267C3C2FF1
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 10:25:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6BFCB1A01130
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 10:25:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A52971F8D6;
 Thu, 16 Jun 2022 08:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655367903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=itIXOH0aAIbGL7InUNnJS6WdfWExWcrXTNpAcWDRgw8=;
 b=hs15ozV6ZFZu28ZZx3GNEmeJ7xbZa0d5dtuYLFlttVd/cElsNlzZKZEhy8nWG7CJx4JZC9
 ASmhXJqFQgOGmHKVSkW5xB0yI/Y/p6nq1MSXhjBmhw15RakPus/LbcWz4pkuzBjBLhQs4T
 Nzt8YHCLUlTUuksR6U6uM9yHMLHIE3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655367903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=itIXOH0aAIbGL7InUNnJS6WdfWExWcrXTNpAcWDRgw8=;
 b=IAdqOsCqNAXmJTSg8b+vCNLh2VP5WgALwP7wpYXjf/BuQw5PMr7BK6gujB8xrHb3i+paee
 yz9HIeAaC6/pkJDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61E771344E;
 Thu, 16 Jun 2022 08:25:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lPUXFt/oqmJPLwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jun 2022 08:25:03 +0000
Date: Thu, 16 Jun 2022 10:25:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yqro3cIBVH59YAgt@pevik>
References: <YfPiW998P4/j7RWi@pevik>
 <20220203101803.10204-1-rpalethorpe@suse.com>
 <CAEemH2f6ka-vK+O33cxw1ewMWDYZQwtRZUQ3eKFMkynqB2+R3w@mail.gmail.com>
 <YiDDoly4t0N30kfo@pevik> <Yqh/kqJBv2xgV3O1@pevik>
 <YqiJjYVsrkPgk1fQ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqiJjYVsrkPgk1fQ@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi!
> > as there is another set of fanotify tests for rc kernel, I'd really like to have
> > some policy. Therefore I suggest to stick policy suggested by Richie in this
> > patchset [1], i.e. adding tests into runtest/staging until mainline kernel with
> > this functionality is released (feature is part of the stable kernel ABI).
> > i.e. each kernel release content of this file must be revised and (ideally)
> > moved to particular runtest file where it should belong or fixed (in rare
> > situations when feature changed) or removed (feature was reverted).

> > I volunteer to maintain runtest/staging.

> As long as you commit to maintain the staging you have my ack as well.
Thx! I merged this patch then and I'll merge Amir's fanotify{10,23} tests for
5.19-rc1 kernel.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
