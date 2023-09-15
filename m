Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10417EE644A
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 09:02:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52A093CE6B1
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 11:02:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A587C3CB154
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 11:02:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DC9AA14060C6
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 11:02:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A98F8211F0;
 Fri, 15 Sep 2023 09:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694768529;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iXmjLpLMyjut2o2NNkBRH99mk3RDCU5UtT9D8i3mLIg=;
 b=tmxIrtbMC/5xQjj5bCXTlJ4jRoRSGPqcv4riN0kZOldG1AbMjT0RhzAFssTikbLWBxiLG2
 tXQg8ru2TCBvZe3fhumi1wD0qCE6JOs/Ifh3BhGRZhu+Hbsu0ukGA8HYY+nVBQI+2HuT2t
 M4uYsM7xx/NOFHN/8pUM6tlcqSkFLFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694768529;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iXmjLpLMyjut2o2NNkBRH99mk3RDCU5UtT9D8i3mLIg=;
 b=gTwT5dr4NkmZJV/6Z4l/FS1/H5ezioHrAoFMBV0Lssd5+a4vY/kayBeaN0+8JYQXNpFy7T
 e9wcYpH886keg6Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 668851358A;
 Fri, 15 Sep 2023 09:02:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eaAEGJEdBGXYUwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 15 Sep 2023 09:02:09 +0000
Date: Fri, 15 Sep 2023 11:02:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230915090208.GA30488@pevik>
References: <20230903111558.2603332-1-amir73il@gmail.com>
 <20230903111558.2603332-2-amir73il@gmail.com>
 <ZQQVm5p08PmHRX1A@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZQQVm5p08PmHRX1A@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] fanotify13: Test watching overlayfs upper fs
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> > -	} else {
> > +	} else if (skip) {
> >  		tst_brk_(file, lineno, TBROK | TERRNO,
> >  			"overlayfs mount failed");
> >  	}

> The skip flag should be called strict, at least that is what we usually
> name it, but that is very minor.

> ...

> >  static struct tst_test test = {
> >  	.test = do_test,
> >  	.tcnt = ARRAY_SIZE(test_cases),
> > +	.test_variants = 2,
> >  	.setup = do_setup,
> >  	.cleanup = do_cleanup,
> >  	.needs_root = 1,
> >  	.mount_device = 1,
> > -	.mntpoint = MOUNT_PATH,
> > +	.mntpoint = OVL_BASE_MNTPOINT,
> >  	.all_filesystems = 1,
> >  	.tags = (const struct tst_tag[]) {
> >  		{"linux-git", "c285a2f01d69"},

> The git hash for the regression test with variant=1 should have been
> added here.

> The rest looks good to me. With the two minor issues fixed:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> @Peter Vorel Feel free to push the patch with the two fixes applied.

Thanks for spotting both issues, fixed and merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
