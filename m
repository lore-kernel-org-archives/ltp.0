Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687DBC6FD1C
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 22:08:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF69A3CD5B0
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 23:08:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 635A73C03AE
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 23:08:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AFCDF200978
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 23:08:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3CD7B22ADB;
 Mon, 13 Mar 2023 22:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678745323;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=96CUppxxTSLIs4JUI6tKKB0ihFwd9PtEgDUOOt/WBMA=;
 b=ZNk5ZhwXZrfdIJrJj3Ner0DVQlLsbKgRQHZRmAR5MQnFOIyqv/9JtaH33ujgRm3TRNtdFs
 AUnzTrBYYYqRBH72+QHoPJmkPJszFOpA3Q9/T4RmbZoL5O9U4d1Wog5rLXcDnbSPkQXGzi
 TIVjBsIJgb6KzSz9ka1TmO/gjpRd2jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678745323;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=96CUppxxTSLIs4JUI6tKKB0ihFwd9PtEgDUOOt/WBMA=;
 b=p4CzyakdLfdNhQHE+bDvVvoLqj32stOggPQsTVRWoJS4xV9xWvKYmAe7XVhyEVBhVkzFn7
 KO0SQ8/f/6+1+lAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D44DF13517;
 Mon, 13 Mar 2023 22:08:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1gTiMOqeD2QlOAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Mar 2023 22:08:42 +0000
Date: Mon, 13 Mar 2023 23:08:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <20230313220841.GA24809@pevik>
References: <20230307145517.1359-1-pvorel@suse.cz>
 <20230307145517.1359-3-pvorel@suse.cz> <ZA81c11hvBu4xlsd@yuki>
 <9e05fdea-94f5-c7a2-6bd2-3107f0410e17@redhat.com>
 <20230313153009.GA10305@pevik> <20230313153309.GC10305@pevik>
 <20230313161240.GA11394@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230313161240.GA11394@frogsfrogsfrogs>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Cc: Eric Sandeen <sandeen@redhat.com>, Eric Sandeen <sandeen@sandeen.net>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Mon, Mar 13, 2023 at 04:33:09PM +0100, Petr Vorel wrote:
> > > > On 3/13/23 9:38 AM, Cyril Hrubis wrote:
> > > > > Hi!
> > > > >> XFS since kernel 5.19 postpone certain operation.  Use LTP fsfreeze
> > > > >> implementation to force all the background garbage collection to run
> > > > >> to completion.

> > > > >> Link: https://lore.kernel.org/linux-block/974cc110-d47e-5fae-af5f-e2e610720e2d@redhat.com/
> > > > >> Suggested-by: Eric Sandeen <sandeen@redhat.com>
> > > > >> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > > >> ---
> > > > >>  testcases/commands/df/df01.sh | 7 ++++++-
> > > > >>  1 file changed, 6 insertions(+), 1 deletion(-)

> > > > >> diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
> > > > >> index ae0449c3c..699d1538f 100755
> > > > >> --- a/testcases/commands/df/df01.sh
> > > > >> +++ b/testcases/commands/df/df01.sh
> > > > >> @@ -1,7 +1,7 @@
> > > > >>  #!/bin/sh
> > > > >>  # SPDX-License-Identifier: GPL-2.0-or-later
> > > > >>  # Copyright (c) 2015 Fujitsu Ltd.
> > > > >> -# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
> > > > >> +# Copyright (c) 2018-2023 Petr Vorel <pvorel@suse.cz>
> > > > >>  # Author: Zhang Jin <jy_zhangjin@cn.fujitsu.com>

> > > > >>  # Test df command with some basic options.
> > > > >> @@ -46,6 +46,11 @@ df_test()

> > > > >>  	ROD_SILENT rm -rf $TST_MNTPOINT/testimg

> > > > >> +	# force all the background garbage collection to run to completion
> > > > >> +	if [ "$TST_FS_TYPE" = "xfs" ] && tst_kvcmp -ge "5.19"; then
> > > > >> +		tst_fsfreeze $TST_MNTPOINT
> > > > >> +	fi

> > > > > This looks overly specific, can't we just freeze and unfreeze the FS
> > > > > without looking at kernel version? Or will we get errors on older XFS?

> > > > > I suppose that this may still start to fail on distribution kernels if
> > > > > some of the newer functionality gets backported...

> > > So far it's OK on SLES, likely nothing related has been backported to it.
> > > I wonder if we should remove the check or just wait till first complaint.

> > Well, I haven't seen any problems with older kernels, but I'll retest it more.
> > I don't expect any problems, thus I'm OK with removing it.

> If the fs doesn't support freezing (e.g. tmpfs), you'll get a -1 return
> value and errno == EOPNOTUPP or NOTTY.  Is that going to cause the test
> to fail due to tst_brk?

FYI I haven't noticed any problem so far, but need to test more.

> > Kind regards,
> > Petr

> > > > Yup, I agree. Freeze should be safe for any kernel, I wouldn't condition it either.

> > > > (You do want to be very sure that you're not freezing the root fs, tho,
> > > > if that is any possibility.)

> Why?  Are you worried about not being able to unfreeze the rootfs?
> I know fstests has had problems with people doing:

> xfs_io -c freeze "/$moo"	# whoops, moo is undefined
> <something that blocks>
> xfs_io -c thaw "/$moo"		# never gets here

> But that's not the case here.

Yes, if you mean "/", that's not going to happen ($TST_MNTPOINT is never going
to be "/").  I'm sorry, I mixed up mountpoint (used by fsfreeze and therefore
also tst_fsfreeze.c) and device (=> there shouldn't be a problem).

Kind regards,
Petr

> Even if it is the rootfs, the text page containing the two ioctls should
> be in memory due to the instruction pointer, and even if it gets paged
> out, freezes don't block read faults.

> --D

> > > $TST_MNTPOINT in on $TMPDIR, which is by default /tmp. In case of /tmp being on
> > > root fs we're freezing root tmpfs. But it works on openSUSE, which found the
> > > problem.

> > > Kind regards,
> > > Petr

> > > > -Eric

> > > > > Otherwise it looks good.



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
