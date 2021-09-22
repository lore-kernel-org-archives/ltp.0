Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8605C433FE
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 09:31:37 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 037E760F4C
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 09:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 037E760F4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 882AF3C2178
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 11:31:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 387643C2178
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 11:31:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 72E8D600D71
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 11:31:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9DE5F2221E;
 Wed, 22 Sep 2021 09:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632303084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a5qn7Ou8ETrK5P0Z+VtsgNtYkBYTYetzuA57RUPPEMY=;
 b=ZxiAzWZTWpicfbK0VIIAjDwnay2P/OmbaUtk8jq+zFSgZjm5Oiw4T+3DVelmS/hi/9AyoU
 uqMhr+QpVmCmQo4H0yG9t8+o/z1cvPH3A2Hrph48nUjzGPLzZbg5q0Cl40loS7NAdx8jkN
 dGS1lGUtOtNrisZpEBeSI/fm2Qx/S9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632303084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a5qn7Ou8ETrK5P0Z+VtsgNtYkBYTYetzuA57RUPPEMY=;
 b=F3WBLwLgrU2P5Ru52/cEf70xpis9gS2+ho/N5/d25Z53UYQcwaWPBrTGXRyfFGiuOTvQSl
 fsHcDDUQ0MOOrFAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BFC813D6E;
 Wed, 22 Sep 2021 09:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8dcuEez3SmEINQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 22 Sep 2021 09:31:24 +0000
Date: Wed, 22 Sep 2021 11:31:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YUr4C3VOYI4qtS/F@yuki>
References: <20210920122146.31576-1-chrubis@suse.cz>
 <CAEemH2eRgUDNLmmzNF5cDaAXp7kMgPOBHeJeWqyStOiAq7QLHw@mail.gmail.com>
 <YUnCYvtAZkO/LZIP@yuki>
 <CAEemH2e0kHun++Y2w99N68WAhjFdQkSvkF-1UaDxjbkA1sBrAw@mail.gmail.com>
 <YUrxJfAOO3+B8//7@yuki>
 <CAEemH2d=+h1k62SnVY8Rh=c0UGGEvvTQieW3YgUq8j2Mg6UW=g@mail.gmail.com>
 <YUr1ga3JSak7Gfry@yuki>
 <CAEemH2etot5qBfTWkk3JqRZ1ywTo75M7Vu-ZhXvnQgVqcZovBw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2etot5qBfTWkk3JqRZ1ywTo75M7Vu-ZhXvnQgVqcZovBw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: shell: Fix timeout process races
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > Agreed, that sounds like a great method.
> >
> > Should I send v3 or can I commit v2 with this change?
> >
> 
> V3 please, I will help test it all.

Ok, will send ASAP.

> I just think of setsid(), is that works and better than setpgid(0, 0)?

For moving the process out of the process group setpgid() is enough, we
use it in the lib/tst_test.c for the fork_testrun() in order to track
all children of the test process as well.

I do not think that we need a new session here, that would probably have
strange side effects, for instance it would isolate the tst_timeout_kill
process from the terminal the tests were started in.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
