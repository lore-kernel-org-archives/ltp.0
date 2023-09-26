Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181B6E7D273
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 10:09:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 634543CDC94
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 12:09:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F6E83C995E
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 12:08:51 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 126FC20470F
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 12:08:50 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5E4906137C;
 Tue, 26 Sep 2023 10:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881B3C433C7;
 Tue, 26 Sep 2023 10:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695722928;
 bh=zykksIGqZoBdbMss/bnZGnUX9BMIwBK5x+gpg5W14as=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rRaakjMgpEzIU6gDUxwG76Bi5f2HsTL0XZeNI102ywyROvfzBjtpc4k2HZWBFyT4L
 FzXDLZYEEGXnlz7m/uWijbHp6+LPAFHvSm6eeX2MJjA1yRZzuwJpK/gR0VFO8JT47j
 pRo+iE9U/2JJzL9vu0fAA59mObN5WNU24L8Azja1XQxW2MNLp40MEwUpxvCC35QDlt
 p2oGqCnXMAe72rOqTEVqPLotw2zHcJOwLHZnVKKlet02oo9P+0CglrUmZZM7TUJeRd
 tYmjjvFbUR4JLamFpMyZ5dLyPZtN2X9JyeuxVDJ9rVfJf0qQJXhcsFvj5nJjx0+UCK
 ykkDFeoibXl0w==
Date: Tue, 26 Sep 2023 12:08:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20230926-leinen-kaltlassen-b5cef5a1e877@brauner>
References: <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
 <ZRBHSACF5NdZoQwx@casper.infradead.org>
 <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
 <ZRCwjGSF//WUPohL@casper.infradead.org>
 <CAD_8n+SBo4EaU4-u+DaEFq3Bgii+vX0JobsqJV-4m+JjY9wq8w@mail.gmail.com>
 <ZREr3M32aIPfdem7@casper.infradead.org>
 <CAOQ4uxgUC2KxO2fD-rSgVo3RyrrWbP-UHH+crG57uwXVn_sf2Q@mail.gmail.com>
 <CAD_8n+QeGwf+CGNW_WnyRNQMu9G2_HJ4RSwJGq-b4CERpaA4uQ@mail.gmail.com>
 <CAOQ4uxh7+avP=m8DW_u14Ea4Hrk1xhyuT--t2XX868CBquOCaA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh7+avP=m8DW_u14Ea4Hrk1xhyuT--t2XX868CBquOCaA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, Jan Kara <jack@suse.cz>, lkp@intel.com,
 Matthew Wilcox <willy@infradead.org>, oe-lkp@lists.linux.dev,
 kernel test robot <oliver.sang@intel.com>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, Reuben Hawkins <reubenhwk@gmail.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> What you are saying makes sense.
> And if we are being honest, I think that the right thing to do from the
> beginning was to separate the bug fix commit from the UAPI change.
> 
> The minimal bug fix is S_ISREG || S_ISBLK, which
> mentions the Fixes commit and will be picked for stable kernels.
> 
> Following up with another one or two patches that change
> the behavior of posix_fadvise on socket and readahead on
> socket and pipe.
> 
> The UAPI change is not something that has to go to stable
> and it should be easily revertable independently of the bug fix.
> Doing it otherwise would make our lives much harder if regressions
> turn up from the UAPI change.
> 
> Christian, Matthew,
> 
> Do you agree?

Fine by me.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
