Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EE3C433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 14:07:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 154573CA324
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 15:07:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AF9E3CA30B
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 15:07:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 94A9A1000EDA
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 15:07:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E298D1F388;
 Thu,  3 Mar 2022 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646316448;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NQhr5IYmQVaOS1RbI6Ru8vbdrrsag32VvXk5LTmb6Pg=;
 b=BMRV8bvG9v/yEVz/B5kPCvvT+DG3wsRPkvhNanEBk/f5sYtwJjl2ZDnBf2tJQaMo2pUYyP
 UBmS8r5jykXOiao3KoovmAnJSwfgBuPovt6nBJwlECcLgK6gJCOFlHNpdYQXelJJjPwWDF
 RGQOvndApGKNV/Swew/mgG1HdNOyXGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646316448;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NQhr5IYmQVaOS1RbI6Ru8vbdrrsag32VvXk5LTmb6Pg=;
 b=XeqV53ESQaENSQjWRRwORGk1nYbZ144lmaSqSDWczFEuObCn/tiagNz+xjcava1k+P8LLy
 JukqAP9GH4Dq4mAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B002113C35;
 Thu,  3 Mar 2022 14:07:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kdZJKaDLIGK0bgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 03 Mar 2022 14:07:28 +0000
Date: Thu, 3 Mar 2022 15:07:27 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YiDLn3GMNFu482XG@pevik>
References: <20220223200731.1859670-1-yaelt@google.com> <Yh+S7JD2q8oalRoM@yuki>
 <YiBcyvtqTX1CerM4@pevik> <YiC4Pj1sH8UIHY7k@yuki>
 <YiDB7wO3Se/vN15+@pevik> <YiDGvzETiI/nxwW/@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YiDGvzETiI/nxwW/@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
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
Cc: linux-integrity@vger.kernel.org, Yael Tzur <yaelt@google.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

[ Cc Richie, Li, Jan ]

> Hi!
> > > > > I this case I guess that in this case the change is so minimal that we
> > > > > can add this test into LTP once it reaches Linus tree.
> > > > Cyril, maybe we could finally merge our policy (waiting ack for you):
> > > > https://patchwork.ozlabs.org/project/ltp/patch/20220203101803.10204-1-rpalethorpe@suse.com/
> > > > and put keyctl09 into runtest/staging now.

> > > I guess that we still did not agree on exactly how this should be
> > > handled or did we?

> > Isn't it enough "Once a feature is part of the stable kernel ABI the associated
> > test must be moved out of staging." ?

> The main problem is that someone has to make sure that it happens and
> the process would be prone to errors. What I proposed instead was a flag
> that would set a kernel version in which the ABI is going to be merged
> and put the test right into the final runtest files. Then we can simply
> skip the test on older kernels or do anything else we see as a
> reasonable solution. At the same time we can easily add automatic
> checker that would look for these flags in metadata into the CI which
> would, for instance, send email to the ML once the flag is supposed to
> be removed.
OK, you're missing that kernel version. OTOH things get sometimes backported,
thus it's not error prone (if we forget to leave that flag after kernel being
released).

Also version is hard to say if you use maintainer tree (which applies patches on
previous rc1 than what is being in Linus tree). Thus maintainer's tree would be
left, also IMHO next tree has no specific version in uname, thus we'd only
support rc from Linus' tree.

But anyway, if all agree that this is better than both solutions Richie
implemented I'd try to find time to implement it so that we have finally a
solution.

> In this case it does not actually matter, since the test is guarded by a
> kernel config option that is introduced by the patchset and the change
> is fairly miniminal, so I do not think that there would be any changes
> to the ABI anyways.
Correct. At this stage IMHO we can dare to merge it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
