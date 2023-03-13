Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF385C61DA4
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 15:33:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9283C3CAF72
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 16:33:23 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8983C3CAE69
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 16:33:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0AB9460086F
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 16:33:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 452C121116;
 Mon, 13 Mar 2023 15:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678721591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hYwTAA7wKGXCs9WG5nrRgYWPfr+6VFyDlrZ142GMr1M=;
 b=MQ8qHvMd4SgZkNHpzyhJdtfDcj7ENEurYPNFnU8FVC2rPnnELXFf3Xj+8fwukwQ/pLIGJD
 0H83RcRRalgtzfFFhBwH/f1EDxZqtkIVvrHfbYRLPdn2yvzyMKW8lcUuTKOf58dkDkHl+C
 vfCp/h+oeedtwPT18Z88hTR0GesYJ8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678721591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hYwTAA7wKGXCs9WG5nrRgYWPfr+6VFyDlrZ142GMr1M=;
 b=yTXfVVye6dYR+/9wfpt0PapVuVygghE/8m/8FeY/enjBSAu7fXO/4429p/qQbt86UdnwNK
 +QffUUOyVtAoRNAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E58E313517;
 Mon, 13 Mar 2023 15:33:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YBrUNTZCD2ThbwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Mar 2023 15:33:10 +0000
Date: Mon, 13 Mar 2023 16:33:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Eric Sandeen <sandeen@redhat.com>, Cyril Hrubis <chrubis@suse.cz>,
 ltp@lists.linux.it, "Darrick J . Wong" <djwong@kernel.org>,
 Eric Sandeen <sandeen@sandeen.net>
Message-ID: <20230313153309.GC10305@pevik>
References: <20230307145517.1359-1-pvorel@suse.cz>
 <20230307145517.1359-3-pvorel@suse.cz> <ZA81c11hvBu4xlsd@yuki>
 <9e05fdea-94f5-c7a2-6bd2-3107f0410e17@redhat.com>
 <20230313153009.GA10305@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230313153009.GA10305@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] df01.sh: Use tst_fsfreeze for XFS on kernel
 >= 5.19
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > On 3/13/23 9:38 AM, Cyril Hrubis wrote:
> > > Hi!
> > >> XFS since kernel 5.19 postpone certain operation.  Use LTP fsfreeze
> > >> implementation to force all the background garbage collection to run
> > >> to completion.

> > >> Link: https://lore.kernel.org/linux-block/974cc110-d47e-5fae-af5f-e2e610720e2d@redhat.com/
> > >> Suggested-by: Eric Sandeen <sandeen@redhat.com>
> > >> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > >> ---
> > >>  testcases/commands/df/df01.sh | 7 ++++++-
> > >>  1 file changed, 6 insertions(+), 1 deletion(-)

> > >> diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
> > >> index ae0449c3c..699d1538f 100755
> > >> --- a/testcases/commands/df/df01.sh
> > >> +++ b/testcases/commands/df/df01.sh
> > >> @@ -1,7 +1,7 @@
> > >>  #!/bin/sh
> > >>  # SPDX-License-Identifier: GPL-2.0-or-later
> > >>  # Copyright (c) 2015 Fujitsu Ltd.
> > >> -# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
> > >> +# Copyright (c) 2018-2023 Petr Vorel <pvorel@suse.cz>
> > >>  # Author: Zhang Jin <jy_zhangjin@cn.fujitsu.com>

> > >>  # Test df command with some basic options.
> > >> @@ -46,6 +46,11 @@ df_test()

> > >>  	ROD_SILENT rm -rf $TST_MNTPOINT/testimg

> > >> +	# force all the background garbage collection to run to completion
> > >> +	if [ "$TST_FS_TYPE" = "xfs" ] && tst_kvcmp -ge "5.19"; then
> > >> +		tst_fsfreeze $TST_MNTPOINT
> > >> +	fi

> > > This looks overly specific, can't we just freeze and unfreeze the FS
> > > without looking at kernel version? Or will we get errors on older XFS?

> > > I suppose that this may still start to fail on distribution kernels if
> > > some of the newer functionality gets backported...

> So far it's OK on SLES, likely nothing related has been backported to it.
> I wonder if we should remove the check or just wait till first complaint.

Well, I haven't seen any problems with older kernels, but I'll retest it more.
I don't expect any problems, thus I'm OK with removing it.

Kind regards,
Petr

> > Yup, I agree. Freeze should be safe for any kernel, I wouldn't condition it either.

> > (You do want to be very sure that you're not freezing the root fs, tho,
> > if that is any possibility.)

> $TST_MNTPOINT in on $TMPDIR, which is by default /tmp. In case of /tmp being on
> root fs we're freezing root tmpfs. But it works on openSUSE, which found the
> problem.

> Kind regards,
> Petr

> > -Eric

> > > Otherwise it looks good.



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
