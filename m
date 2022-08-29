Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAE7ECAAD2
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 16:49:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F5A73CA575
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 18:49:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEB273CA487
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 18:49:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AF57F600780
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 18:49:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5DEDE22CDE;
 Mon, 29 Aug 2022 16:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661791775;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VYwO8SwjpbMVZ9mwLjTHeGuAcz9+TU4Tt2mxEUbJSbY=;
 b=RHmD+dEmWJK85SgBwo1amJ5McXR4j33kcRD0V3LTVdM4dNI02wvOESZkLSpyCgkBQLJMnJ
 zHVoMsIrJiK7OzYBdIvNYhiiprVixI7ya/YTKVuNoyGzQXjw57T21XP5XjpRP73D8QIhUx
 YsbUEPZ2wpX0NXKlnFwVHL7nqhdp/Z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661791775;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VYwO8SwjpbMVZ9mwLjTHeGuAcz9+TU4Tt2mxEUbJSbY=;
 b=3EvCTpuWbFUpZKpbM3+6zI69wFU1VMXoqdV89PkWZg/l9/AokVVv5Gv9asOGDQt5EmfBU4
 omVw9mSawnTOPHBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D914133A6;
 Mon, 29 Aug 2022 16:49:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id c5LQAR/uDGNuKQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 29 Aug 2022 16:49:35 +0000
Date: Mon, 29 Aug 2022 18:49:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "Bird, Tim" <Tim.Bird@sony.com>
Message-ID: <YwzuHaRJC+gUPd63@pevik>
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-2-pvorel@suse.cz>
 <BYAPR13MB2503569ECEDEAC432FBC577BFD769@BYAPR13MB2503.namprd13.prod.outlook.com>
 <Ywzl266wQ89KonEW@pevik>
 <BYAPR13MB250348CBA4E0B0333C5CF54AFD769@BYAPR13MB2503.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR13MB250348CBA4E0B0333C5CF54AFD769@BYAPR13MB2503.namprd13.prod.outlook.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] tst_fs_type: Add nsfs, vfat,
 squashfs to tst_fs_type_name()
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



> > -----Original Message-----
> > From: Petr Vorel <pvorel@suse.cz>
> > Hi Tim,

> > > Minor nit, but the subject line has nsfs when I think it means ntfs.
> > >  -- Tim
> > Thanks, will be fixed in v2.

> > How about XFS using 300 MB vs 16 MB but using different code paths?
> > How big deal it'd be if we require 300 MB in case testing on kernel with XFS
> > enabled and xfsprogs installed?

> > https://lore.kernel.org/ltp/YwyYUzvlxfIGpTwo@yuki/
> > https://lore.kernel.org/ltp/YwyljsgYIK3AvUr+@pevik/

> I'm not personally aware of any uses of XFS in embedded projects, let alone
> ones with a filesystem size of less than 300 MB.  So I think it would be OK.
> Such a test might hit some lightly used codepaths, so it might have more likelihood
> to reveal a bug in XFS.  But if literally no one is using XFS in this configuration,
> I'm not sure how valuable the testing would be.

> That said, my knowledge of the embedded ecosystem is not comprehensive.
> I just posted a question about this on the celinux-dev and Linux-embedded
> mailing lists.  I let you know if I hear of anyone using an XFS filesystem less
> than 300 MB in size in their embedded Linux project or device.
>  -- Tim

Thanks a lot, Tim!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
