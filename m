Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B44C433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 08:06:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43B843C927E
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 09:06:40 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC54D3C0B90
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 09:06:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D75811A016E0
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 09:06:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B2A601F37E;
 Wed, 22 Dec 2021 08:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640160388;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eUdHTkJ/4me5DjRStvxbPio4MOtpP0R/DFT6euftxm0=;
 b=nPfhtNtjCcptcc/zmlo8yGEtYkGICnhlbVhEXnG3SWBDOtg+mK+UAd/Ml2zXUOt5rXrn2b
 Wcx3VlcUvm6MRXydzPvwe/XH/s2lHD2I2SLVbGvR8sGZSHyK2c7G3FjBYxtZ1YrCg8MSQq
 P8eWMjn9ZVGwzaLui7fGdZ8eUq08Sek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640160388;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eUdHTkJ/4me5DjRStvxbPio4MOtpP0R/DFT6euftxm0=;
 b=X+hDPejCqXyXWm9WVSDXPV/FuJOKkfDuB86F2+ND+5mnzImCEE6TmgmokEL3O/jrt4OVVF
 dgERl7zet2QHxiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8126C13CDA;
 Wed, 22 Dec 2021 08:06:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id liiAHYTcwmErNwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 22 Dec 2021 08:06:28 +0000
Date: Wed, 22 Dec 2021 09:06:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: xuyang2018.jy@fujitsu.com, Li Wang <liwang@redhat.com>
Message-ID: <YcLcgumNvNoqr2XD@pevik>
References: <20211221193500.31950-1-pvorel@suse.cz>
 <61C28CB8.3050209@fujitsu.com>
 <CAEemH2cqTErtNZka8X3L3AgOhy-a2x8fqy1k-QKJWiXc7wA2fA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cqTErtNZka8X3L3AgOhy-a2x8fqy1k-QKJWiXc7wA2fA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Skip tst_{disable,
 enable}_oom_protection() for non-root
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu, Li, all,

> Hi Xu, Petr,

> On Wed, Dec 22, 2021 at 10:26 AM xuyang2018.jy@fujitsu.com <
> xuyang2018.jy@fujitsu.com> wrote:

> > Hi Petr
> > > If needed to set value also for non-root, use set_oom_score_adj().
> > If so, why not rename set_oom_score_adj to tst_set_oom_score_adj and add
> > declartion to tst_memutils.h?


> Yes, it makes sense to expose this function to users to cover
> more oom test scenarios. For instance, set a high (>0) or low (<0)
> score in child_alloc() to verify if OOM-Killer still works well.
> But so far, we don't have such tests.

Sure, I we can do it. But first I'd prefer to fix CI (beware we have last
working day before xmas vacation).

> > ps: also have a word typo in set_oom_score_adj, adjustement => adjustment.
+1, thanks!

Kind regards,
Petr

> > Best Regards
> > Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
